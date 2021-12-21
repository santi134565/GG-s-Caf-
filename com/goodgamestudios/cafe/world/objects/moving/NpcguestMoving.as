package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.CafeIsoMouse;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.objects.chair.BasicChair;
   import com.goodgamestudios.cafe.world.objects.overlay.StaticIconOverlay;
   import com.goodgamestudios.cafe.world.objects.overlay.StaticOverlay;
   import com.goodgamestudios.cafe.world.objects.vendingmachine.BasicVendingmachine;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.fastfood.BasicFastfoodVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcguestMovingVO;
   import com.goodgamestudios.cafe.world.vo.overlay.MovingOverlayVO;
   import com.goodgamestudios.cafe.world.vo.overlay.StaticOverlayVO;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.utils.IntPoint;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class NpcguestMoving extends VestedMoving
   {
       
      
      private var eating:Boolean = false;
      
      private var leaving:Boolean = false;
      
      private var outdoor:Boolean = false;
      
      private var wasThirsty:Boolean = false;
      
      private var shouldUseFrosty:Boolean = false;
      
      private var usedFrosty:Boolean = false;
      
      private var _chair:BasicChair;
      
      private var _vendingmachine:BasicVendingmachine;
      
      private var boughtFood:BasicFastfoodVO;
      
      private var _walkablePos:Point;
      
      private var _isClickedByPlayer:Boolean;
      
      private var _currentDish:BasicDishVO;
      
      private var waitingIconBox:StaticIconOverlay;
      
      private var _initFunction:Function;
      
      private var npcGlowfilter:GlowFilter;
      
      private var waitingTimer:Timer;
      
      private var infoBox:StaticOverlay;
      
      public function NpcguestMoving()
      {
         this.npcGlowfilter = new GlowFilter(16777215,1,14,14,4);
         super();
         _speed = 40;
         overlayPosition.x = 30;
         overlayPosition.y = -80;
         this._isClickedByPlayer = false;
      }
      
      override public function set isClickable(param1:Boolean) : void
      {
         super.isClickable = param1;
         if(!isClickable)
         {
            this.removeWaitingBox();
            this.removeGlow();
         }
         disp.mouseEnabled = isClickable;
      }
      
      override protected function createVisualRep() : Boolean
      {
         vo.deltaDepth = (vo as NpcMovingVO).npcId / 1000000;
         super.createVisualRep();
         if(CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_VENDINGMACHINE && (vo as NpcguestMovingVO).thirsty && _currentRange == VestedMoving.RANGE_WALK && CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_MY_CAFE && !this._chair)
         {
            this.infoBox = cafeIsoWorld.addInfoBox(this,StaticOverlayVO.OVERLAY_TYPE_THIRSTY,[]);
         }
         this.isClickable = this.infoBox && this.infoBox.disp.visible;
         return true;
      }
      
      override protected function setLogicState(param1:int) : void
      {
         switch(param1)
         {
            case LOGIC_ACTION_ENDPATH:
               if(this.outdoor)
               {
                  this.outdoor = false;
                  cafeIsoWorld.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.NPC_LEAVING_CAFE,[(getVisualVO() as NpcMovingVO).npcId,CafeIsoWorld.ACTION_NPC_LEAVE_COMPLETE]));
                  break;
               }
               if(this.leaving)
               {
                  this.onGoOutdoor();
                  break;
               }
               break;
         }
      }
      
      private function onLeavingTimer(param1:TimerEvent) : void
      {
         this.waitingTimer.stop();
         this.waitingTimer.removeEventListener(TimerEvent.TIMER,this.onLeavingTimer);
         this.waitingTimer = null;
         if(disp)
         {
            this.leave();
         }
      }
      
      override public function startWalkPathAction() : void
      {
         if(_path && _path.length > 0)
         {
            this._walkablePos = new Point();
            this._walkablePos.x = _path[0].x;
            this._walkablePos.y = _path[0].y;
         }
         super.startWalkPathAction();
      }
      
      private function changeNpcPos(param1:Point, param2:Number = 0.0) : void
      {
         if(param1 && param1 != isoGridPos)
         {
            deltaDepth = param2;
            changeIsoPos(param1);
         }
      }
      
      private function onGoOutdoor() : void
      {
         clearPath();
         this.outdoor = true;
         this.leaving = false;
         _path = new Array();
         var _loc1_:Point = cafeIsoWorld.spwanPoint;
         _path.push(new IntPoint(_loc1_.x,_loc1_.y));
         _isWalkingPath = true;
         this.startWalkPathAction();
         updateIsoDepthManual(_loc1_,-0.1);
      }
      
      public function eat(param1:IsoObject) : void
      {
         this._chair = param1 as BasicChair;
         if(this._chair)
         {
            this.onEat();
         }
      }
      
      private function onEat() : void
      {
         this.eating = true;
         if(hidden)
         {
            this.onSitDown();
         }
         this.removeWaitingBox();
         this.isClickable = false;
         setAniState(ANIM_STATUS_EAT);
         this._chair.table.initEating();
      }
      
      public function leave() : void
      {
         var _loc1_:int = 0;
         this.leaving = true;
         this.removeWaitingBox();
         if(this._chair)
         {
            this._chair.guest = null;
         }
         this.isClickable = false;
         if(this.usedFrosty)
         {
            if(this.boughtFood && CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_MY_CAFE)
            {
               _loc1_ = Math.ceil(this.boughtFood.baseXP * (CafeModel.userData.userLevel + 18) / 190);
               cafeIsoWorld.addBoniBox(this,MovingOverlayVO.OVERLAY_TYPE_WITH_ICON,this.boughtFood.baseCash + "","","",CafeConstants.WODID_CASH);
               if(_loc1_ > 0)
               {
                  cafeIsoWorld.addBoniBox(this,MovingOverlayVO.OVERLAY_TYPE_WITH_ICON,_loc1_ + "","","",CafeConstants.WODID_XP,750);
               }
               if(this.boughtFood.baseCash > 0)
               {
                  cafeIsoWorld.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.HERO_EVENT,[CafeIsoEvent.HERO_CHANGE_MONEY,this.boughtFood.baseCash,0]));
               }
               if(this.boughtFood.baseXP > 0)
               {
                  cafeIsoWorld.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.HERO_EVENT,[CafeIsoEvent.HERO_CHANGE_XP,Math.ceil(this.boughtFood.baseXP * (CafeModel.userData.userLevel + 18) / 190)]));
               }
               if(this.boughtFood.baseRating > 0)
               {
                  cafeIsoWorld.addBoniBox(this,MovingOverlayVO.OVERLAY_TYPE_WITH_ICON,this.boughtFood.baseRating / 10 + "","","",CafeConstants.WODID_RATEUP,1500);
                  cafeIsoWorld.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.RATING_EVENT,[this.boughtFood.baseRating]));
               }
            }
         }
         if(this.eating && this._chair.table.currentDish)
         {
            cafeIsoWorld.addBoniBox(this,MovingOverlayVO.OVERLAY_TYPE_WITH_ICON,"","","",CafeConstants.WODID_RATEUP);
            cafeIsoWorld.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.HERO_EVENT,[CafeIsoEvent.HERO_CHANGE_MONEY,this._chair.table.currentDish.incomePerServing,0]));
            cafeIsoWorld.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.RATING_EVENT,[CafeConstants.rating_guest_happy]));
            this._chair.guestEatUp();
         }
         else if(!this.wasThirsty)
         {
            cafeIsoWorld.addBoniBox(this,MovingOverlayVO.OVERLAY_TYPE_WITH_ICON,"","","",CafeConstants.WODID_RATEDOWN);
            cafeIsoWorld.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.RATING_EVENT,[CafeConstants.rating_guest_unhappy]));
            this.isClickable = false;
         }
         clearPath();
         if(!this._walkablePos)
         {
            this._walkablePos = this._chair.isoGridPos.clone();
         }
         this.changeNpcPos(this._walkablePos);
         if(cafeIsoWorld.freeDoorPoint.x == this._walkablePos.x && cafeIsoWorld.freeDoorPoint.y == this._walkablePos.y)
         {
            this.onGoOutdoor();
         }
         else
         {
            walkToFreePos(cafeIsoWorld.freeDoorPoint);
         }
      }
      
      public function walkToChair(param1:IsoObject) : void
      {
         this._chair = param1 as BasicChair;
         this.onWalkToChair();
      }
      
      public function walkToVendingmachine(param1:BasicVendingmachine) : void
      {
         this._vendingmachine = param1;
         this.shouldUseFrosty = true;
         (cafeIsoWorld.mouse as CafeIsoMouse).isOnObject = false;
         this.isClickable = false;
         disp.mouseEnabled = false;
         this.infoBox.disp.visible = false;
         this.infoBox.hide();
      }
      
      public function fastfoodAction(param1:IsoObject) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Point = null;
         if(!this._vendingmachine)
         {
            this._vendingmachine = CafeModel.fastfoodData.smoothieMaker;
         }
         if(this._vendingmachine && visRepCreated)
         {
            walkToObject(this._vendingmachine.isoGridPos.clone());
            _loc3_ = this._vendingmachine.isoGridPos.subtract(isoGridPos);
            if(Math.abs(_loc3_.x + _loc3_.y) == 1)
            {
               _loc2_ = true;
            }
         }
         this.boughtFood = this._vendingmachine.removeFastFood();
         this.usedFrosty = true;
         this.wasThirsty = true;
      }
      
      private function onWalkToChair() : void
      {
         this.leaving = false;
         if(hidden)
         {
            show();
         }
         walkToObject(this._chair.isoGridPos);
      }
      
      public function onWalkToVendingmachine() : void
      {
         this.leaving = false;
         this.shouldUseFrosty = true;
         if(hidden)
         {
            show();
         }
         if(!this._vendingmachine)
         {
            this._vendingmachine = CafeModel.fastfoodData.smoothieMaker;
         }
         walkToFreePos(this._vendingmachine.frontTile);
      }
      
      public function sitDown(param1:IsoObject) : void
      {
         this._chair = param1 as BasicChair;
         if(!this._chair)
         {
            return;
         }
         this._chair.guest = this;
         if(CafeModel.userData.isMyPlayerWaiter)
         {
            this.isClickable = true;
         }
         this.onSitDown();
      }
      
      private function onSitDown() : void
      {
         if(hidden)
         {
            show();
         }
         if(this.infoBox)
         {
            (vo as NpcguestMovingVO).thirsty = false;
            this.isClickable = this.infoBox.disp.visible = false;
            this.infoBox.hide();
         }
         if(visRepCreated)
         {
            clearPath();
         }
         this.changeNpcPos(this._chair.isoGridPos,0.2);
         updateDir(new Point(this._chair.table.isoGridPos.x - this._chair.isoGridPos.x,this._chair.table.isoGridPos.y - this._chair.isoGridPos.y));
         this.addWaitingBox();
         setAniState(ANIM_STATUS_SITING);
      }
      
      private function addWaitingBox() : void
      {
         if(CafeModel.userData.isMyPlayerWaiter)
         {
            this.waitingIconBox = cafeIsoWorld.addBoniBox(this,StaticOverlayVO.OVERLAY_TYPE_WITH_WAITINGICON,"","","",CafeConstants.WODID_WAITINGICON) as StaticIconOverlay;
         }
      }
      
      public function removeWaitingBox() : void
      {
         if(this.waitingIconBox)
         {
            cafeIsoWorld.removeBoniBox(this.waitingIconBox);
            this.waitingIconBox = null;
         }
      }
      
      public function get chair() : BasicChair
      {
         return this._chair;
      }
      
      public function onOverlayClick() : void
      {
         this.onMouseDown(null);
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         if(isClickable)
         {
            world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.GUEST_CLICK,[this]));
         }
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         if(isClickable)
         {
            world.mouse.isOnObject = true;
            super.onRollOver(param1);
            this.addGlow();
         }
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         world.mouse.isOnObject = false;
         super.onRollOut(param1);
         if(!this._isClickedByPlayer)
         {
            this.removeGlow();
         }
      }
      
      override public function removeDispFromWorld() : void
      {
         if(this.waitingTimer)
         {
            this.waitingTimer.stop();
            if(this.waitingTimer.hasEventListener(TimerEvent.TIMER))
            {
               this.waitingTimer.removeEventListener(TimerEvent.TIMER,this.onLeavingTimer);
            }
            this.waitingTimer = null;
         }
         super.removeDispFromWorld();
      }
      
      public function addGlow() : void
      {
         disp.filters = [this.npcGlowfilter];
      }
      
      public function removeGlow() : void
      {
         if(disp)
         {
            disp.filters = [];
         }
      }
      
      public function set clickedByPlayer(param1:Boolean) : void
      {
         this._isClickedByPlayer = param1;
         if(this._isClickedByPlayer && CafeModel.userData.isMyPlayerWaiter)
         {
            this.addGlow();
         }
         else
         {
            this.removeGlow();
         }
      }
      
      private function get env() : CafeEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      public function get vendingmachine() : BasicVendingmachine
      {
         return this._vendingmachine;
      }
   }
}
