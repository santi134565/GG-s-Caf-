package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeAvatarCreationDialogProperties extends BasicDialogProperties
   {
       
      
      public var registerWithFacebook:Boolean = false;
      
      public function CafeAvatarCreationDialogProperties(param1:Boolean = false)
      {
         super();
         this.registerWithFacebook = param1;
      }
   }
}
