package com.goodgamestudios.cafe.world.objects.wallobject
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.vo.wallobject.BasicWallobjectVO;
   import com.goodgamestudios.isocore.objects.WallObject;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class BasicWallobject extends WallObject
   {
       
      
      protected var selectedGlowfilter:GlowFilter;
      
      public function BasicWallobject()
      {
         this.selectedGlowfilter = new GlowFilter(16777215,1,14,14,4);
         super();
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         vo.deltaDepth = CafeConstants.DEPTH_WALLOBJECT;
         updateIsoDepth();
         objectLayer.stop();
         this.addMouseListener();
      }
      
      protected function addMouseListener() : void
      {
         if(disp)
         {
            disp.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            disp.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            disp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            disp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         }
      }
      
      override public function updateAlignment() : void
      {
         if(vo.isoPos.x == 0)
         {
            _dir = 1;
            objectLayer.x = 0;
         }
         else
         {
            objectLayer.x = world.map.grid.tileSize.x;
            _dir = -1;
         }
         switch((vo as BasicWallobjectVO).rotationType)
         {
            case 0:
               objectLayer.scaleX = _dir;
               break;
            case 2:
               if(_dir == 1)
               {
                  objectLayer.gotoAndStop(1);
               }
               else
               {
                  objectLayer.gotoAndStop(2);
               }
               break;
            default:
               objectLayer.scaleX = _dir;
         }
      }
      
      override public function startDrag() : void
      {
         this.addGlow();
         super.startDrag();
      }
      
      override public function stopDrag() : void
      {
         this.removeGlow();
         super.stopDrag();
      }
      
      override public function setBlockedTiles() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = (vo as BasicWallobjectVO).itemWidth;
         if(_loc1_ < 2)
         {
            world.map.collisionMap.setBlockedWallObj(isoGridPos);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(isoGridPos.x == 0)
               {
                  world.map.collisionMap.setBlockedWallObj(new Point(isoGridPos.x,isoGridPos.y + _loc2_));
               }
               else if(isoGridPos.y == 0)
               {
                  world.map.collisionMap.setBlockedWallObj(new Point(isoGridPos.x + _loc2_,isoGridPos.y));
               }
               _loc2_++;
            }
         }
      }
      
      override public function setFreeTiles() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = (vo as BasicWallobjectVO).itemWidth;
         if(_loc1_ < 2)
         {
            world.map.collisionMap.setFreeWallObj(isoGridPos);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(isoGridPos.x == 0)
               {
                  world.map.collisionMap.setFreeWallObj(new Point(isoGridPos.x,isoGridPos.y + _loc2_));
               }
               else if(isoGridPos.y == 0)
               {
                  world.map.collisionMap.setFreeWallObj(new Point(isoGridPos.x + _loc2_,isoGridPos.y));
               }
               _loc2_++;
            }
         }
      }
      
      override protected function isFreeForWallObject(param1:Point) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:int = (vo as BasicWallobjectVO).itemWidth;
         var _loc3_:Point = param1.clone();
         if(_loc2_ < 2)
         {
            return world.map.collisionMap.isWallIsFree(_loc3_);
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc3_.x == 0)
            {
               _loc3_.y += _loc4_;
               if(!world.map.collisionMap.isWallIsFree(_loc3_))
               {
                  return false;
               }
            }
            else if(_loc3_.y == 0)
            {
               _loc3_.x += _loc4_;
               if(!world.map.collisionMap.isWallIsFree(_loc3_))
               {
                  return false;
               }
            }
            _loc4_++;
         }
         return true;
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_RUN:
               break;
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_DOWN,[this]));
               this.startDrag();
         }
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_RUN:
               break;
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OUT,[this]));
               if(world.mouse.iDragObject != this)
               {
                  this.removeGlow();
               }
         }
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_RUN:
               break;
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OVER,[this]));
               this.addGlow();
         }
      }
      
      protected function addGlow() : void
      {
         if(world.mouse.objectsSelectable)
         {
            disp.filters = [this.selectedGlowfilter];
         }
      }
      
      protected function removeGlow() : void
      {
         if(disp)
         {
            disp.filters = [];
         }
      }
      
      override public function remove() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         disp.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         disp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         disp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         disp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         if(isoGridPos)
         {
            if(isoGridPos.x == 0)
            {
               _loc1_ = 0;
               while(_loc1_ < Math.max((vo as BasicWallobjectVO).itemWidth,1))
               {
                  world.map.collisionMap.setFreeWallObj(new Point(isoGridPos.x,isoGridPos.y + _loc1_));
                  _loc1_++;
               }
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < Math.max((vo as BasicWallobjectVO).itemWidth,1))
               {
                  world.map.collisionMap.setFreeWallObj(new Point(isoGridPos.x + _loc2_,isoGridPos.y));
                  _loc2_++;
               }
            }
         }
      }
   }
}
