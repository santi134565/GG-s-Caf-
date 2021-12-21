package com.goodgamestudios.cafe.world.vo.counter
{
   import com.goodgamestudios.cafe.world.vo.InteractiveFloorVO;
   
   public class BasicCounterVO extends InteractiveFloorVO
   {
      
      public static const COUNTER_STATUS_FREE:int = 0;
      
      public static const COUNTER_STATUS_INUSE:int = 1;
       
      
      public var dishID:int = -1;
      
      public var dishAmount:int;
      
      public function BasicCounterVO()
      {
         super();
      }
      
      override public function loadFromParamArray(param1:Array) : void
      {
         super.loadFromParamArray(param1);
         this.dishID = param1.shift();
         this.dishAmount = param1.shift();
      }
   }
}
