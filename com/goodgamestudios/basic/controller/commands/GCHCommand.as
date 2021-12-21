package com.goodgamestudios.basic.controller.commands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   
   public class GCHCommand extends BasicCommand
   {
       
      
      public function GCHCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_CASH_HASH;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            BasicController.getInstance().paymentHash = String(param2.shift());
            return true;
         }
         return false;
      }
   }
}
