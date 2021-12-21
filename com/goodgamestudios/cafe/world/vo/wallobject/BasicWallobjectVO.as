package com.goodgamestudios.cafe.world.vo.wallobject
{
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   
   public class BasicWallobjectVO extends ShopVO
   {
       
      
      public var itemWidth:int = 1;
      
      public var rotationType:int = 1;
      
      public function BasicWallobjectVO()
      {
         super();
         walkable = false;
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         this.itemWidth = parseInt(param1.attribute("width"));
         this.rotationType = parseInt(param1.attribute("rotatetype"));
      }
   }
}
