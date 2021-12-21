package com.goodgamestudios.cafe.view.dialogs
{
   import com.adobe.utils.StringUtil;
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.graphics.animation.AnimatedMovieClip;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   
   public class CafeMailVerificationDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeMailVerificationDialog";
       
      
      private var isWaitingForServerMessage:Boolean;
      
      private var helpArrow:AnimatedMovieClip;
      
      public function CafeMailVerificationDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         controller.addEventListener(CafeUserEvent.MAILVERIFICATION_FAILD,this.onRegisterComplete);
         controller.addEventListener(CafeUserEvent.MAILVERIFICATION_COMPLETED,this.onRegisterComplete);
         super.init();
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(CafeUserEvent.MAILVERIFICATION_FAILD,this.onRegisterComplete);
         controller.removeEventListener(CafeUserEvent.MAILVERIFICATION_COMPLETED,this.onRegisterComplete);
         super.destroy();
      }
      
      override protected function applyProperties() : void
      {
         this.isWaitingForServerMessage = false;
         this.removeArrow();
         this.registerDial.txt_email.text = CafeModel.userData.email;
         this.registerDial.btn_ok.label = CafeModel.languageData.getTextById("dialogwin_presentreminder_btn_send");
         TextFieldHelper.changeTextFromatSizeByTextWidth(30,this.registerDial.txt_title,CafeModel.languageData.getTextById("dialogwin_presentreminder_title",[CafeConstants.emailVerificationGold]));
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.registerDial.txt_copy,CafeModel.languageData.getTextById("dialogwin_presentreminder_copy1",[CafeConstants.emailVerificationGold]),5);
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.registerDial.txt_copy2,CafeModel.languageData.getTextById("dialogwin_presentreminder_copy2",[CafeConstants.emailVerificationGold]),2);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.registerDial.btn_ok:
               this.onLogin();
               break;
            case this.registerDial.btn_close:
               hide();
               break;
            case this.registerDial.txt_email:
               (param1.target as TextField).setSelection(0,(param1.target as TextField).text.length);
         }
      }
      
      private function initArrow() : void
      {
         this.helpArrow = new AnimatedMovieClip(-1,1,"ta");
         this.helpArrow.processAnimation(new TutorialArrow(),null,false);
         this.helpArrow.setFrameRate(24);
         this.helpArrow.play();
         this.helpArrow.disp.scaleX = this.helpArrow.disp.scaleY = -1.3;
         this.helpArrow.disp.x = -50;
         this.helpArrow.y = 0;
         layoutManager.addAniDo(this.helpArrow);
      }
      
      private function removeArrow() : void
      {
         if(this.helpArrow == null)
         {
            return;
         }
         if(this.helpArrow.disp.parent)
         {
            this.helpArrow.disp.parent.removeChild(this.helpArrow.disp);
         }
         layoutManager.removeAniDo(this.helpArrow);
         this.helpArrow = null;
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.target == this.registerDial.txt_email)
         {
            this.removeArrow();
            if(param1.keyCode == Keyboard.ENTER)
            {
               this.onLogin();
            }
         }
      }
      
      private function onLogin() : void
      {
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         if(this.registerDial.txt_email.text.length == 0 || !TextValide.isSmartFoxValide(this.registerDial.txt_email.text))
         {
            if(this.helpArrow == null)
            {
               this.initArrow();
            }
            this.registerDial.mc_email.addChild(this.helpArrow.disp);
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_watchout"),CafeModel.languageData.getTextById("generic_register_email_copy")));
            return;
         }
         this.isWaitingForServerMessage = true;
         controller.sendServerMessageAndWait(SFConstants.C2S_EMAIL_VERIFICATION,[StringUtil.trim(this.registerDial.txt_email.text)],SFConstants.S2C_EMAIL_VERIFICATION);
      }
      
      private function onRegisterComplete(param1:BasicUserEvent) : void
      {
         this.isWaitingForServerMessage = false;
         if(param1.params && param1.params.length > 0)
         {
            switch(int(param1.params[0]))
            {
               case 14:
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_register_errormistake"),CafeModel.languageData.getTextById("generic_register_email_copy")));
                  break;
               case 19:
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_register_errormistake"),CafeModel.languageData.getTextById("generic_register_emaillong_copy")));
                  break;
               case 13:
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_register_errormistake"),CafeModel.languageData.getTextById("generic_register_error_accountalreadyexists")));
            }
         }
         else
         {
            layoutManager.showDialog(CafeMailGiftDialog.NAME,new CafeMailGiftDialogProperties(CafeModel.languageData.getTextById("dialogwin_shippingconfirmation_title"),CafeModel.languageData.getTextById("dialogwin_shippingconfirmation_copy1"),CafeModel.languageData.getTextById("dialogwin_shippingconfirmation_copy2"),CafeMailGiftDialogProperties.TYPE_SENDMAIL));
            hide();
         }
      }
      
      protected function get registerDial() : CafeMailverification
      {
         return disp as CafeMailverification;
      }
   }
}
