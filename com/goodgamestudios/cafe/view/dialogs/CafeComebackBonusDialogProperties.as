package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeComebackBonusDialogProperties extends BasicDialogProperties
   {
       
      
      public var type:int;
      
      public var title:String;
      
      public var copy:String;
      
      public var bonuselements:Array;
      
      public function CafeComebackBonusDialogProperties(param1:int, param2:String, param3:String, param4:Array = null)
      {
         super();
         this.type = param1;
         this.title = param2;
         this.copy = param3;
         this.bonuselements = param4;
      }
   }
}
