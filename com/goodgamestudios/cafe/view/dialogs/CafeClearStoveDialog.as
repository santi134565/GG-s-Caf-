package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class CafeClearStoveDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeClearStoveDialog";
       
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeClearStoveDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.clearStoveDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_clearstove_title");
         this.clearStoveDialog.btn_cancel.label = CafeModel.languageData.getTextById("dialogwin_clearstove_btn_cancel");
         this.clearStoveDialog.btn_ok.label = CafeModel.languageData.getTextById("dialogwin_clearstove_btn_ok");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(tutorialController.isActive)
         {
            if(param1.target != this.clearStoveDialog.btn_instantcook)
            {
               return;
            }
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_COOK,[this.cafeClearStoveDialogProperties.target.isoGridPos.x,this.cafeClearStoveDialogProperties.target.isoGridPos.y,this.cafeClearStoveDialogProperties.target.currentDish.wodId,1,0]);
            tutorialController.nextStep();
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.clearStoveDialog.btn_cancel:
               hide();
               break;
            case this.clearStoveDialog.btn_ok:
               if(!this.isWaitingForServerMessage)
               {
                  this.isWaitingForServerMessage = true;
                  if(this.cafeClearStoveDialogProperties.target.currentStatus == BasicStove.STOVE_STATUS_COOKING)
                  {
                     controller.sendServerMessageAndWait(SFConstants.C2S_CAFE_CLEAN,[this.cafeClearStoveDialogProperties.target.isoGridPos.x,this.cafeClearStoveDialogProperties.target.isoGridPos.y],SFConstants.S2C_CAFE_CLEAN);
                  }
                  else
                  {
                     hide();
                  }
               }
               break;
            case this.clearStoveDialog.btn_instantcook:
               if(!this.isWaitingForServerMessage && this.clearStoveDialog.btn_instantcook.enabled)
               {
                  this.isWaitingForServerMessage = true;
                  if(this.cafeClearStoveDialogProperties.target.currentStatus == BasicStove.STOVE_STATUS_COOKING)
                  {
                     controller.sendServerMessageAndWait(SFConstants.C2S_CAFE_INSTANTCOOK,[this.cafeClearStoveDialogProperties.target.isoGridPos.x,this.cafeClearStoveDialogProperties.target.isoGridPos.y],SFConstants.S2C_CAFE_INSTANTCOOK);
                  }
                  else
                  {
                     hide();
                  }
               }
         }
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_CAFE_INSTANTCOOK || param1 == SFConstants.S2C_CAFE_CLEAN)
         {
            this.isWaitingForServerMessage = false;
            hide();
         }
      }
      
      override public function show() : void
      {
         super.show();
         var _loc1_:int = Math.floor(this.cafeClearStoveDialogProperties.target.cookTimeLeft(getTimer()) / 1000 / 3600 / CafeConstants.instantCookHourPerGold);
         var _loc2_:int = 1 + _loc1_;
         if(tutorialController.tutorialState == CafeTutorialController.TUT_STATE_COOK_INSTANT_COOK2)
         {
            this.clearStoveDialog.btn_instantcook.addChild(tutorialController.mc_tutotialArrow);
            tutorialController.mc_tutotialArrow.scaleX = -1;
            tutorialController.mc_tutotialArrow.x = -30;
            _loc2_ = 1;
         }
         this.isWaitingForServerMessage = false;
         this.clearStoveDialog.btn_instantcook.txt_instantCookPrice.text = "x" + String(_loc2_);
         if(CafeModel.userData.canInstaCook)
         {
            this.clearStoveDialog.btn_instantcook.enableButton = true;
            this.clearStoveDialog.btn_instantcook.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.clearStoveDialog.btn_instantcook.name);
            this.clearStoveDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_clearstove_copy",[CafeModel.userData.instaCookLeft]);
         }
         else
         {
            this.clearStoveDialog.txt_copy.text = "";
            this.clearStoveDialog.btn_instantcook.enableButton = false;
            if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_INSTANTCOOKING && !tutorialController.isActive)
            {
               this.clearStoveDialog.btn_instantcook.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_INSTANTCOOKING]);
            }
            else
            {
               this.clearStoveDialog.btn_instantcook.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.clearStoveDialog.btn_instantcook.name + "_na");
            }
         }
      }
      
      protected function get cafeClearStoveDialogProperties() : CafeClearStoveDialogProperties
      {
         return properties as CafeClearStoveDialogProperties;
      }
      
      protected function get clearStoveDialog() : CafeClearStove
      {
         return disp as CafeClearStove;
      }
   }
}
