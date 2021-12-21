package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeHighscoreEvent;
   
   public class HSLCommand extends CafeCommand
   {
       
      
      public function HSLCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_HIGHSCORE_LIST;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            controller.dispatchEvent(new CafeHighscoreEvent(CafeHighscoreEvent.GET_HIGHSCORE_DATA,param2));
            return true;
         }
         return false;
      }
   }
}
