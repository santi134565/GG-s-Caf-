package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   
   public class SBCCommand extends CafeCommand
   {
       
      
      public function SBCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SEND_BLANCING_CONSTANTS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeConstants.setServerBalancingConstants(param2);
            return true;
         }
         return false;
      }
   }
}
