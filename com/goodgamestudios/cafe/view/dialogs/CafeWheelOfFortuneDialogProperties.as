package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeWheelOfFortuneDialogProperties extends BasicDialogProperties
   {
      
      public static const NUM_PRIZES:int = 16;
      
      public static const TYPE_GOLD:int = 1;
      
      public static const TYPE_XP:int = 2;
      
      public static const TYPE_DISH:int = 3;
      
      public static const TYPE_FANCY:int = 4;
      
      public static const TYPE_INGREDIENT:int = 5;
      
      public static const TYPE_CASH:int = 6;
      
      public static const TYPE_DECO:int = 7;
      
      public static const TYPE_MOREGOLD:int = 8;
      
      public static const TYPE_RAREINGREDIENT:int = 9;
      
      public static const TYPE_RAREDECO:int = 10;
      
      public static const RAREDECO_ENABLED:Boolean = false;
       
      
      public var firstPlay:Boolean;
      
      public var prizes:Array;
      
      public var jackpot:int = 0;
      
      public function CafeWheelOfFortuneDialogProperties(param1:Boolean, param2:int = 0)
      {
         this.prizes = [];
         super();
         this.firstPlay = param1;
         this.prizes = this.prizes;
         this.jackpot = param2;
      }
      
      public function getPrizeTypeBySlot(param1:int) : int
      {
         switch(param1)
         {
            case 0:
            default:
               return TYPE_MOREGOLD;
            case 1:
               return TYPE_CASH;
            case 2:
               return TYPE_RAREINGREDIENT;
            case 3:
               return TYPE_DECO;
            case 4:
               return TYPE_FANCY;
            case 5:
               return TYPE_DISH;
            case 6:
               return TYPE_XP;
            case 7:
               return TYPE_DISH;
            case 8:
               return TYPE_GOLD;
            case 9:
               return TYPE_CASH;
            case 10:
               return TYPE_INGREDIENT;
            case 11:
               return TYPE_FANCY;
            case 12:
               if(RAREDECO_ENABLED)
               {
                  return TYPE_RAREDECO;
               }
               return TYPE_DECO;
               break;
            case 13:
               return TYPE_RAREINGREDIENT;
            case 14:
               return TYPE_XP;
            case 15:
               return TYPE_DISH;
         }
      }
   }
}
