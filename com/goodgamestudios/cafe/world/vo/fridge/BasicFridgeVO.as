package com.goodgamestudios.cafe.world.vo.fridge
{
   import com.goodgamestudios.cafe.world.vo.InteractiveFloorVO;
   
   public class BasicFridgeVO extends InteractiveFloorVO
   {
       
      
      private var _inventorySize:int = 0;
      
      public function BasicFridgeVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         this._inventorySize = param1.attribute("inventorySize");
      }
      
      public function get inventroySize() : int
      {
         return this._inventorySize;
      }
      
      public function set inventroySize(param1:int) : void
      {
         this._inventorySize = param1;
      }
   }
}
