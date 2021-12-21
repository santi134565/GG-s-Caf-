package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicLogoutCommand extends SimpleCommand
   {
       
      
      public function BasicLogoutCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         BasicController.getInstance().soundController.stopMusic();
         BasicController.getInstance().soundController.stopAllLoopedSoundEffects();
         BasicModel.sessionData.resetLoggedinTimer();
         BasicModel.smartfoxClient.logout();
         BasicLayoutManager.getInstance().revertFullscreen();
      }
   }
}
