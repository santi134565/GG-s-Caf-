package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   
   public class COLCommand extends CafeCommand
   {
       
      
      public function COLCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_COOP_LEAVE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         return true;
      }
   }
}
