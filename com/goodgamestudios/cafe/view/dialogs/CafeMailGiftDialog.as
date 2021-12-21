package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeMailGiftDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeMailGiftDialog";
       
      
      public function CafeMailGiftDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.mailDialog.btn_ok.label = CafeModel.languageData.getTextById("generic_btn_okay");
         TextFieldHelper.changeTextFromatSizeByTextWidth(30,this.mailDialog.txt_title,this.mailDialogProperties.title);
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.mailDialog.txt_copy,this.mailDialogProperties.copy1,5);
         this.mailDialog.mc_giftIcon.gotoAndStop(this.mailDialogProperties.dialogType == CafeMailGiftDialogProperties.TYPE_GET_GIFT ? 1 : 2);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         if(param1.target == this.mailDialog.btn_close || param1.target == this.mailDialog.btn_ok)
         {
            hide();
         }
      }
      
      protected function get mailDialogProperties() : CafeMailGiftDialogProperties
      {
         return properties as CafeMailGiftDialogProperties;
      }
      
      protected function get mailDialog() : CafeMailGift
      {
         return disp as CafeMailGift;
      }
   }
}
