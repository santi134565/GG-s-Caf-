package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicReconnectDialogProperties;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicConnectionLostCommand extends SimpleCommand
   {
       
      
      public function BasicConnectionLostCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_DESTROY_GAME);
         this.layoutManager.state = BasicLayoutManager.STATE_CONNECT;
         if(BasicModel.smartfoxClient.userForcedDisconnect)
         {
            this.layoutManager.showDialog(CommonDialogNames.ReconnectDialog_NAME,new BasicReconnectDialogProperties(BasicModel.languageData.getTextById("generic_alert_loggedout_title"),BasicModel.languageData.getTextById("generic_alert_loggedout_copy"),this.onReconnect,BasicModel.languageData.getTextById("generic_btn_reconnect")));
         }
         else
         {
            this.layoutManager.showDialog(CommonDialogNames.ReconnectDialog_NAME,new BasicReconnectDialogProperties(BasicModel.languageData.getTextById("generic_alert_connection_lost_title"),BasicModel.languageData.getTextById("generic_alert_connection_lost_copy"),this.onReconnect,BasicModel.languageData.getTextById("generic_btn_reconnect")));
         }
      }
      
      private function onReconnect() : void
      {
         if(EnviromentGlobalsHandler.globals.loginIsKeyBased)
         {
            this.reloadIFrame();
         }
         else
         {
            BasicController.getInstance().onReconnect();
            CommandController.instance.executeCommand(BasicController.COMMAND_INITALIZE_CONTROLLER);
         }
      }
      
      private function reloadIFrame() : void
      {
         BasicModel.socialData.reloadIFrame();
      }
      
      private function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
   }
}
