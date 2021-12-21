package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeInviteFriendDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class CIFCommand extends CafeCommand
   {
       
      
      public function CIFCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_INVITE_FRIEND;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_invitefriend_confirmed_title"),CafeModel.languageData.getTextById("alert_invitefriend_confirmed_copy",[param2.shift()])));
            controller.dispatchEvent(new CafeDialogEvent(CafeDialogEvent.CLOSE_DIALOGS,[CafeInviteFriendDialog.NAME]));
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("invitefriend_error"),CafeModel.languageData.getTextById("invitefriend_errorcode_" + param1)));
         return false;
      }
   }
}
