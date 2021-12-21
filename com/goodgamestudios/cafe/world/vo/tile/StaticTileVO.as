package com.goodgamestudios.cafe.world.vo.tile
{
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   
   public class StaticTileVO extends ShopVO
   {
       
      
      public function StaticTileVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         walkable = Boolean(parseInt(param1.attribute("walkable")));
      }
   }
}
