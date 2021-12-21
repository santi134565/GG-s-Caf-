package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeAchievementEarnDialogProperties extends BasicDialogProperties
   {
       
      
      public var title:String;
      
      public var copy:String;
      
      public var bonuselements:Array;
      
      public var feedparams:Array;
      
      public var achievementWodId:int;
      
      public function CafeAchievementEarnDialogProperties(param1:String, param2:String, param3:int, param4:Array, param5:Array)
      {
         this.title = param1;
         this.copy = param2;
         this.achievementWodId = param3;
         this.feedparams = param5;
         this.bonuselements = param4;
         super();
      }
   }
}
