package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicSmartfoxClient;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicJoinedRoomCommand extends SimpleCommand
   {
       
      
      public function BasicJoinedRoomCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:SmartfoxEvent = param1 as SmartfoxEvent;
         var _loc3_:int = int(_loc2_.params[0]);
         if(_loc2_.params[0] == BasicSmartfoxClient.LOBBY_ROOM_NAME)
         {
            EnviromentGlobalsHandler.globals.clientInstanceHash = BasicModel.localData.readComputerInstanceCookie();
            if(EnviromentGlobalsHandler.globals.clientInstanceHash >= 0)
            {
               BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_VERSION_CHECK,[EnviromentGlobalsHandler.globals.buildNumberGame,EnviromentGlobalsHandler.globals.clientInstanceHash]);
            }
            else
            {
               BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_VERSION_CHECK,[EnviromentGlobalsHandler.globals.buildNumberGame]);
            }
         }
      }
   }
}
