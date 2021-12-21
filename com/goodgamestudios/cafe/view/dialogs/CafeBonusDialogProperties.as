package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeBonusDialogProperties extends BasicDialogProperties
   {
      
      public static const TYPE_LEVELUP:int = 0;
      
      public static const TYPE_ACHIEVEMENT:int = 1;
      
      public static const TYPE_WAITER:int = 2;
      
      public static const TYPE_EXPAND:int = 3;
      
      public static const TYPE_PERFECTDISH:int = 5;
      
      public static const TYPE_FIND_TIP:int = 6;
      
      public static const TYPE_FIND_INGREDIENT:int = 7;
      
      public static const TYPE_NEW_MASTERY:int = 8;
      
      public static const TYPE_FIND_FILLING:int = 9;
      
      public static const TYPE_WHEELOFFORTUNE:int = 10;
      
      public static const TYPE_NEWELEMENTS:int = 11;
      
      public static const TYPE_LEVELTEXT:int = 12;
      
      public static const TYPE_LOGINBONUS:int = 13;
      
      public static const TYPE_NEWFURNITURE:int = 14;
      
      public static const TYPE_SOCIALLOGINBONUS:int = 15;
      
      public static const TYPE_COMEBACK_BONUS:int = 16;
      
      public static const TYPE_LOGINBONUS_WO_WOF:int = 18;
       
      
      public var type:int;
      
      public var title:String;
      
      public var copy:String;
      
      public var bonuselements:Array;
      
      public var feedparams:Array;
      
      public var iconWodId:int;
      
      public function CafeBonusDialogProperties(param1:int, param2:String, param3:String, param4:Array = null, param5:Array = null, param6:int = -1)
      {
         super();
         this.type = param1;
         this.title = param2;
         this.copy = param3;
         this.bonuselements = param4;
         this.feedparams = param5;
         this.iconWodId = param6;
      }
   }
}
