package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeSmoothiemakerHelpDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeSmoothiemakerHelpDialog";
       
      
      public function CafeSmoothiemakerHelpDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.helpDialog.btn_okay:
               hide();
         }
      }
      
      override protected function applyProperties() : void
      {
         this.helpDialog.txt_title.text = CafeModel.languageData.getTextById("generic_help");
         this.helpDialog.btn_okay.label = CafeModel.languageData.getTextById("generic_btn_okay");
         this.helpDialog.txt_header1.text = CafeModel.languageData.getTextById("dialogwin_smoothiemakerhelp_title");
         this.helpDialog.txt_copy1.text = CafeModel.languageData.getTextById("dialogwin_smoothiemakerhelp_copy");
      }
      
      protected function get helpDialog() : CafeCoopHelp
      {
         return disp as CafeCoopHelp;
      }
   }
}
