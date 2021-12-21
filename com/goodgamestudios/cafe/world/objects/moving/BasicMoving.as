package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.isocore.objects.IsoMovingObject;
   import flash.geom.Point;
   
   public class BasicMoving extends IsoMovingObject
   {
      
      public static const ANIM_STATUS_SITING:int = 4;
      
      public static const ANIM_STATUS_WORK:int = 5;
      
      public static const ANIM_STATUS_EAT:int = 6;
       
      
      public var overlayPosition:Point;
      
      public function BasicMoving()
      {
         super();
         isMutable = true;
         this.overlayPosition = new Point();
      }
      
      override protected function startStep(param1:Point) : void
      {
         super.startStep(param1);
         if(_newIsoPos.x == 0 || _newIsoPos.y == 0)
         {
            isoGridPos = _newIsoPos.clone();
            world.zSortThisFrame = true;
         }
      }
      
      protected function get cafeIsoWorld() : CafeIsoWorld
      {
         return world as CafeIsoWorld;
      }
   }
}
