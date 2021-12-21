package com.goodgamestudios.basic.controller.commands
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   
   public class SMSCommand extends BasicCommand
   {
       
      
      public function SMSCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_SERVER_MESSAGE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            BasicLayoutManager.getInstance().showAdminDialog(CommonDialogNames.StandardOkDialog_NAME,new BasicStandardOkDialogProperties(BasicModel.languageData.getTextById("generic_alert_connection_failed_title"),BasicModel.languageData.getTextById("servershutdown_copy")));
         }
         return super.executeCommand(param1,param2);
      }
   }
}
