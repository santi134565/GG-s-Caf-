package com.goodgamestudios.basic.controller.commands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   
   public class GFLCommand extends BasicCommand
   {
       
      
      public function GFLCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_GET_FORUM_LOGIN_DATA;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            BasicController.getInstance().cryptedForumHash = String(param2.shift());
            return true;
         }
         return false;
      }
   }
}
