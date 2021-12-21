package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class EMVCommand extends CafeCommand
   {
       
      
      public function EMVCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EMAIL_VERIFICATION;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               CafeModel.userData.email = param2[1];
               CafeModel.userData.emailVerified = true;
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.MAILVERIFICATION_COMPLETED));
               break;
            case 102:
               CafeModel.userData.emailVerified = true;
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_bug"),CafeModel.languageData.getTextById("mailverification_errorcode_" + param1)));
               break;
            case 101:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_bug"),CafeModel.languageData.getTextById("mailverification_errorcode_" + param1),this.onAllowMail));
               break;
            case 103:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_bug"),CafeModel.languageData.getTextById("generic_register_emailwrong_copy")));
               break;
            case 100:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_register_errormistake"),CafeModel.languageData.getTextById("generic_register_emaillong_copy")));
               break;
            case 24:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_register_errormistake"),CafeModel.languageData.getTextById("generic_register_email_copy")));
               break;
            case 23:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_register_errormistake"),CafeModel.languageData.getTextById("generic_register_error_accountalreadyexists")));
               break;
            default:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_bug"),CafeModel.languageData.getTextById("mailverification_errorcode_" + param1)));
         }
         controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.MAILVERIFICATION_FAILD,[param1]));
         return param1 == 0;
      }
      
      private function onAllowMail(param1:Array) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_ALLOW_MAIL_REQUESTS,[1]);
         CafeModel.userData.allowEMails = true;
      }
   }
}
