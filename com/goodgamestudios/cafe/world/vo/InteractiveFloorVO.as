package com.goodgamestudios.cafe.world.vo
{
   public class InteractiveFloorVO extends ShopVO
   {
       
      
      public var rotationType:int = 1;
      
      public var amount:int = 1;
      
      public function InteractiveFloorVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         this.rotationType = parseInt(param1.attribute("rotatetype"));
         walkable = Boolean(parseInt(param1.attribute("walkable")));
      }
   }
}
