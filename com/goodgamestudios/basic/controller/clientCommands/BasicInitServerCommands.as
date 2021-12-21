package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.controller.commands.GCHCommand;
   import com.goodgamestudios.basic.controller.commands.GFLCommand;
   import com.goodgamestudios.basic.controller.commands.SMSCommand;
   import com.goodgamestudios.commanding.SimpleCommand;
   import flash.utils.Dictionary;
   
   public class BasicInitServerCommands extends SimpleCommand
   {
       
      
      protected var commandDict:Dictionary;
      
      public function BasicInitServerCommands()
      {
         this.commandDict = BasicController.commandDict;
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Dictionary = BasicController.commandDict;
         _loc2_[BasicSmartfoxConstants.S2C_CASH_HASH] = new GCHCommand();
         _loc2_[BasicSmartfoxConstants.S2C_GET_FORUM_LOGIN_DATA] = new GFLCommand();
         _loc2_[BasicSmartfoxConstants.S2C_SERVER_MESSAGE] = new SMSCommand();
      }
   }
}
