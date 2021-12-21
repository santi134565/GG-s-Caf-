package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafePanelEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafePaymentTeaserDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafePaymentTeaserDialogProperties;
   import com.goodgamestudios.constants.CommonGameStates;
   
   public class SOECommand extends CafeCommand
   {
       
      
      public function SOECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SPECIAL_OFFER_EVENT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = false;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = param2.shift();
            _loc4_ = param2.shift();
            _loc5_ = param2.shift();
            _loc6_ = param2.shift() == 1;
            if(env.gameState == CommonGameStates.SMARTFOX_LOGIN || env.gameState == CommonGameStates.LOGIN_SCREEN)
            {
               CafeModel.sessionData.specialOffer_Gold = _loc3_;
               controller.dispatchEvent(new CafePanelEvent(CafePanelEvent.TEASER_ON_LOGINPANEL,[_loc3_]));
            }
            else
            {
               layoutManager.showDialog(CafePaymentTeaserDialog.NAME,new CafePaymentTeaserDialogProperties(_loc3_,_loc4_,_loc5_,_loc6_));
               CafeModel.sessionData.specialOffer_Cash = _loc4_;
               CafeModel.sessionData.specialOffer_Gold = _loc3_;
               CafeModel.sessionData.specialOffer_Delay = _loc5_;
               CafeModel.sessionData.regBonus = _loc6_;
               CafeModel.sessionData.initLoggedinTime(0);
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.PAYMENTBONUS));
            }
            return true;
         }
         return false;
      }
   }
}
