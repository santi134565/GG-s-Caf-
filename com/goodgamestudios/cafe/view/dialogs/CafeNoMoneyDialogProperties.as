package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeNoMoneyDialogProperties extends BasicDialogProperties
   {
       
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public function CafeNoMoneyDialogProperties(param1:String, param2:String)
      {
         this.title = param1;
         this.copy = param2;
         super();
      }
   }
}
