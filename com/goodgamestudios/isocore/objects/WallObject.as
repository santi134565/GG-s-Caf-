package com.goodgamestudios.isocore.objects
{
   import com.goodgamestudios.isocore.IIsoWorld;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class WallObject extends IsoStaticObject implements IDraggable
   {
       
      
      private var _isDragable:Boolean = true;
      
      protected var _dir:int = 1;
      
      protected var objectLayer:MovieClip;
      
      public function WallObject()
      {
         super();
         isMutable = true;
      }
      
      override public function initialize(param1:VisualVO, param2:IIsoWorld) : void
      {
         super.initialize(param1,param2);
      }
      
      override protected function initVisualRep() : void
      {
         var _loc1_:Class = null;
         if(disp == null)
         {
            disp = new Sprite();
            _loc1_ = getDefinitionByName(visClassName) as Class;
            this.objectLayer = new _loc1_();
            disp.addChild(this.objectLayer);
         }
         if(isoGridPos)
         {
            this.updateAlignment();
         }
         disp.cacheAsBitmap = true;
      }
      
      public function updateAlignment() : void
      {
         if(vo.isoPos.x == 0)
         {
            this._dir = 1;
            this.objectLayer.x = 0;
         }
         else
         {
            this.objectLayer.x = world.map.grid.tileSize.x;
            this._dir = -1;
         }
         this.objectLayer.scaleX = this._dir;
      }
      
      override public function startDrag() : void
      {
         if(!this._isDragable || !world.mouse.objectsSelectable)
         {
            return;
         }
         if(world.mouse.selectedObject)
         {
            world.mouse.selectedObject.deSelectObject();
         }
         if(!world.mouse.iDragObject)
         {
            world.mouse.iDragObject = this;
            if(isoGridPos)
            {
               this.setFreeTiles();
               oldIsoPos = isoGridPos.clone();
            }
            else
            {
               hide();
            }
         }
      }
      
      override public function stopDrag() : void
      {
         if(world.mouse.iDragObject)
         {
            if(this.wasOnMap)
            {
               if(!isoGridPos.equals(oldIsoPos))
               {
                  disp.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.OBJECT_STOP_DRAG,oldIsoPos.x,oldIsoPos.y,isoGridPos.x,isoGridPos.y]));
                  world.map.updateCollisionMap();
                  updateIsoDepth();
                  this.updateAlignment();
               }
               else
               {
                  this.updateAlignment();
                  show();
                  this.setBlockedTiles();
               }
               world.mouse.iDragObject = null;
               if(isHidden)
               {
                  show();
               }
            }
            else if(isoGridPos)
            {
               disp.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT,isoGridPos.x,isoGridPos.y,vo.wodId,0]));
               this.updateAlignment();
               if(isHidden)
               {
                  show();
               }
               world.map.updateCollisionMap();
            }
            else
            {
               world.mouse.removeIDragObject();
            }
         }
      }
      
      public function setBlockedTiles() : void
      {
         world.map.collisionMap.setBlockedWallObj(isoGridPos);
      }
      
      public function setFreeTiles() : void
      {
         world.map.collisionMap.setFreeWallObj(isoGridPos);
      }
      
      public function dragMove(param1:Point) : void
      {
         var _loc2_:Point = world.map.grid.getPosOnBorder(param1);
         if(this.isFreeForWallObject(_loc2_))
         {
            if(isHidden)
            {
               show();
               world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
               changeIsoPos(_loc2_);
               this.updateAlignment();
            }
            if(!_loc2_.equals(isoGridPos))
            {
               changeIsoPos(_loc2_);
               this.updateAlignment();
            }
         }
      }
      
      protected function isFreeForWallObject(param1:Point) : Boolean
      {
         if(world.map.collisionMap.isWallIsFree(param1))
         {
            return true;
         }
         return false;
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
      
      public function get wodId() : int
      {
         return getVisualVO().wodId;
      }
   }
}
