package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicRegisterDialogProperties;
   
   public class CafeRegisterDialogProperties extends BasicRegisterDialogProperties
   {
       
      
      public var unlockFunctions:Boolean = false;
      
      public var showLogoutButton:Boolean = false;
      
      public function CafeRegisterDialogProperties(param1:Boolean = false, param2:Boolean = false)
      {
         this.unlockFunctions = param1;
         this.showLogoutButton = param2;
         super();
      }
   }
}
