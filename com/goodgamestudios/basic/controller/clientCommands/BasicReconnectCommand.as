package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicReconnectCommand extends SimpleCommand
   {
       
      
      public function BasicReconnectCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         BasicController.getInstance().paymentHash = null;
      }
   }
}
