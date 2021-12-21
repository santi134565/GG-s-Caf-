package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.utils.ForumUtils;
   
   public class BasicOpenForumCommand extends SimpleCommand
   {
       
      
      public function BasicOpenForumCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         ForumUtils.navigateToForum(BasicController.getInstance().cryptedForumHash + (EnviromentGlobalsHandler.globals.isTest || EnviromentGlobalsHandler.globals.isLocal ? "/1" : ""));
      }
   }
}
