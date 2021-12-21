package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafePlayerInfoDialogProperties extends BasicDialogProperties
   {
       
      
      public var userId:int;
      
      public var playerId:int;
      
      public function CafePlayerInfoDialogProperties(param1:int, param2:int)
      {
         this.userId = param1;
         this.playerId = param2;
         super();
      }
   }
}
