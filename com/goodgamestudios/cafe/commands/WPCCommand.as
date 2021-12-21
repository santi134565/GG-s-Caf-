package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class WPCCommand extends CafeCommand
   {
       
      
      public function WPCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return "wpc";
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            cafeIsoWorld.myPlayer.resetWaiter();
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_JOBFINISHED);
            param2.shift();
            CafeModel.userData.jobPaycheck(param2);
            return true;
         }
         return false;
      }
   }
}
