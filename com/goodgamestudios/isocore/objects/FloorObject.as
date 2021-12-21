package com.goodgamestudios.isocore.objects
{
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class FloorObject extends IsoStaticObject implements IDraggable
   {
       
      
      protected var _isDragable:Boolean = true;
      
      protected var _mouseY:int = 0;
      
      public function FloorObject()
      {
         isMutable = false;
         super();
      }
      
      override protected function initVisualRep() : void
      {
         var _loc1_:Class = null;
         if(disp == null)
         {
            _loc1_ = getDefinitionByName(visClassName) as Class;
            disp = new _loc1_();
            disp.cacheAsBitmap = true;
         }
      }
      
      override public function changeIsoPos(param1:Point) : void
      {
         super.changeIsoPos(param1);
      }
      
      public function selectObject() : void
      {
         if(world.mouse.selectedObject)
         {
            world.mouse.selectedObject.deSelectObject();
         }
         if(world.mouse.objectsSelectable)
         {
            world.mouse.selectedObject = this;
         }
      }
      
      public function deSelectObject() : void
      {
         if(world.mouse.selectedObject == this)
         {
            world.mouse.selectedObject = null;
         }
      }
      
      override public function startDrag() : void
      {
         if(!this._isDragable || !world.mouse.objectsSelectable)
         {
            return;
         }
         if(!world.mouse.iDragObject)
         {
            world.mouse.iDragObject = this;
            if(isoGridPos)
            {
               this._mouseY = disp.mouseY;
               world.map.collisionMap.setWalkable(isoGridPos);
               oldIsoPos = isoGridPos.clone();
            }
            else
            {
               hide();
               world.mouse.clearSelectedObject();
            }
         }
      }
      
      override public function stopDrag() : void
      {
         if(world.mouse.iDragObject)
         {
            if(this.wasOnMap)
            {
               deltaDepth = 0;
               if(!isoGridPos.equals(oldIsoPos))
               {
                  if(world.map.isOnMap(isoGridPos))
                  {
                     disp.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.OBJECT_STOP_DRAG,oldIsoPos.x,oldIsoPos.y,isoGridPos.x,isoGridPos.y]));
                  }
                  world.zSortThisFrame = true;
               }
               if(isHidden)
               {
                  show();
               }
               world.mouse.iDragObject = null;
            }
            else if(world.map.isOnPlayMap(isoGridPos))
            {
               disp.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT,isoGridPos.x,isoGridPos.y,vo.wodId,isoRotation]));
               if(isHidden)
               {
                  show();
               }
            }
            else
            {
               world.mouse.removeIDragObject();
            }
            world.map.updateCollisionMap();
         }
      }
      
      public function dragMove(param1:Point) : void
      {
         var _loc2_:Point = world.map.grid.getNextPosOnMap(new Point(param1.x,param1.y - this._mouseY),this.expansionRectangle);
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < this.expansionRectangle.width)
         {
            if(!_loc3_)
            {
               break;
            }
            _loc3_ = _loc3_ && world.map.collisionMap.isWalkableByPoint(new Point(_loc2_.x + _loc4_ - this.expansionRectangle.x,_loc2_.y));
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.expansionRectangle.height)
         {
            if(!_loc3_)
            {
               break;
            }
            _loc3_ = _loc3_ && world.map.collisionMap.isWalkableByPoint(new Point(_loc2_.x,_loc2_.y + _loc5_ - this.expansionRectangle.y));
            _loc5_++;
         }
         if(!_loc3_)
         {
            return;
         }
         if(world.map.collisionMap.isWalkableByPoint(_loc2_))
         {
            if(isHidden)
            {
               show();
               world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
               deltaDepth = 0.9;
               this.changeIsoPos(_loc2_);
            }
            if(!_loc2_.equals(isoGridPos))
            {
               deltaDepth = 0.9;
               this.changeIsoPos(_loc2_);
               this.dragMoveAction();
            }
         }
      }
      
      public function get isoObjectPoint() : Point
      {
         return new Point(0,0);
      }
      
      protected function get expansionRectangle() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle(0,0,1,1);
         _loc1_.x = this.isoObjectPoint.x;
         _loc1_.y = this.isoObjectPoint.y;
         switch(isoRotation)
         {
            case 0:
            case 2:
               _loc1_.width = vo.collisionSizeX;
               _loc1_.height = vo.collisionSizeY;
               break;
            case 1:
            case 3:
               _loc1_.width = vo.collisionSizeY;
               _loc1_.height = vo.collisionSizeX;
         }
         return _loc1_;
      }
      
      protected function dragMoveAction() : void
      {
      }
      
      override public function remove() : void
      {
         world.map.collisionMap.setWalkable(isoGridPos);
      }
      
      public function get removeAllowed() : Boolean
      {
         return true;
      }
      
      public function get wasOnMap() : Boolean
      {
         if(oldIsoPos)
         {
            return true;
         }
         return false;
      }
      
      public function get isDragable() : Boolean
      {
         return this._isDragable;
      }
      
      public function get mouseY() : int
      {
         return this._mouseY;
      }
      
      public function get wodId() : int
      {
         return getVisualVO().wodId;
      }
   }
}
