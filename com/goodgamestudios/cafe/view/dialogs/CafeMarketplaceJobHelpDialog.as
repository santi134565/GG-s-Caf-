package com.goodgamestudios.cafe.view.dialogs
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeMarketplaceJobHelpDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeMarketplaceJobHelpDialog";
       
      
      public function CafeMarketplaceJobHelpDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.helpDialog.btn_okay.label = this.helpDialogProperties.buttonLabel_ok;
         this.helpDialog.txt_title.text = this.helpDialogProperties.title;
         this.helpDialog.txt_header1.text = this.helpDialogProperties.header1;
         this.helpDialog.txt_header2.text = this.helpDialogProperties.header2;
         this.helpDialog.txt_copy1.text = this.helpDialogProperties.copy1;
         this.helpDialog.txt_copy2.text = this.helpDialogProperties.copy2;
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
      
      protected function get helpDialogProperties() : CafeMarketplaceJobHelpDialogProperties
      {
         return properties as CafeMarketplaceJobHelpDialogProperties;
      }
      
      protected function get helpDialog() : CafeMarketplaceJobhelp
      {
         return disp as CafeMarketplaceJobhelp;
      }
   }
}
