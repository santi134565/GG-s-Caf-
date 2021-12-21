package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.model.components.BasicSessionData;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafePaymentTeaserDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafePaymentTeaserDialogProperties;
   import com.goodgamestudios.math.MathBase;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CafeSessionData extends BasicSessionData
   {
       
      
      public var activeSpecialOffer:Boolean;
      
      public var specialOffer_Cash:int;
      
      public var specialOffer_Gold:int;
      
      public var specialOffer_Delay:int;
      
      public var regBonus:Boolean = false;
      
      private var OFFER_INTERVAL:int = 7200000.0;
      
      public function CafeSessionData()
      {
         super();
         this.activeSpecialOffer = false;
      }
      
      public function resetSpecialOffers() : void
      {
         this.activeSpecialOffer = false;
         this.specialOffer_Cash = 0;
         this.specialOffer_Gold = 0;
         this.specialOffer_Delay = 0;
         this.regBonus = false;
      }
      
      override public function initLoggedinTime(param1:Number, param2:Number = 60000) : void
      {
         this.activeSpecialOffer = true;
         _loggedinTime = param1;
         resetLoggedinTimer();
         _loggedinTimer = new Timer(this.OFFER_INTERVAL,1);
         _loggedinTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onLoggedinMessageTimerComplete);
         _loggedinTimer.start();
      }
      
      override protected function onLoggedinMessageTimerComplete(param1:TimerEvent) : void
      {
         _loggedinTimer.reset();
         _loggedinTime += this.OFFER_INTERVAL;
         this.specialOffer_Delay = MathBase.max(0,this.specialOffer_Delay - this.OFFER_INTERVAL / 1000);
         if(CafeLayoutManager.getInstance().inGameState)
         {
            CafeLayoutManager.getInstance().showDialog(CafePaymentTeaserDialog.NAME,new CafePaymentTeaserDialogProperties(this.specialOffer_Gold,this.specialOffer_Cash,this.specialOffer_Delay,this.regBonus));
         }
         _loggedinTimer.start();
      }
      
      public function isEventKnown(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<int> = CafeModel.localData.readKnownEvents();
         for each(_loc3_ in _loc2_)
         {
            if(param1 == _loc3_)
            {
               return true;
            }
         }
         return false;
      }
   }
}
