package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.Worklist;
   import com.goodgamestudios.cafe.world.objects.CafeInteractiveFloorObject;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.moving.HeroMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.PlayerMovingVO;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.isocore.VisualElement;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class HeroMoving extends PlayerMoving
   {
      
      public static const COOK_WORK_PREPARE:int = 1000;
      
      public static const COOK_WORK_CLEAN:int = 1001;
      
      public static const COOK_WORK_SERVE_START:int = 1002;
      
      public static const COOK_WORK_SERVE_END:int = 1003;
      
      public static const WAITER_WORK_PICKUP_DISH:int = 1004;
      
      public static const WAITER_WORK_CLEAN_START:int = 1005;
      
      public static const WAITER_WORK_CLEAN_END:int = 1006;
      
      public static const WAITER_WORK_SERVE_START:int = 1007;
      
      public static const WAITER_WORK_SERVE_END:int = 1008;
       
      
      private var _cleanAnimTime:int = -1;
      
      public var workList:Worklist;
      
      public function HeroMoving()
      {
         this.workList = new Worklist();
         super();
         _speed = 40;
         overlayPosition.x = 30;
         overlayPosition.y = -100;
      }
      
      override protected function initVisualRep() : void
      {
         (getVisualVO() as HeroMovingVO).seekingJob = false;
         super.initVisualRep();
         this._cleanAnimTime = -1;
         disp.addEventListener(CafeIsoEvent.WORKLIST_WORKNEXTITEM,this.onWorklistworknextitem);
         deltaDepth = CafeConstants.DEPTH_HERO;
         disp.mouseChildren = false;
         disp.mouseEnabled = false;
      }
      
      override protected function createVisualRep() : Boolean
      {
         super.createVisualRep();
         var _loc1_:AnimatedDisplayObject = getHatAnim();
         if(_loc1_ && _loc1_.disp)
         {
            _loc1_.disp.visible = cafeIsoWorld.cafeWorldType != CafeConstants.CAFE_WORLD_TYPE_OTHERPLAYERCAFE;
         }
         return true;
      }
      
      public function deliverFood(param1:BasicDishVO, param2:BasicCounter, param3:BasicStove) : void
      {
         this.workList.append([param2,COOK_WORK_SERVE_END,param3]);
         this.workNextItem();
         addDish(param1);
      }
      
      public function addWorkItem(param1:CafeInteractiveFloorObject, param2:int) : void
      {
         param1.isInWorkList = true;
         this.workList.add([param1,param2]);
         if(this.workList.length == 1)
         {
            if(!this.workList.working && !_isMoving)
            {
               this.workNextItem();
            }
         }
      }
      
      public function workNextItem() : void
      {
         var _loc1_:VisualElement = null;
         var _loc2_:Point = null;
         if(this.workList.length > 0 && !_isWalkingPath || this.workList.length > 0 && !_isWalkingPath && !this.workList.workList[0][0])
         {
            _loc1_ = this.workList.workList[0][0] as VisualElement;
            if(_loc1_)
            {
               _loc2_ = _loc1_.getVisualVO().isoPos;
               walkToObject(_loc2_);
               this.workList.working = true;
            }
         }
         else
         {
            this.workList.working = false;
            setAniState(ANIM_STATUS_STAND);
         }
      }
      
      override public function walkToFreePos(param1:Point) : Boolean
      {
         if(!this.workList.working)
         {
            return super.walkToFreePos(param1);
         }
         return false;
      }
      
      override public function reachedObjectAction() : void
      {
         if((getVisualVO() as HeroMovingVO).isWaiter)
         {
            if(_pick && _counter)
            {
               if(transportDish)
               {
                  world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.HERO_EVENT,[CafeIsoEvent.HERO_PICKDOWN,_counter.getVisualVO().isoPos.x,_counter.getVisualVO().isoPos.y]));
               }
               else
               {
                  world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.HERO_EVENT,[CafeIsoEvent.HERO_PICKUP,_counter.getVisualVO().isoPos.x,_counter.getVisualVO().isoPos.y]));
               }
               _pick = false;
            }
            if(_deliver && _chair && transportDish)
            {
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.HERO_EVENT,[CafeIsoEvent.HERO_DELIVER,_chair.getVisualVO().isoPos.x,_chair.getVisualVO().isoPos.y]));
               _deliver = false;
               incrementAction();
            }
            if(_isCleaning && _chair)
            {
               this._cleanAnimTime = getTimer() + 1000;
            }
            super.reachedObjectAction();
         }
         else
         {
            super.reachedObjectAction();
            this.onWorklistWork();
         }
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
         if(_isCleaning && this._cleanAnimTime > 0 && this._cleanAnimTime < getTimer())
         {
            this.onCleanAnimTimerEnd();
         }
      }
      
      private function onCleanAnimTimerEnd() : void
      {
         this._cleanAnimTime = -1;
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.HERO_EVENT,[CafeIsoEvent.HERO_CLEAN,_chair.getVisualVO().isoPos.x,_chair.getVisualVO().isoPos.y]));
         incrementAction();
      }
      
      override protected function setLogicState(param1:int) : void
      {
         switch(param1)
         {
            case LOGIC_ACTION_ENDPATH:
               if(!this.workList.working && !(getVisualVO() as PlayerMovingVO).isWaiter)
               {
                  this.workNextItem();
               }
               break;
            case LOGIC_ACTION_ENDSTEP:
               deltaDepth = 0.1;
               break;
            case LOGIC_ACTION_STARTNEWSTEP:
               deltaDepth = 0;
         }
      }
      
      override public function walkToCounter(param1:BasicCounter) : void
      {
         _pick = true;
         _counter = param1;
         if(_counter)
         {
            walkToObject(_counter.isoGridPos);
         }
      }
      
      public function get isWorking() : Boolean
      {
         return this.workList.isWorking;
      }
      
      override public function startWalkPathAction() : void
      {
         if(_path && _path.length > 0)
         {
            world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.WALK_TO,[_path[0].x,_path[0].y]));
         }
      }
      
      private function onWorklistworknextitem(param1:CafeIsoEvent) : void
      {
         this.workNextItem();
      }
      
      private function onWorklistWork() : void
      {
         var _loc4_:BasicStove = null;
         var _loc1_:Array = this.workList.getElement();
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:VisualElement = _loc1_[0];
         var _loc3_:int = _loc1_[1];
         switch(_loc3_)
         {
            case COOK_WORK_PREPARE:
               (_loc2_ as BasicStove).prepareStepStart();
               setAniState(ANIM_STATUS_WORK);
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.STOVE_EVENT,[CafeIsoEvent.STOVE_PREPARESTEP,_loc2_]));
               break;
            case COOK_WORK_CLEAN:
               if(!(_loc4_ = _loc2_ as BasicStove).currentDish || !CafeModel.userData.showRefreshPopup(_loc4_.currentDish.wodId))
               {
                  setAniState(ANIM_STATUS_WORK);
               }
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.STOVE_EVENT,[CafeIsoEvent.STOVE_CLEAN,_loc2_]));
               break;
            case COOK_WORK_SERVE_START:
               if(!(_loc4_ = _loc2_ as BasicStove).isRotten)
               {
                  setAniState(ANIM_STATUS_WORK);
                  world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.STOVE_EVENT,[CafeIsoEvent.STOVE_DELIVER_INFO,_loc2_,_loc3_]));
               }
               else
               {
                  _loc4_.isInWorkList = false;
                  this.workNextItem();
               }
               break;
            case COOK_WORK_SERVE_END:
               world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.STOVE_EVENT,[CafeIsoEvent.STOVE_DELIVER,_loc2_,_loc3_,_loc1_[2]]));
         }
      }
   }
}
