package com.goodgamestudios.basic.controller.clientCommands
{
   import com.adobe.serialization.json.JSON;
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicLoginJsonCommand extends SimpleCommand
   {
       
      
      public function BasicLoginJsonCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(EnviromentGlobalsHandler.globals.pln != "" && EnviromentGlobalsHandler.globals.sig != "")
         {
            param1.PLN = EnviromentGlobalsHandler.globals.pln;
            param1.KEY = EnviromentGlobalsHandler.globals.sig;
            param1.connectTime = BasicModel.smartfoxClient.connectionTime;
            param1.ping = BasicModel.smartfoxClient.roundTripTime;
            param1.referrer = EnviromentGlobalsHandler.globals.referrer;
            param1.networkID = EnviromentGlobalsHandler.globals.networkId;
            BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_LOGIN_SOCIAL,[com.adobe.serialization.json.JSON.encode(param1)]);
         }
         else
         {
            param1.name = BasicModel.userData.loginName;
            param1.pw = BasicModel.userData.loginPwd;
            param1.lang = EnviromentGlobalsHandler.globals.language;
            param1.did = EnviromentGlobalsHandler.globals.distributorId;
            param1.connectTime = BasicModel.smartfoxClient.connectionTime;
            param1.ping = BasicModel.smartfoxClient.roundTripTime;
            param1.accountId = EnviromentGlobalsHandler.globals.accountId;
            BasicController.getInstance().sendServerMessageAndWait(BasicSmartfoxConstants.C2S_LOGIN,[com.adobe.serialization.json.JSON.encode(param1)],BasicSmartfoxConstants.C2S_LOGIN);
         }
      }
   }
}
