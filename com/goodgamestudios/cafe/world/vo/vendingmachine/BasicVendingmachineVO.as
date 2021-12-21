package com.goodgamestudios.cafe.world.vo.vendingmachine
{
   import com.goodgamestudios.cafe.world.vo.InteractiveFloorVO;
   
   public class BasicVendingmachineVO extends InteractiveFloorVO
   {
       
      
      public var fastfoodWodId:int = -1;
      
      public var fastfoodAmount:int = -1;
      
      public function BasicVendingmachineVO()
      {
         super();
      }
      
      override public function loadFromParamArray(param1:Array) : void
      {
         super.loadFromParamArray(param1);
         this.fastfoodWodId = param1.shift();
         this.fastfoodAmount = param1.shift();
      }
   }
}
