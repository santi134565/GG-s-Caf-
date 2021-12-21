package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialogProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.utils.Timer;
   
   public class CafeUserStatePanel extends CafePanel
   {
      
      public static const NAME:String = "CafeUserStatePanel";
       
      
      private const GLOWTIME:int = 300;
      
      private const PAYMENTTIME:int = 6000;
      
      private var glowfilter:GlowFilter;
      
      private var glowTimer:Timer;
      
      private var bonusPaymentTimer:Timer;
      
      public function CafeUserStatePanel(param1:DisplayObject)
      {
         this.glowfilter = new GlowFilter(16777215,0.8,16,16,3);
         super(param1);
      }
      
      override protected function init() : void
      {
         this.glowTimer = new Timer(this.GLOWTIME,1);
         this.glowTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onGlowEnd);
         this.bonusPaymentTimer = new Timer(this.PAYMENTTIME,1);
         this.bonusPaymentTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onShowBubble);
         controller.addEventListener(CafeUserEvent.CHANGE_USERDATA,this.onChangeUserData);
         controller.addEventListener(CafeUserEvent.CHANGE_JOBAMOUNT,this.onChangeUserData);
         controller.addEventListener(CafeUserEvent.INIT_USERDATA,this.onChangeUserData);
         controller.addEventListener(CafeUserEvent.PAYMENTBONUS,this.onStartBonusPayment);
         this.userStatePanel.btn_adddollar.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.userStatePanel.btn_adddollar.name);
         this.userStatePanel.mc_jobs.btn_refill.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.userStatePanel.mc_jobs.btn_refill.name);
         this.userStatePanel.mc_jobs.btn_refill.txt_label.text = "x " + CafeConstants.jobRefillGold;
         this.userStatePanel.btn_adddollar.visible = env.usePayment;
         this.userStatePanel.mc_bonusTip.visible = false;
         this.userStatePanel.mc_bonusText.visible = false;
         if(CafeModel.sessionData.activeSpecialOffer && env.usePayment)
         {
            this.showBonusPaymentBonusTip();
         }
         this.onChangeUserData(null);
         super.init();
      }
      
      private function onStartBonusPayment(param1:CafeUserEvent) : void
      {
         if(CafeModel.sessionData.activeSpecialOffer && env.usePayment && !this.bonusPaymentTimer.running)
         {
            this.showBonusPaymentBonusTip();
         }
      }
      
      private function showBonusPaymentBonusTip() : void
      {
         this.userStatePanel.mc_bonusText.visible = true;
         if(CafeModel.sessionData.regBonus)
         {
            this.userStatePanel.mc_bonusTip.txt_copy.text = CafeModel.languageData.getTextById("generic_payment_48hdiscount_button",[CafeModel.sessionData.specialOffer_Gold]);
         }
         else
         {
            this.userStatePanel.mc_bonusTip.txt_copy.text = CafeModel.languageData.getTextById("generic_payment_discount_button",[CafeModel.sessionData.specialOffer_Gold]);
         }
         this.bonusPaymentTimer.start();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.glowTimer.stop();
         this.bonusPaymentTimer.stop();
         this.glowTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onGlowEnd);
         this.bonusPaymentTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onShowBubble);
         controller.removeEventListener(CafeUserEvent.CHANGE_USERDATA,this.onChangeUserData);
         controller.removeEventListener(CafeUserEvent.INIT_USERDATA,this.onChangeUserData);
         controller.removeEventListener(CafeUserEvent.CHANGE_JOBAMOUNT,this.onChangeUserData);
         controller.removeEventListener(CafeUserEvent.PAYMENTBONUS,this.onStartBonusPayment);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.userStatePanel.btn_adddollar:
               if(CafeModel.userData.isGuest())
               {
                  layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
               }
               else
               {
                  controller.addExtraGold();
               }
               break;
            case this.userStatePanel.mc_jobs.btn_refill:
               if(CafeModel.userData.isGuest())
               {
                  layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
               }
               else if(CafeModel.userData.heroVO.openJobs < CafeConstants.jobsPerDay)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_MARKETPLACE_JOBREFILL,[]);
               }
         }
      }
      
      private function onChangeUserData(param1:CafeUserEvent) : void
      {
         this.userStatePanel.txt_gold.text = NumberStringHelper.groupString(CafeModel.userData.gold,CafeModel.languageData.getTextById);
         this.userStatePanel.txt_cash.text = NumberStringHelper.groupString(CafeModel.userData.cash,CafeModel.languageData.getTextById);
         this.userStatePanel.txt_xp.text = NumberStringHelper.groupString(CafeModel.userData.userXP,CafeModel.languageData.getTextById);
         this.userStatePanel.txt_level.text = NumberStringHelper.groupString(CafeModel.userData.userLevel,CafeModel.languageData.getTextById);
         this.userStatePanel.mc_jobs.txt_openJobs.text = CafeModel.userData.heroVO.openJobs + " / " + CafeConstants.jobsPerDay;
         this.userStatePanel.xpMouseOverlay.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.userStatePanel.xpMouseOverlay.name,[NumberStringHelper.groupString(CafeModel.userData.xpToNextLevel,CafeModel.languageData.getTextById)]);
         if(param1 && param1.params)
         {
            this.startGlow(param1.params);
            if(this.glowTimer.running)
            {
               this.glowTimer.stop();
            }
            this.glowTimer.start();
         }
         this.userStatePanel.mc_jobs.visible = CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_JOBS;
         this.userStatePanel.mc_progressBarStatus.scaleX = CafeModel.userData.xpToNextLevelPercent;
      }
      
      private function startGlow(param1:Array) : void
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(_loc2_ == CafeConstants.WODID_CASH)
            {
               this.userStatePanel.mc_cash.filters = [this.glowfilter];
            }
            if(_loc2_ == CafeConstants.WODID_GOLD)
            {
               this.userStatePanel.mc_gold.filters = [this.glowfilter];
            }
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.userStatePanel.btn_adddollar.selected();
      }
      
      private function onGlowEnd(param1:TimerEvent) : void
      {
         this.glowTimer.stop();
         this.userStatePanel.mc_cash.filters = null;
         this.userStatePanel.mc_gold.filters = null;
      }
      
      private function onShowBubble(param1:TimerEvent) : void
      {
         if(this.bonusPaymentTimer.running)
         {
            this.bonusPaymentTimer.stop();
         }
         this.userStatePanel.mc_bonusTip.visible = !this.userStatePanel.mc_bonusTip.visible;
         this.bonusPaymentTimer.start();
      }
      
      protected function get userStatePanel() : UserStatePanel
      {
         return disp as UserStatePanel;
      }
   }
}
