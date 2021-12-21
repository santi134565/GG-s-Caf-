package com.goodgamestudios.cafe.world.vo.overlay
{
   public class MovingIconOverlayVO extends MovingOverlayVO
   {
       
      
      public var iconWodId:int = -1;
      
      public function MovingIconOverlayVO()
      {
         super();
         name = "MovingIcon";
         relTargetY = -50;
         lifeTime = 1000;
      }
   }
}
