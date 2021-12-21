package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicConnectionFailedCommand extends SimpleCommand
   {
       
      
      public function BasicConnectionFailedCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_PREPARE_RECONNECT);
      }
   }
}
