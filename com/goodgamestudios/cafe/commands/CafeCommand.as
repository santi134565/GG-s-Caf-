package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.commands.BasicCommand;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   
   public class CafeCommand extends BasicCommand
   {
       
      
      public function CafeCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:* = param1;
         switch(0)
         {
         }
         return true;
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      protected function get cafeIsoWorld() : CafeIsoWorld
      {
         return this.layoutManager.isoScreen.isoWorld;
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
   }
}
