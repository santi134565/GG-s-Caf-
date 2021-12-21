package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class CafeInstantCookingDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeInstantCookingDialog";
       
      
      public function CafeInstantCookingDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.instantDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_instantcooking_copy",[CafeModel.userData.instaCookLeft]);
         this.instantDialog.btn_no.label = CafeModel.languageData.getTextById("btn_text_no");
         var _loc1_:int = Math.floor(this.instantDialogProperties.stove.cookTimeLeft(getTimer() + 100) / 1000 / 3600 / CafeConstants.instantCookHourPerGold);
         var _loc2_:int = 1 + _loc1_;
         this.instantDialog.btn_cook.txt_instantCookPrice.text = "x" + _loc2_;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.instantDialog.btn_close:
               hide();
               CafeModel.userData.startInstantPopupTimer(this.instantDialogProperties.stove.currentDish.wodId);
               break;
            case this.instantDialog.btn_cook:
               hide();
               if(this.instantDialogProperties.stove.currentStatus == BasicStove.STOVE_STATUS_COOKING)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_INSTANTCOOK,[this.instantDialogProperties.stove.isoGridPos.x,this.instantDialogProperties.stove.isoGridPos.y]);
               }
               break;
            case this.instantDialog.btn_no:
               hide();
               CafeModel.userData.startInstantPopupTimer(this.instantDialogProperties.stove.currentDish.wodId);
         }
      }
      
      protected function get instantDialogProperties() : CafeInstantCookingDialogProperties
      {
         return properties as CafeInstantCookingDialogProperties;
      }
      
      private function get instantDialog() : CafeInstantCooking
      {
         return disp as CafeInstantCooking;
      }
   }
}
