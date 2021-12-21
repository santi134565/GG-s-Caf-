package com.goodgamestudios.cafe.world
{
   import com.goodgamestudios.cafe.world.objects.tile.StaticTile;
   import com.goodgamestudios.isocore.IIsoWorld;
   import com.goodgamestudios.isocore.IsoMouse;
   import com.goodgamestudios.isocore.objects.IsoMovingObject;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class CafeIsoMouse extends IsoMouse
   {
       
      
      public function CafeIsoMouse(param1:IIsoWorld)
      {
         super(param1);
      }
      
      override public function onMouseOut() : void
      {
         super.onMouseOut();
         clearSelectedObject();
      }
      
      override protected function onMouseLeave(param1:Event) : void
      {
         if(world.worldStatus == CafeIsoWorld.CAFE_STATUS_DEKO)
         {
            this.onMouseUp(null);
         }
      }
      
      override public function clickAction() : void
      {
         if(isOnObject)
         {
            return;
         }
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_RUN:
               if(IsoMovingObject(this.cafeIsoWorld.myPlayer))
               {
                  if(!isOnObject && world.map.isOnPlayMap(curIsoPos) && this.cafeIsoWorld.myPlayer.isoGridPos && !this.cafeIsoWorld.myPlayer.isCleaning)
                  {
                     this.cafeIsoWorld.myPlayer.walkToFreePos(curIsoPos);
                  }
               }
               break;
            case CafeIsoWorld.CAFE_STATUS_DEKO:
         }
      }
      
      override public function onMouseDown(param1:MouseEvent) : void
      {
         if(world.worldStatus == CafeIsoWorld.CAFE_STATUS_DEKO && iDragObject is StaticTile)
         {
            if(world.map.isOnPlayMap(curIsoPos))
            {
               isDrawingTiles = true;
               this.cafeIsoWorld.startDrawTiles(curIsoPos);
            }
         }
         super.onMouseDown(param1);
      }
      
      override public function onMouseUp(param1:MouseEvent) : void
      {
         if(iDragObject && iDragObject is StaticTile && _isDrawingTiles)
         {
            this.cafeIsoWorld.stopDrawTiles();
            _mouseDown = false;
         }
         else
         {
            super.onMouseUp(param1);
         }
      }
      
      override protected function dragObjectAction(param1:Point) : void
      {
         if(iDragObject is StaticTile && _isDrawingTiles)
         {
            this.cafeIsoWorld.moveDrawTiles(world.map.grid.getNextPosOnMap(param1));
         }
         else
         {
            super.dragObjectAction(param1);
         }
      }
      
      override public function addIsoCursor() : void
      {
         var _loc5_:VisualVO = null;
         var _loc1_:String = "Cursor";
         var _loc2_:String = "Static";
         var _loc3_:String = "Red";
         var _loc4_:Class;
         (_loc5_ = new (_loc4_ = getDefinitionByName(world.voClassPath + _loc1_.toLowerCase() + "::" + _loc2_ + _loc1_ + "VO") as Class)()).group = _loc1_;
         _loc5_.name = _loc2_;
         _loc5_.type = _loc3_;
         _loc5_.x = 0;
         _loc5_.y = 0;
         cursorVE = world.addLevelElement(_loc5_);
         cursorVE.disp.mouseEnabled = false;
         cursorVE.disp.mouseChildren = false;
         hideIsoCursor();
      }
      
      override protected function updateIsoCursor(param1:Point) : void
      {
         if(!cursorVE)
         {
            return;
         }
         if(world.map.isOnPlayMap(param1) && world.map.collisionMap.isWalkableByPoint(param1))
         {
            if(isOnObject)
            {
               hideIsoCursor();
            }
            else
            {
               showIsoCursor();
               cursorVE.isoGridPos = param1.clone();
               cursorVE.drawToIsoPos();
            }
         }
         else
         {
            hideIsoCursor();
         }
      }
      
      protected function get cafeIsoWorld() : CafeIsoWorld
      {
         return world as CafeIsoWorld;
      }
   }
}
