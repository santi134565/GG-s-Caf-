package com.goodgamestudios.cafe.world.vo.expansion
{
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   
   public class BasicExpansionVO extends ShopVO
   {
       
      
      public var sizeX:int;
      
      public var sizeY:int;
      
      public var expansionId:int;
      
      public function BasicExpansionVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         this.sizeX = parseInt(param1.attribute("sizeX"));
         this.sizeY = parseInt(param1.attribute("sizeY"));
         this.expansionId = parseInt(param1.attribute("expansionID"));
      }
   }
}
