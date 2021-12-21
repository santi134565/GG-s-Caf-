package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeDecoshopHelpDialog extends CafeDialog
   {
      
      public static const NAME:String = "afeDecoshopHelpDialog";
       
      
      public function CafeDecoshopHelpDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.decoHelpDialog.btn_okay.label = CafeModel.languageData.getTextById("btn_text_okay");
         this.decoHelpDialog.txt_title.text = CafeModel.languageData.getTextById("generic_help");
         this.decoHelpDialog.txt_header.text = CafeModel.languageData.getTextById("dialogwin_decoshophelp_title");
         this.decoHelpDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_decoshophelp_copy");
         this.decoHelpDialog.txt_header2.text = CafeModel.languageData.getTextById("dialogwin_decoshophelp_title_1");
         this.decoHelpDialog.txt_copy2.text = CafeModel.languageData.getTextById("dialogwin_decoshophelp_copy_1");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.decoHelpDialog.btn_okay:
               hide();
         }
      }
      
      protected function get decoHelpDialog() : CafeDekoShopHelp
      {
         return disp as CafeDekoShopHelp;
      }
   }
}
