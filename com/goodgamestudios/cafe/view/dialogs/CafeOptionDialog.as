package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeOptionDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeOptionDialog";
       
      
      public function CafeOptionDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.optionDialog.gotoAndStop(!!this.isPasswordChangeable ? 1 : 2);
         this.optionDialog.txt_title.text = CafeModel.languageData.getTextById("generic_options");
         this.optionDialog.txt_general.text = CafeModel.languageData.getTextById("dialogwin_settings_general");
         this.optionDialog.txt_quality.text = CafeModel.languageData.getTextById("dialogwin_settings_quality");
         if(this.isPasswordChangeable)
         {
            this.optionDialog.txt_password.text = CafeModel.languageData.getTextById("dialogwin_register_password");
            this.optionDialog.btn_password.label = CafeModel.languageData.getTextById("generic_changePass");
         }
         this.optionDialog.txt_friendship.text = CafeModel.languageData.getTextById("tt_CafeOptionPanel_btn_blockfriends");
         this.optionDialog.txt_emails.text = CafeModel.languageData.getTextById("dialogwin_settings_email");
         this.optionDialog.txt_qhigh.text = CafeModel.languageData.getTextById("dialogwin_settings_high");
         this.optionDialog.txt_qmedium.text = CafeModel.languageData.getTextById("dialogwin_settings_medium");
         this.optionDialog.txt_qlow.text = CafeModel.languageData.getTextById("dialogwin_settings_low");
      }
      
      override public function show() : void
      {
         this.setCheckBoxes();
         super.show();
      }
      
      private function setCheckBoxes() : void
      {
         this.optionDialog.cbx_friendship.gotoAndStop(!!CafeModel.userData.heroVO.allowFriendRequest ? 1 : 2);
         this.optionDialog.cbx_mail.gotoAndStop(!!CafeModel.userData.allowEMails ? 2 : 1);
         var _loc1_:int = CafeModel.localData.readQuality();
         this.optionDialog.cbx_qhigh.gotoAndStop(_loc1_ == BasicLayoutManager.QUALITY_HIGH ? 2 : 1);
         this.optionDialog.cbx_qmedium.gotoAndStop(_loc1_ == BasicLayoutManager.QUALITY_MEDIUM ? 2 : 1);
         this.optionDialog.cbx_qlow.gotoAndStop(_loc1_ == BasicLayoutManager.QUALITY_LOW ? 2 : 1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.optionDialog.cbx_friendship:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_ALLOW_BUDDY_REQUESTS,[!!CafeModel.userData.heroVO.allowFriendRequest ? 0 : 1]);
               CafeModel.userData.heroVO.allowFriendRequest = !CafeModel.userData.heroVO.allowFriendRequest;
               this.setCheckBoxes();
               break;
            case this.optionDialog.cbx_mail:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_ALLOW_MAIL_REQUESTS,[!!CafeModel.userData.allowEMails ? 0 : 1]);
               CafeModel.userData.allowEMails = !CafeModel.userData.allowEMails;
               this.setCheckBoxes();
               break;
            case this.optionDialog.cbx_qhigh:
               CafeModel.localData.saveQuality(BasicLayoutManager.QUALITY_HIGH);
               layoutManager.changeQualityLevel(BasicLayoutManager.QUALITY_HIGH);
               this.setCheckBoxes();
               break;
            case this.optionDialog.cbx_qmedium:
               CafeModel.localData.saveQuality(BasicLayoutManager.QUALITY_MEDIUM);
               layoutManager.changeQualityLevel(BasicLayoutManager.QUALITY_MEDIUM);
               this.setCheckBoxes();
               break;
            case this.optionDialog.cbx_qlow:
               CafeModel.localData.saveQuality(BasicLayoutManager.QUALITY_LOW);
               layoutManager.changeQualityLevel(BasicLayoutManager.QUALITY_LOW);
               this.setCheckBoxes();
               break;
            case this.optionDialog.btn_password:
               layoutManager.showDialog(CafeChangePasswordDialog.NAME,new CafeChangePasswordDialogProperties(CafeModel.languageData.getTextById("dialogwin_changepassword_title"),CafeModel.languageData.getTextById("dialogwin_changepassword_copy_newpass"),CafeModel.languageData.getTextById("dialogwin_changepassword_copy_oldpass"),this.onChangePassword,null,CafeModel.languageData.getTextById("btn_text_okay"),CafeModel.languageData.getTextById("btn_text_cancle")));
               break;
            case this.optionDialog.btn_close:
               hide();
         }
      }
      
      private function onChangePassword(param1:Array) : void
      {
         if(param1 && param1.length == 2)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CHANGE_PASSWORD,param1);
         }
      }
      
      private function get isPasswordChangeable() : Boolean
      {
         return !CafeModel.userData.isGuest() || env.loginIsKeyBased;
      }
      
      private function get optionDialog() : OptionDialog
      {
         return disp as OptionDialog;
      }
   }
}
