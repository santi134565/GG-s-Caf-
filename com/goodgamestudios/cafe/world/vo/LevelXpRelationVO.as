package com.goodgamestudios.cafe.world.vo
{
   public class LevelXpRelationVO
   {
       
      
      public var level:int;
      
      public var xp:int;
      
      public var gold:int;
      
      public var cash:int;
      
      public var waiter:int;
      
      public var fridge:int;
      
      public var stove:int;
      
      public var counter:int;
      
      public var instant:int;
      
      public function LevelXpRelationVO(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int)
      {
         super();
         this.level = param1;
         this.xp = param2;
         this.gold = param3;
         this.cash = param4;
         this.waiter = param5;
         this.fridge = param6;
         this.stove = param7;
         this.counter = param8;
         this.instant = param9;
      }
   }
}
