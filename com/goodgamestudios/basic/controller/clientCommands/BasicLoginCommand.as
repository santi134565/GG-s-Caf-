package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicLoginCommand extends SimpleCommand
   {
       
      
      public function BasicLoginCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(EnviromentGlobalsHandler.globals.pln != "" && EnviromentGlobalsHandler.globals.sig != "")
         {
            BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_LOGIN_SOCIAL,[EnviromentGlobalsHandler.globals.pln,EnviromentGlobalsHandler.globals.sig,BasicModel.smartfoxClient.connectionTime,BasicModel.smartfoxClient.roundTripTime,EnviromentGlobalsHandler.globals.referrer,EnviromentGlobalsHandler.globals.networkId,EnviromentGlobalsHandler.globals.accountId]);
         }
         else
         {
            BasicController.getInstance().sendServerMessageAndWait(BasicSmartfoxConstants.C2S_LOGIN,[BasicModel.userData.loginName,BasicModel.userData.loginPwd,BasicModel.smartfoxClient.connectionTime,BasicModel.smartfoxClient.roundTripTime,EnviromentGlobalsHandler.globals.accountId],BasicSmartfoxConstants.C2S_LOGIN);
         }
      }
   }
}
