package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.utils.ExternalInterfaceUtils;
   
   public class SMSCommand extends CafeCommand
   {
       
      
      public function SMSCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SERVER_MESSAGE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            if(param2[1] == 1)
            {
               layoutManager.showAdminDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("server_msg_title"),CafeModel.languageData.getTextById("server_msg_" + param2[1]),ExternalInterfaceUtils.reloadPage));
            }
            else
            {
               layoutManager.showAdminDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("server_msg_title"),CafeModel.languageData.getTextById("server_msg_" + param2[1])));
            }
            return true;
         }
         return false;
      }
   }
}
