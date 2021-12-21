package com.goodgamestudios.cafe.world.objects.wall
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.world.CafeIsoMap;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.isocore.IsoMouse;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.objects.IDraggable;
   import com.goodgamestudios.isocore.objects.WallObject;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class StaticWall extends WallObject implements IDraggable
   {
       
      
      protected var colorMatrix:ColorMatrix;
      
      public function StaticWall()
      {
         this.colorMatrix = new ColorMatrix();
         super();
      }
      
      override protected function initVisualRep() : void
      {
         this.colorMatrix.adjustBrightness(-20,-20,-20);
         super.initVisualRep();
         this.setWallDepth();
         disp.mouseEnabled = false;
         disp.mouseChildren = false;
      }
      
      private function setWallDepth() : void
      {
         if(!isoGridPos)
         {
            return;
         }
         if(isoGridPos.y == 0)
         {
            deltaDepth = CafeConstants.DEPTH_WALL_RIGHT;
         }
         else
         {
            deltaDepth = CafeConstants.DEPTH_WALL_LEFT;
         }
      }
      
      override public function startDrag() : void
      {
         if(!world.mouse.iDragObject)
         {
            world.mouse.iDragObject = this;
            isoGridPos = new Point(0,0);
            deltaDepth = CafeConstants.DEPTH_WALL_DRAG;
            world.mouse.switchState(IsoMouse.ISOMOUSE_STATE_FREE);
            filters = [new GlowFilter(255)];
            hide();
         }
      }
      
      override public function stopDrag() : void
      {
         var _loc1_:int = 0;
         if(world.mouse.iDragObject)
         {
            _loc1_ = (world.map as CafeIsoMap).getWallWodId(isoGridPos);
            if((world.map as CafeIsoMap).getWallWodId(isoGridPos) != vo.wodId)
            {
               world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.CHANGE_WALL,isoGridPos.x,isoGridPos.y,vo.wodId,0]));
               this.setWallDepth();
            }
            else
            {
               world.removeIsoObject(this);
               world.mouse.iDragObject = null;
            }
         }
      }
      
      override public function dragMove(param1:Point) : void
      {
         var _loc2_:Point = world.map.grid.getPosOnBorder(param1);
         if(!_loc2_.equals(isoGridPos))
         {
            if(isHidden)
            {
               show();
               world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
            }
            changeIsoPos(_loc2_);
            this.updateAlignment();
         }
      }
      
      override public function updateAlignment() : void
      {
         super.updateAlignment();
         if(vo.isoPos.x == 0)
         {
            disp.filters = [];
         }
         else
         {
            disp.filters = [this.colorMatrix.filter];
         }
      }
   }
}
