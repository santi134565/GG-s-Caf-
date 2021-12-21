package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeMasteryCompleteDialogProperties extends BasicDialogProperties
   {
       
      
      public var wodId:int;
      
      public var spamId:String;
      
      public function CafeMasteryCompleteDialogProperties(param1:int, param2:String = null)
      {
         this.wodId = param1;
         this.spamId = param2;
         super();
      }
   }
}
