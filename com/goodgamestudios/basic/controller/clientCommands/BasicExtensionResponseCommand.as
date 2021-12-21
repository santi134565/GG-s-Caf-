package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.commands.BasicCommand;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.utils.DictionaryUtil;
   
   public class BasicExtensionResponseCommand extends SimpleCommand
   {
       
      
      public function BasicExtensionResponseCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc4_:BasicCommand = null;
         var _loc2_:SmartfoxEvent = param1 as SmartfoxEvent;
         var _loc3_:int = int(_loc2_.params[0]);
         if(DictionaryUtil.containsKey(BasicController.commandDict,_loc2_.cmdId))
         {
            (_loc4_ = BasicController.commandDict[_loc2_.cmdId]).executeCommand(_loc3_,_loc2_.params);
            BasicController.getInstance().serverMessageArrived(_loc2_.cmdId);
         }
         else
         {
            trace("BEFEHL UNBEKANNT " + _loc2_.cmdId);
         }
      }
   }
}
