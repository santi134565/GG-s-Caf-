package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   
   public class LWRCommand extends CafeCommand
   {
       
      
      public function LWRCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_PLAY_WITHOUT_REGISTER;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
         }
         return true;
      }
   }
}
