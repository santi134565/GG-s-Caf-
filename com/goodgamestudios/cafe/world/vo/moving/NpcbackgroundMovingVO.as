package com.goodgamestudios.cafe.world.vo.moving
{
   import flash.geom.Point;
   
   public class NpcbackgroundMovingVO extends NpcMovingVO
   {
      
      public static const NPC_TYPE:int = 2;
       
      
      public function NpcbackgroundMovingVO()
      {
         super();
      }
      
      override public function get isoPos() : Point
      {
         return new Point(isoX,isoY);
      }
   }
}
