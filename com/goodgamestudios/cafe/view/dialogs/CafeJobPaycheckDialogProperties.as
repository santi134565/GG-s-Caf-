package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeJobPaycheckDialogProperties extends BasicDialogProperties
   {
       
      
      public var cash:int;
      
      public var xp:int;
      
      public var title:String;
      
      public var copy:String;
      
      public var buttonLabel_okay:String;
      
      public function CafeJobPaycheckDialogProperties(param1:String, param2:String, param3:Array, param4:String)
      {
         this.buttonLabel_okay = param4;
         this.title = param1;
         this.copy = param2;
         this.cash = param3.shift();
         this.xp = param3.shift();
         super();
      }
   }
}
