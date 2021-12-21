package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeStaffManagementDialogProperties extends BasicDialogProperties
   {
       
      
      public var functionChange:Function;
      
      public var functionFire:Function;
      
      public var npcName:String;
      
      public var npcFavorite:int;
      
      public function CafeStaffManagementDialogProperties(param1:String, param2:int, param3:Function, param4:Function)
      {
         this.npcName = param1;
         this.npcFavorite = param2;
         this.functionFire = param4;
         this.functionChange = param3;
         super();
      }
   }
}
