package com.goodgamestudios.cafe.world.vo.overlay
{
   public class StaticIconOverlayVO extends StaticOverlayVO
   {
       
      
      public var iconWodId:int = -1;
      
      public function StaticIconOverlayVO()
      {
         super();
         name = "StaticIcon";
         relTargetY = -50;
         lifeTime = -1;
      }
   }
}
