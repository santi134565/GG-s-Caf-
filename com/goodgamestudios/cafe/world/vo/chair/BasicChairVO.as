package com.goodgamestudios.cafe.world.vo.chair
{
   import com.goodgamestudios.cafe.world.vo.InteractiveFloorVO;
   
   public class BasicChairVO extends InteractiveFloorVO
   {
       
      
      public var dishID:int = -1;
      
      public var dishStatus:int;
      
      public function BasicChairVO()
      {
         super();
      }
      
      override public function loadFromParamArray(param1:Array) : void
      {
         super.loadFromParamArray(param1);
         this.dishID = param1.shift();
         this.dishStatus = param1.shift();
      }
   }
}
