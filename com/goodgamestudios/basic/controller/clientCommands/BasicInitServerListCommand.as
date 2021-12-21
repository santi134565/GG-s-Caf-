package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.vo.ServerVO;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicInitServerListCommand extends SimpleCommand
   {
       
      
      public function BasicInitServerListCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:XML = null;
         EnviromentGlobalsHandler.globals.sfsServerList = [];
         for each(_loc2_ in param1.serverInstances)
         {
            EnviromentGlobalsHandler.globals.sfsServerList.push(new ServerVO(_loc2_.server.text(),parseInt(_loc2_.port.text()),_loc2_.zone.text(),parseInt(_loc2_["value"]),_loc2_.defaultlanguage.text()));
         }
      }
   }
}
