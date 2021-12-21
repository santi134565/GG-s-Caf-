package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeChangePasswordDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeChangePasswordDialog";
       
      
      public function CafeChangePasswordDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.changePassDialog.btn_yes.label = this.changePassDialogProperties.buttonLabel_yes;
         this.changePassDialog.btn_no.label = this.changePassDialogProperties.buttonLabel_no;
         this.changePassDialog.txt_title.text = this.changePassDialogProperties.title;
         this.changePassDialog.txt_old.text = this.changePassDialogProperties.oldpassword_text;
         this.changePassDialog.txt_new.text = this.changePassDialogProperties.newpassword_text;
         this.changePassDialog.txt_oldpass.inputField.text = "";
         this.changePassDialog.txt_oldpass.inputField.displayAsPassword = true;
         this.changePassDialog.txt_newpass.inputField.text = "";
         this.changePassDialog.txt_newpass.inputField.displayAsPassword = true;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.changePassDialog.btn_yes:
               if(!TextValide.isSmartFoxValide(this.changePassDialog.txt_newpass.inputField.text))
               {
                  this.changePassDialog.txt_oldpass.inputField.text = "";
                  this.changePassDialog.txt_newpass.inputField.text = "";
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_watchout"),CafeModel.languageData.getTextById("alert_register_password_copy")));
                  break;
               }
               if(this.changePassDialog.txt_newpass.inputField.text.length > 2 && this.changePassDialog.txt_oldpass.inputField.text == CafeModel.userData.loginPwd)
               {
                  if(this.changePassDialogProperties.functionYes != null)
                  {
                     this.changePassDialogProperties.functionYes([this.changePassDialog.txt_oldpass.inputField.text,this.changePassDialog.txt_newpass.inputField.text]);
                  }
                  hide();
               }
               else
               {
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_changePasswordFaild_title"),CafeModel.languageData.getTextById("alert_changePasswordFaild_copy")));
               }
               break;
            case this.changePassDialog.btn_no:
            case this.changePassDialog.btn_close:
               hide();
               if(this.changePassDialogProperties.functionNo != null)
               {
                  this.changePassDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get changePassDialogProperties() : CafeChangePasswordDialogProperties
      {
         return properties as CafeChangePasswordDialogProperties;
      }
      
      protected function get changePassDialog() : ChangePassword
      {
         return disp as ChangePassword;
      }
   }
}
