package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeCoopRewardDialogProperties extends BasicDialogProperties
   {
       
      
      public var finishLevel:int;
      
      public var cash:int;
      
      public var xp:int;
      
      public var gold:int;
      
      public var title:String;
      
      public var buttonLabel_okay:String;
      
      public var coopType:String;
      
      public function CafeCoopRewardDialogProperties(param1:Array, param2:String)
      {
         this.buttonLabel_okay = param2;
         this.title = this.title;
         this.finishLevel = param1.shift();
         this.cash = param1.shift();
         this.gold = param1.shift();
         this.xp = param1.shift();
         this.coopType = param1.shift();
         super();
      }
   }
}
