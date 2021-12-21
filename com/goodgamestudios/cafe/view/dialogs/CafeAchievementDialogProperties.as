package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeAchievementDialogProperties extends BasicDialogProperties
   {
       
      
      public var itemsPerPage:int = 4;
      
      public var maxAchievementLevel:int = 4;
      
      public var playerID:int;
      
      public var userID:int;
      
      public function CafeAchievementDialogProperties(param1:int, param2:int)
      {
         this.playerID = param1;
         this.userID = param2;
         super();
      }
   }
}
