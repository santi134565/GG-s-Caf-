package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.event.CafeGiftEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeAchievementDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAchievementDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeCookBookDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCookBookDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeCoopDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCoopDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeGiftboxDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeGiftboxDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeIngredientShopDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeIngredientShopDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStaffDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStaffDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardYesNoDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CafeActionPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeActionPanel";
       
      
      private var isWaitingForServerMessage:Boolean = false;
      
      public function CafeActionPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         this.actionPanel.gotoAndStop(2);
         controller.addEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.initButtons);
         controller.addEventListener(CafeGiftEvent.CHANGE_MYGIFTS,this.onChangeGifts);
         controller.addEventListener(CafeUserEvent.LEVELUP,this.initButtons);
         this.initButtons(null);
         if(CafeModel.giftList.numGifts > 0)
         {
            this.onChangeGifts(null);
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.initButtons);
         controller.removeEventListener(CafeGiftEvent.CHANGE_MYGIFTS,this.onChangeGifts);
         controller.removeEventListener(CafeUserEvent.LEVELUP,this.initButtons);
      }
      
      private function initButtons(param1:Event) : void
      {
         this.actionPanel.btn_decoshop.enableButton = layoutManager.currentState == CafeLayoutManager.STATE_MY_CAFE;
         this.actionPanel.btn_decoshop.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_decoshop.name);
         this.actionPanel.btn_cookbook.enableButton = layoutManager.currentState == CafeLayoutManager.STATE_MY_CAFE;
         this.actionPanel.btn_cookbook.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_cookbook.name);
         this.actionPanel.btn_ingredientshop.enableButton = layoutManager.currentState == CafeLayoutManager.STATE_MY_CAFE;
         this.actionPanel.btn_ingredientshop.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_ingredientshop.name);
         this.actionPanel.btn_achievements.enableButton = true;
         this.actionPanel.btn_achievements.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_achievements.name);
         this.actionPanel.btn_owncafe.enableButton = layoutManager.currentState != CafeLayoutManager.STATE_MY_CAFE;
         this.actionPanel.btn_owncafe.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_owncafe.name);
         this.actionPanel.btn_decoshop.mc_new.visible = CafeModel.inventoryFurniture.numNew > 0;
         TextFieldHelper.changeTextFromatSizeByTextWidth(10,this.actionPanel.btn_decoshop.mc_new.txt_label,"x" + CafeModel.inventoryFurniture.numNew,1);
         if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_PERSONAL)
         {
            this.actionPanel.btn_staff.enableButton = false;
            this.actionPanel.btn_staff.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_PERSONAL]);
         }
         else
         {
            this.actionPanel.btn_staff.enableButton = layoutManager.currentState == CafeLayoutManager.STATE_MY_CAFE;
            this.actionPanel.btn_staff.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_staff.name);
         }
         if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_MARKETPLACE)
         {
            this.actionPanel.btn_market.enableButton = false;
            this.actionPanel.btn_market.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_MARKETPLACE]);
         }
         else
         {
            this.actionPanel.btn_market.enableButton = layoutManager.currentState != CafeLayoutManager.STATE_MARKETPLACE;
            this.actionPanel.btn_market.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_market.name);
         }
         if(this.actionPanel.btn_coop)
         {
            this.actionPanel.btn_coop.visible = true;
            if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_COOPS)
            {
               this.actionPanel.btn_coop.enableButton = false;
               this.actionPanel.btn_coop.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_COOPS]);
            }
            else
            {
               this.actionPanel.btn_coop.enableButton = true;
               this.actionPanel.btn_coop.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_coop.name);
            }
         }
         if(this.actionPanel.btn_gifts)
         {
            if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_PRESENTS)
            {
               this.actionPanel.btn_gifts.enableButton = false;
               this.actionPanel.btn_gifts.mc_new.visible = false;
               this.actionPanel.btn_gifts.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_PRESENTS]);
            }
            else
            {
               this.actionPanel.btn_gifts.enableButton = layoutManager.currentState == CafeLayoutManager.STATE_MY_CAFE;
               this.actionPanel.btn_gifts.mc_new.visible = CafeModel.giftList.numNewGifts > 0;
               TextFieldHelper.changeTextFromatSizeByTextWidth(10,this.actionPanel.btn_gifts.mc_new.txt_label,"x" + CafeModel.giftList.numNewGifts,1);
               this.actionPanel.btn_gifts.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_gifts.name);
               if(CafeModel.giftList.numGifts > 0)
               {
                  this.onChangeGifts(null);
               }
            }
         }
      }
      
      private function onChangeGifts(param1:CafeGiftEvent) : void
      {
         if(this.actionPanel.btn_gifts)
         {
            this.actionPanel.btn_gifts.enableButton = layoutManager.currentState == CafeLayoutManager.STATE_MY_CAFE;
            this.actionPanel.btn_gifts.mc_new.visible = CafeModel.giftList.numGifts > 0;
            if(CafeModel.giftList.numGifts > 9)
            {
               this.actionPanel.btn_gifts.mc_new.txt_label.text = "" + CafeModel.giftList.numGifts;
            }
            else
            {
               this.actionPanel.btn_gifts.mc_new.txt_label.text = "x" + CafeModel.giftList.numGifts;
            }
            this.actionPanel.btn_gifts.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.actionPanel.btn_gifts.name);
         }
         this.actionPanel.btn_decoshop.mc_new.visible = CafeModel.inventoryFurniture.numNew > 0;
         TextFieldHelper.changeTextFromatSizeByTextWidth(10,this.actionPanel.btn_decoshop.mc_new.txt_label,"x" + CafeModel.inventoryFurniture.numNew,1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(isLocked || this.isWaitingForServerMessage)
         {
            return;
         }
         if(!(param1.target is BasicButton) || !(param1.target as BasicButton).enabled)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.actionPanel.btn_coop:
               layoutManager.showDialog(CafeCoopDialog.NAME,new CafeCoopDialogProperties());
               break;
            case this.actionPanel.btn_gifts:
               CafeModel.giftList.numNewGifts = 0;
               layoutManager.showDialog(CafeGiftboxDialog.NAME,new CafeGiftboxDialogProperties());
               break;
            case this.actionPanel.btn_decoshop:
               this.actionPanel.btn_decoshop.mc_new.visible = false;
               if(CafeModel.otherUserData.numberOfWaiter > 0)
               {
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_dekoshop_humanwaiter_title"),CafeModel.languageData.getTextById("alert_dekoshop_humanwaiter_copy"),null));
               }
               else if(CafeModel.otherUserData.numberOfOtherUser > 1)
               {
                  layoutManager.showDialog(CafeStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("alert_dekoshop_kickplayer_title"),CafeModel.languageData.getTextById("alert_dekoshop_kickplayer_copy"),this.onShowDekoShop,null,null,CafeModel.languageData.getTextById("btn_text_yes"),CafeModel.languageData.getTextById("btn_text_no")));
               }
               else
               {
                  this.onShowDekoShop();
               }
               break;
            case this.actionPanel.btn_cookbook:
               layoutManager.showDialog(CafeCookBookDialog.NAME,new CafeCookBookDialogProperties());
               break;
            case this.actionPanel.btn_ingredientshop:
               layoutManager.showDialog(CafeIngredientShopDialog.NAME,new CafeIngredientShopDialogProperties());
               break;
            case this.actionPanel.btn_staff:
               layoutManager.showDialog(CafeStaffDialog.NAME,new CafeStaffDialogProperties());
               break;
            case this.actionPanel.btn_market:
               if(layoutManager.isoScreen.isoWorld.myPlayer.isWorking)
               {
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")));
               }
               else
               {
                  this.isWaitingForServerMessage = true;
                  controller.sendServerMessageAndWait(SFConstants.C2S_MARKETPLACE_JOIN,[],SFConstants.S2C_MARKETPLACE_JOIN);
               }
               break;
            case this.actionPanel.btn_owncafe:
               if(layoutManager.isoScreen.isoWorld.myPlayer.isWorking)
               {
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")));
               }
               else
               {
                  this.isWaitingForServerMessage = true;
                  controller.sendServerMessageAndWait(SFConstants.C2S_JOIN_CAFE,[CafeModel.userData.userID,CafeModel.userData.playerID],SFConstants.S2C_JOIN_CAFE);
               }
               break;
            case this.actionPanel.btn_achievements:
               layoutManager.showDialog(CafeAchievementDialog.NAME,new CafeAchievementDialogProperties(CafeModel.userData.playerID,CafeModel.userData.userID));
         }
      }
      
      private function onShowDekoShop(param1:Array = null) : void
      {
         layoutManager.isoScreen.isoWorld.doAction(CafeIsoWorld.DEKOMODE_START);
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         switch(param1)
         {
            case SFConstants.S2C_JOIN_CAFE:
            case SFConstants.S2C_MARKETPLACE_JOIN:
               this.isWaitingForServerMessage = false;
         }
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         if(disp && disp.stage)
         {
            _loc1_ = disp.getBounds(null);
            disp.y = disp.stage.stageHeight;
            disp.x = disp.stage.stageWidth;
            if(env.hasNetworkBuddies)
            {
               disp.y -= CafeBuddylistPanel.BUDDY_PANEL_HEIGHT;
            }
         }
      }
      
      protected function get actionPanel() : ActionPanel
      {
         return disp as ActionPanel;
      }
   }
}
