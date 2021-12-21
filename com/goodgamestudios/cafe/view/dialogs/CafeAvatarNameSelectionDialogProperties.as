package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeAvatarNameSelectionDialogProperties extends BasicDialogProperties
   {
       
      
      public var names:Array = null;
      
      public var badword:String = "";
      
      public function CafeAvatarNameSelectionDialogProperties(param1:Array, param2:String = "")
      {
         super();
         this.names = param1;
         this.badword = param2;
      }
   }
}
