package com.goodgamestudios.cafe.view.screens
{
   import com.goodgamestudios.basic.view.screens.BasicScreen;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import flash.display.DisplayObject;
   
   public class CafeScreen extends BasicScreen
   {
       
      
      public function CafeScreen(param1:DisplayObject)
      {
         super(param1);
      }
      
      protected function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
      
      protected function get tutorialController() : CafeTutorialController
      {
         return CafeTutorialController.getInstance();
      }
   }
}
