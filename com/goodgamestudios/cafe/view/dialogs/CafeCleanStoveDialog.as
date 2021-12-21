package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.moving.BasicMoving;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeCleanStoveDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeCleanStoveDialog";
       
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeCleanStoveDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.cleanStoveDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_refreshfood_title");
         this.cleanStoveDialog.btn_clean.label = CafeModel.languageData.getTextById("dialogwin_refreshfood_btn_clean");
         this.cleanStoveDialog.btn_refresh.toolTipText = CafeModel.languageData.getTextById("dialogwin_refreshfood_btn_refresh");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:BasicStove = null;
         super.onClick(param1);
         switch(param1.target)
         {
            case this.cleanStoveDialog.btn_clean:
               _loc2_ = this.cafeCleanStoveDialogProperties.target as BasicStove;
               _loc2_.cleaningStart();
               layoutManager.isoScreen.isoWorld.myPlayer.setAniState(BasicMoving.ANIM_STATUS_WORK);
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_CLEAN,[_loc2_.stoveVO.isoPos.x,_loc2_.stoveVO.isoPos.y]);
               CafeModel.userData.startRefereshPopupTimer(_loc2_.currentDish.wodId);
               hide();
               break;
            case this.cleanStoveDialog.btn_refresh:
               if(!this.isWaitingForServerMessage)
               {
                  this.isWaitingForServerMessage = true;
                  controller.sendServerMessageAndWait(SFConstants.C2S_CAFE_RECOOK,[this.cafeCleanStoveDialogProperties.target.stoveVO.isoPos.x,this.cafeCleanStoveDialogProperties.target.stoveVO.isoPos.y],SFConstants.S2C_CAFE_RECOOK);
               }
         }
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_CAFE_RECOOK)
         {
            this.isWaitingForServerMessage = false;
            hide();
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.cleanStoveDialog.btn_refresh.txt_instantCookPrice.text = "x" + String(CafeConstants.refreshFoodCost);
      }
      
      protected function get cafeCleanStoveDialogProperties() : CafeCleanStoveDialogProperties
      {
         return properties as CafeCleanStoveDialogProperties;
      }
      
      protected function get cleanStoveDialog() : CafeCleanStove
      {
         return disp as CafeCleanStove;
      }
   }
}
