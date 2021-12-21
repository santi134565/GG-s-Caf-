package com.goodgamestudios.cafe.world.objects.background
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.event.CafeMinigameEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeWheelOfFortuneDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeWheelOfFortuneDialogProperties;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MarketplaceBackground extends StaticBackground
   {
       
      
      private var btn_noticeBoard:MovieClip;
      
      private var btn_wheelOfFortune:MovieClip;
      
      private var btn_shop1:MovieClip;
      
      private var btn_shop2:MovieClip;
      
      public function MarketplaceBackground()
      {
         super();
         isClickable = true;
      }
      
      override public function removeDispFromWorld() : void
      {
         if(this.btn_noticeBoard)
         {
            resetInteractiveItem(this.btn_noticeBoard);
         }
         if(this.btn_wheelOfFortune)
         {
            resetInteractiveItem(this.btn_wheelOfFortune);
         }
         if(this.btn_shop1)
         {
            resetInteractiveItem(this.btn_shop1);
         }
         if(this.btn_shop2)
         {
            resetInteractiveItem(this.btn_shop2);
         }
         if(BasicController.getInstance().hasEventListener(CafeMinigameEvent.WHEELOFFORTUNE))
         {
            BasicController.getInstance().removeEventListener(CafeMinigameEvent.WHEELOFFORTUNE,this.onWOFevent);
         }
         super.removeDispFromWorld();
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         if(disp.hasOwnProperty("btn_noticeBoard"))
         {
            this.btn_noticeBoard = disp["btn_noticeBoard"];
            this.btn_noticeBoard.filters = [glowfilter];
            initInteractiveItem(this.btn_noticeBoard);
         }
         if(disp.hasOwnProperty("btn_wheelOfFortune"))
         {
            this.btn_wheelOfFortune = disp["btn_wheelOfFortune"];
            if(CafeModel.userData.playedWheelOfFortune)
            {
               disp["wheelOfFortune_ToolTip"].gotoAndStop(2);
            }
            initInteractiveItem(this.btn_wheelOfFortune);
            disp["wheelOfFortune_ToolTip"].visible = false;
            disp["wheelOfFortune_ToolTip"].mouseEnabled = false;
            disp["wheelOfFortune_ToolTip"].mouseChildren = false;
            disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine1.text = CafeModel.languageData.getTextById("wheeloffortunetooltip_line1");
            updateTextField(disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine1);
            if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_WHEELOFFORTUNE)
            {
               disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine2.text = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_WHEELOFFORTUNE]);
               updateTextField(disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine2);
               if(disp["wheelOfFortune_ToolTip"].currentFrame == 1)
               {
                  disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine3.text = "";
               }
            }
            else
            {
               disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine2.text = CafeModel.languageData.getTextById("wheeloffortunetooltip_line2");
               updateTextField(disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine2);
               if(disp["wheelOfFortune_ToolTip"].currentFrame == 1)
               {
                  disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine3.text = CafeModel.languageData.getTextById("wheeloffortunetooltip_line3");
                  updateTextField(disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine3);
                  BasicController.getInstance().addEventListener(CafeMinigameEvent.WHEELOFFORTUNE,this.onWOFevent);
               }
            }
         }
      }
      
      private function onWOFevent(param1:CafeMinigameEvent) : void
      {
         disp["wheelOfFortune_ToolTip"].gotoAndStop(2);
         disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine1.text = CafeModel.languageData.getTextById("wheeloffortunetooltip_line1");
         updateTextField(disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine1);
         disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine2.text = CafeModel.languageData.getTextById("wheeloffortunetooltip_line2");
         updateTextField(disp["wheelOfFortune_ToolTip"].txt_spoiledInfoLine2);
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         if(CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_DEKO_SHOP)
         {
            return;
         }
         if(param1.target == this.btn_wheelOfFortune)
         {
            disp["wheelOfFortune_ToolTip"].visible = true;
            this.btn_wheelOfFortune.filters = [glowfilter];
         }
         super.onRollOver(param1);
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         if(param1.target == this.btn_wheelOfFortune)
         {
            disp["wheelOfFortune_ToolTip"].visible = false;
            this.btn_wheelOfFortune.filters = [];
         }
         super.onRollOut(param1);
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.btn_noticeBoard:
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.MARKETPLACE_CLICK,[CafeIsoEvent.MARKETPLACE_NOTICEBOARD]));
               break;
            case this.btn_wheelOfFortune:
               if(CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_WHEELOFFORTUNE)
               {
                  CafeLayoutManager.getInstance().showDialog(CafeWheelOfFortuneDialog.NAME,new CafeWheelOfFortuneDialogProperties(!CafeModel.userData.playedWheelOfFortune,0));
               }
               break;
            case this.btn_shop1:
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.MARKETPLACE_CLICK,[CafeIsoEvent.MARKETPLACE_SHOP]));
               break;
            case this.btn_shop2:
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.MARKETPLACE_CLICK,[CafeIsoEvent.MARKETPLACE_SHOP]));
         }
      }
   }
}
