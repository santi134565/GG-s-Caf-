package com.goodgamestudios.isocore.objects
{
   import com.goodgamestudios.ai.astar.AStar;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.map.MotionDetectorController;
   import com.goodgamestudios.utils.IntPoint;
   import flash.geom.Point;
   
   public class IsoMovingObject extends IsoObject
   {
      
      public static const ANIM_STATUS_STAND:int = 0;
      
      public static const ANIM_STATUS_WALK:int = 1;
      
      public static const ANIM_STATUS_SETDIR:int = 2;
      
      public static const LOGIC_ACTION_STARTNEWSTEP:int = 100;
      
      public static const LOGIC_ACTION_ENDSTEP:int = 101;
      
      public static const LOGIC_ACTION_STARTPATH:int = 102;
      
      public static const LOGIC_ACTION_ENDPATH:int = 103;
       
      
      protected var _isMoving:Boolean = false;
      
      protected var _isWalkingPath:Boolean = false;
      
      protected var _isWalkingToObject:Boolean = false;
      
      private var _defaultSpeed:int = 50;
      
      protected var _speed:int;
      
      private var _isoDir:Point;
      
      private var _gridDir:Point;
      
      protected var _newIsoPos:Point;
      
      private var _walkToPixelPos:Point;
      
      protected var _path:Array;
      
      protected var _objectPos:Point;
      
      private var startstep:int;
      
      public function IsoMovingObject()
      {
         this._speed = this._defaultSpeed;
         this._isoDir = new Point(1,1);
         super();
      }
      
      override protected function updateVisualRep(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(this._isMoving)
         {
            _loc2_ = param1 - lastVisualUpdate;
            this.move(_loc2_);
            this.checkStepEnd();
         }
      }
      
      private function move(param1:int) : void
      {
         var _loc2_:Number = this._speed * param1 / 1000;
         visualX += 2 * _loc2_ * this._isoDir.x;
         visualY += _loc2_ * this._isoDir.y;
      }
      
      public function clearPath() : void
      {
         if(visRepCreated)
         {
            this.setAniState(ANIM_STATUS_STAND);
         }
         this._path = null;
         this._isWalkingPath = false;
         this._isWalkingToObject = false;
         this._isMoving = false;
      }
      
      public function startWalkPathAction() : void
      {
         this.startWalkPath();
      }
      
      public function startWalkPath() : void
      {
         this.walkNextPathStep();
         this.setLogicState(LOGIC_ACTION_STARTPATH);
         this.setAniState(ANIM_STATUS_WALK);
      }
      
      protected function updateDir(param1:Point) : void
      {
         this._isoDir = this.dirToIsoDir(param1);
      }
      
      public function canReachObject(param1:Point) : Boolean
      {
         var _loc2_:IntPoint = new IntPoint(isoGridPos.x,isoGridPos.y);
         var _loc3_:IntPoint = new IntPoint(param1.x,param1.y);
         world.map.collisionMap.setTempWalkable(param1);
         var _loc4_:AStar;
         var _loc5_:Array = (_loc4_ = new AStar(world.map.collisionMap,_loc2_,_loc3_)).solve();
         world.map.collisionMap.removeTempWalkable();
         return _loc5_ != null;
      }
      
      public function walkToObject(param1:Point) : void
      {
         var _loc2_:IntPoint = null;
         var _loc3_:IntPoint = null;
         var _loc4_:AStar = null;
         var _loc5_:Array = null;
         var _loc6_:Point = null;
         if(!this._isWalkingPath && !param1.equals(isoGridPos))
         {
            _loc2_ = new IntPoint(isoGridPos.x,isoGridPos.y);
            _loc3_ = new IntPoint(param1.x,param1.y);
            this._objectPos = new Point(param1.x,param1.y);
            world.map.collisionMap.setTempWalkable(param1);
            if(_loc5_ = (_loc4_ = new AStar(world.map.collisionMap,_loc2_,_loc3_)).solve())
            {
               _loc5_.shift();
               _loc5_.pop();
               if(_loc5_.length > 0)
               {
                  this.calculateManhattenDist(_loc2_,_loc3_,_loc5_.length);
                  this._path = _loc5_;
                  this._isWalkingPath = true;
                  this._isWalkingToObject = true;
                  this.startWalkPathAction();
               }
               else
               {
                  _loc6_ = new Point(_loc3_.x - _loc2_.x,_loc3_.y - _loc2_.y);
                  this.updateDir(_loc6_);
                  this.setAniState(ANIM_STATUS_STAND);
                  this.reachedObjectAction();
               }
            }
            else
            {
               trace("NO PATH");
            }
            world.map.collisionMap.removeTempWalkable();
         }
      }
      
      public function walkToFreePos(param1:Point) : Boolean
      {
         var _loc3_:IntPoint = null;
         var _loc4_:IntPoint = null;
         var _loc5_:AStar = null;
         var _loc6_:Array = null;
         var _loc2_:Boolean = false;
         if(!this._isWalkingPath && !param1.equals(isoGridPos))
         {
            _loc3_ = new IntPoint(isoGridPos.x,isoGridPos.y);
            _loc4_ = new IntPoint(param1.x,param1.y);
            this._objectPos = null;
            if(_loc6_ = (_loc5_ = new AStar(world.map.collisionMap,_loc3_,_loc4_)).solve())
            {
               _loc6_.pop();
               this.calculateManhattenDist(_loc3_,_loc4_,_loc6_.length);
               this._path = _loc6_;
               this._isWalkingPath = true;
               this.startWalkPathAction();
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function calculateManhattenDist(param1:IntPoint, param2:IntPoint, param3:int) : void
      {
         var _loc4_:int;
         if((_loc4_ = Math.abs(param1.x - param2.x) + Math.abs(param1.y - param2.y)) < param3)
         {
            world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.START_WALK,[getVisualVO(),param3 - _loc4_]));
         }
      }
      
      public function walkToFreePosWithTempTile(param1:Point) : void
      {
         world.map.collisionMap.setTempWalkable(param1.clone());
         this.walkToFreePos(param1);
         world.map.collisionMap.removeTempWalkable();
      }
      
      private function walkNextPathStep() : void
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc1_:IntPoint = this._path.pop();
         if(_loc1_)
         {
            _loc2_ = new Point(_loc1_.x - isoGridPos.x,_loc1_.y - isoGridPos.y);
            this.startStep(_loc2_);
            this._isMoving = true;
         }
         else
         {
            this._isWalkingPath = false;
            this.setAniState(ANIM_STATUS_STAND);
            if(this._isWalkingToObject)
            {
               this._isWalkingToObject = false;
               if(this._objectPos)
               {
                  _loc3_ = new Point(this._objectPos.x - isoGridPos.x,this._objectPos.y - isoGridPos.y);
                  this.updateDir(_loc3_);
                  this._objectPos = null;
               }
               this.reachedObjectAction();
            }
            this.setLogicState(LOGIC_ACTION_ENDPATH);
         }
      }
      
      protected function startStep(param1:Point) : void
      {
         if(this._isMoving)
         {
            return;
         }
         this.setLogicState(LOGIC_ACTION_STARTNEWSTEP);
         this._isMoving = true;
         this._gridDir = param1;
         this.updateDir(param1);
         this._newIsoPos = isoGridPos.add(param1);
         MotionDetectorController.checkAlarm(isoGridPos,this._newIsoPos);
         if(this._gridDir.x != 0)
         {
            updateIsoDepthManual(new Point(this._newIsoPos.x,this._newIsoPos.y - 1 * this._gridDir.x),0.5 * this._gridDir.x);
            world.zSortThisFrame = true;
         }
         this._walkToPixelPos = world.map.grid.gridPosToPixelPos(this._newIsoPos);
      }
      
      private function checkStepEnd() : void
      {
         var _loc2_:Point = null;
         var _loc1_:Number = (this._walkToPixelPos.x - visualX) * this._isoDir.x;
         if(_loc1_ < 0)
         {
            this._isMoving = false;
            isoGridPos = this._newIsoPos.clone();
            _loc2_ = world.map.grid.gridPosToPixelPos(isoGridPos);
            visualX = _loc2_.x;
            visualY = _loc2_.y;
            updateIsoDepth();
            world.zSortThisFrame = true;
            this.setLogicState(LOGIC_ACTION_ENDSTEP);
            if(this._isWalkingPath)
            {
               this.walkNextPathStep();
            }
         }
      }
      
      private function dirToIsoDir(param1:Point) : Point
      {
         return new Point(param1.x - param1.y,param1.x + param1.y);
      }
      
      public function setAniState(param1:int) : void
      {
      }
      
      protected function setLogicState(param1:int) : void
      {
      }
      
      public function reachedObjectAction() : void
      {
      }
      
      public function get isoDir() : Point
      {
         return this._isoDir;
      }
      
      public function set isoDir(param1:Point) : void
      {
         this._isoDir = param1;
      }
      
      public function get isMoving() : Boolean
      {
         return this._isMoving;
      }
   }
}
