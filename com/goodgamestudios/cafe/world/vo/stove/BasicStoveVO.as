package com.goodgamestudios.cafe.world.vo.stove
{
   import com.goodgamestudios.cafe.world.vo.InteractiveFloorVO;
   
   public class BasicStoveVO extends InteractiveFloorVO
   {
       
      
      public var dishID:int = -1;
      
      public var timeUsed:int;
      
      public var timeLeft:int;
      
      public var cookedWithFancyIngredient:Boolean;
      
      public function BasicStoveVO()
      {
         super();
      }
      
      override public function loadFromParamArray(param1:Array) : void
      {
         super.loadFromParamArray(param1);
         this.dishID = param1.shift();
         this.cookedWithFancyIngredient = int(param1.shift()) == 1;
         this.timeUsed = param1.shift();
         this.timeLeft = param1.shift();
      }
   }
}
