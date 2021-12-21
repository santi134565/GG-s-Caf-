package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicDestroyGameCommand extends SimpleCommand
   {
       
      
      public function BasicDestroyGameCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         BasicController.getInstance().soundController.stopMusic();
         BasicController.getInstance().soundController.stopAllLoopedSoundEffects();
         this.layoutManager.clearAllLayoutContent();
      }
      
      private function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
   }
}
