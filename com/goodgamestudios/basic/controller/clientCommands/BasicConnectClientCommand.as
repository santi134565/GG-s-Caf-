package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   import flash.external.ExternalInterface;
   
   public class BasicConnectClientCommand extends SimpleCommand
   {
       
      
      public function BasicConnectClientCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var commandVars:Object = param1;
         BasicModel.smartfoxClient.connect(EnviromentGlobalsHandler.globals.connectIP,EnviromentGlobalsHandler.globals.connectPort);
         BasicModel.localData.saveInstanceId(EnviromentGlobalsHandler.globals.instanceId);
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("setInstance",EnviromentGlobalsHandler.globals.instanceId);
            }
            catch(error:SecurityError)
            {
            }
         }
      }
   }
}
