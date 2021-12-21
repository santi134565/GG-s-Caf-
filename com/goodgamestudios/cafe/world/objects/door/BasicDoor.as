package com.goodgamestudios.cafe.world.objects.door
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.world.CafeIsoMap;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.objects.wall.StaticWall;
   import com.goodgamestudios.cafe.world.objects.wallobject.BasicWallobject;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.map.MotionDetectorController;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class BasicDoor extends BasicWallobject
   {
      
      private static const BORDER_NAME:String = "Border";
      
      private static const MASK_NAME:String = "_Mask";
      
      public static const DOOR_WITH_BORDER:int = 3;
      
      private static const DOOR_OPEN:int = 2;
      
      private static const DOOR_CLOSED:int = 1;
      
      private static const DOOR_OPEN_TIME:Number = 1000;
       
      
      private var doorCloseTime:Number;
      
      private var borderVE:BorderDoor;
      
      private var doorMask:MovieClip;
      
      private var currentWall:StaticWall;
      
      private var _isOpen:Boolean;
      
      public var isNewDoor:Boolean = false;
      
      public function BasicDoor()
      {
         super();
         isMutable = true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.addBorder();
         this.isOpen = false;
         this.setDoorMask();
         if(!this.isNewDoor)
         {
            MotionDetectorController.addMotionDetector(this,isoGridPos,this.motionTile);
         }
         disp.addEventListener(IsoWorldEvent.MOTIONDETECTOR_ALARM,this.onMotionDetectorAlarm);
      }
      
      override public function changeIsoPos(param1:Point) : void
      {
         this.removeDoorMask();
         world.map.collisionMap.setWalkable(this.frontTile(isoGridPos));
         super.changeIsoPos(param1);
         this.setBorder();
         this.borderVE.updateAlignment();
         this.updateAlignment();
         this.setDoorMask();
         MotionDetectorController.changeMotionDetectorPosition(this,isoGridPos,this.motionTile);
      }
      
      override public function startDrag() : void
      {
         super.startDrag();
      }
      
      override public function stopDrag() : void
      {
         world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
         if(this.isNewDoor)
         {
            disp.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT,isoGridPos.x,isoGridPos.y,vo.wodId,0]));
         }
         else
         {
            super.stopDrag();
         }
         world.map.collisionMap.setBlocked(this.frontTile(isoGridPos));
         this.updateDepthClosed();
      }
      
      override public function dragMove(param1:Point) : void
      {
         var _loc2_:Point = world.map.grid.getPosOnBorder(param1);
         if(world.map.collisionMap.isWallIsFree(_loc2_) && world.map.collisionMap.isWalkableByPoint(this.frontTile(_loc2_)))
         {
            if(isHidden)
            {
               this.show();
               world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
               this.changeIsoPos(world.map.grid.pixelPosToGridPos(_loc2_));
            }
            if(!_loc2_.equals(isoGridPos))
            {
               this.changeIsoPos(_loc2_);
               this.updateAlignment();
            }
         }
      }
      
      public function frontTile(param1:Point) : Point
      {
         var _loc2_:Point = param1.clone();
         if(param1.x == 0)
         {
            ++_loc2_.x;
         }
         else if(param1.y == 0)
         {
            ++_loc2_.y;
         }
         return _loc2_;
      }
      
      override public function update(param1:Number) : void
      {
         if(this._isOpen)
         {
            if(param1 > this.doorCloseTime)
            {
               this.isOpen = false;
            }
         }
      }
      
      public function removeDoorMask() : void
      {
         if(this.doorMask && this.currentWall)
         {
            this.currentWall.isWalkable = false;
            if(this.currentWall.disp)
            {
               this.currentWall.disp.removeChild(this.doorMask);
               this.currentWall.disp.mask = null;
            }
         }
         this.currentWall = null;
         this.doorMask = null;
      }
      
      public function setDoorMask() : void
      {
         if(this.doorMask)
         {
            return;
         }
         var _loc1_:Class = getDefinitionByName(visClassName + MASK_NAME) as Class;
         this.doorMask = new _loc1_();
         this.updateMaskAlignment();
         this.currentWall = (world.map as CafeIsoMap).getWall(isoGridPos);
         if(this.currentWall)
         {
            this.currentWall.disp.addChild(this.doorMask);
            this.currentWall.disp.mask = this.doorMask;
            this.currentWall.isWalkable = true;
         }
      }
      
      private function updateMaskAlignment() : void
      {
         if(_dir == 1)
         {
            this.doorMask.x = 0;
         }
         else
         {
            this.doorMask.x = world.map.grid.tileSize.x;
         }
         this.doorMask.scaleX = _dir;
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               if(world.mouse.iDragObject != this)
               {
                  this.removeGlow();
               }
         }
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OVER,[this]));
               this.addGlow();
         }
      }
      
      private function removeBorder() : void
      {
         world.removeIsoObject(this.borderVE);
         this.borderVE = null;
      }
      
      private function addBorder() : void
      {
         var _loc1_:Class = getDefinitionByName(world.voClassPath + group.toLowerCase() + "::" + BORDER_NAME + vo.group + "VO") as Class;
         var _loc2_:VisualVO = new _loc1_();
         _loc2_.wodId = -1;
         _loc2_.group = vo.group;
         _loc2_.name = BORDER_NAME;
         _loc2_.type = vo.type;
         this.borderVE = world.addLevelElement(_loc2_) as BorderDoor;
         this.setBorder();
      }
      
      private function setBorder() : void
      {
         var _loc1_:Point = null;
         this.borderVE.isoGridPos = isoGridPos.clone();
         if(isoGridPos.x == 0)
         {
            this.borderVE.isoY += 1;
            this.borderVE.changeIsoPos(this.borderVE.isoGridPos);
            this.borderVE.deltaDepth = CafeConstants.DEPTH_DOOR_BORDER_LEFT;
         }
         else
         {
            _loc1_ = isoGridPos.clone();
            this.borderVE.isoX += 1;
            this.borderVE.changeIsoPos(this.borderVE.isoGridPos);
            this.borderVE.deltaDepth = CafeConstants.DEPTH_DOOR_BORDER_RIGHT;
         }
         this.borderVE.updateAlignment();
      }
      
      private function onMotionDetectorAlarm(param1:IsoWorldEvent) : void
      {
         this.isOpen = true;
      }
      
      public function get motionTile() : Point
      {
         var _loc1_:Point = isoGridPos.clone();
         if(_loc1_.x == 0)
         {
            ++_loc1_.x;
         }
         if(_loc1_.y == 0)
         {
            ++_loc1_.y;
         }
         return _loc1_;
      }
      
      override public function get removeAllowed() : Boolean
      {
         if(this.isNewDoor)
         {
            (world as CafeIsoWorld).door.show();
            return true;
         }
         return false;
      }
      
      override public function hide() : void
      {
         super.hide();
         this.borderVE.hide();
         this.removeDoorMask();
      }
      
      override public function show() : void
      {
         super.show();
         this.borderVE.show();
         this.setDoorMask();
      }
      
      override public function remove() : void
      {
         super.remove();
         MotionDetectorController.removeMotionDetector(this);
         this.removeDoorMask();
         this.removeBorder();
      }
      
      public function get isOpen() : Boolean
      {
         return this._isOpen;
      }
      
      override public function get wasOnMap() : Boolean
      {
         if(this.isNewDoor)
         {
            return false;
         }
         return true;
      }
      
      override public function updateAlignment() : void
      {
         super.updateAlignment();
         this.updateDepthClosed();
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         this._isOpen = param1;
         if(this._isOpen)
         {
            (objectLayer as MovieClip).gotoAndStop(DOOR_OPEN);
            this.updateDepthOpen();
            this.doorCloseTime = getTimer() + DOOR_OPEN_TIME;
         }
         else
         {
            this.updateDepthClosed();
            (objectLayer as MovieClip).gotoAndStop(DOOR_CLOSED);
         }
         world.zSortThisFrame = true;
      }
      
      private function updateDepthOpen() : void
      {
         if(vo.isoPos.x == 0)
         {
            deltaDepth = CafeConstants.DEPTH_DOOR_LEFT_OPEN;
         }
         else
         {
            deltaDepth = CafeConstants.DEPTH_DOOR_RIGHT_OPEN;
         }
      }
      
      private function updateDepthClosed() : void
      {
         var _loc1_:Point = null;
         if(world.worldStatus == CafeIsoWorld.CAFE_STATUS_RUN)
         {
            if(vo.isoPos.x == 0)
            {
               deltaDepth = CafeConstants.DEPTH_DOOR_LEFT_CLOSED;
            }
            else
            {
               deltaDepth = CafeConstants.DEPTH_DOOR_RIGHT_CLOSED;
            }
         }
         else
         {
            _loc1_ = isoGridPos.clone();
            if(isoGridPos.x == 0)
            {
               _loc1_.y += 1;
            }
            else
            {
               _loc1_.x += 1;
            }
         }
      }
      
      override protected function addGlow() : void
      {
         if(world.mouse.objectsSelectable)
         {
            objectLayer.glow.filters = [selectedGlowfilter];
         }
      }
      
      override protected function removeGlow() : void
      {
         if(disp)
         {
            objectLayer.glow.filters = [];
         }
      }
   }
}
