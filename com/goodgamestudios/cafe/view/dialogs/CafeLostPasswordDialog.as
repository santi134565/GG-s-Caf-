package com.goodgamestudios.cafe.view.dialogs
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeLostPasswordDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeLostPasswordDialog";
       
      
      public function CafeLostPasswordDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.lostPassDialog.btn_yes.label = this.lostPassDialogProperties.buttonLabel_yes;
         this.lostPassDialog.btn_no.label = this.lostPassDialogProperties.buttonLabel_no;
         this.lostPassDialog.txt_title.text = this.lostPassDialogProperties.title;
         this.lostPassDialog.txt_copy.text = this.lostPassDialogProperties.copy;
         this.lostPassDialog.txt_name.inputField.text = "";
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.lostPassDialog.btn_yes:
               hide();
               if(this.lostPassDialog.txt_name.inputField.text.length > 0 && this.lostPassDialogProperties.functionYes != null)
               {
                  this.lostPassDialogProperties.functionYes([this.lostPassDialog.txt_name.inputField.text]);
               }
               break;
            case this.lostPassDialog.btn_no:
            case this.lostPassDialog.btn_close:
               hide();
               if(this.lostPassDialogProperties.functionNo != null)
               {
                  this.lostPassDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get lostPassDialogProperties() : CafeLostPasswordDialogProperties
      {
         return properties as CafeLostPasswordDialogProperties;
      }
      
      protected function get lostPassDialog() : LostPassword
      {
         return disp as LostPassword;
      }
   }
}
