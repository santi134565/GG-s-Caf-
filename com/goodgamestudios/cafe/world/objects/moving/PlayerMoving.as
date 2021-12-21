package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.info.JobProgress;
   import com.goodgamestudios.cafe.world.objects.chair.BasicChair;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.overlay.ChatOverlay;
   import com.goodgamestudios.cafe.world.objects.overlay.StaticOverlay;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.moving.PlayerMovingVO;
   import com.goodgamestudios.cafe.world.vo.overlay.StaticOverlayVO;
   import com.goodgamestudios.isocore.objects.IsoMovingObject;
   import com.goodgamestudios.isocore.vo.VOHelper;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundChannel;
   
   public class PlayerMoving extends PlateholderMoving
   {
       
      
      private var _walkablePos:Point;
      
      protected var _isCleaning:Boolean;
      
      protected var _pick:Boolean;
      
      protected var _deliver:Boolean;
      
      protected var _counter:BasicCounter;
      
      protected var _chair:BasicChair;
      
      private var _currentDish:BasicDishVO;
      
      private var _progressBarLayer:Sprite;
      
      public var speechBubble:ChatOverlay;
      
      private var jobIconBox:StaticOverlay;
      
      private var jobProgress:JobProgress;
      
      public var workTickSound:SoundChannel;
      
      public function PlayerMoving()
      {
         super();
      }
      
      override protected function initVisualRep() : void
      {
         var _loc1_:String = null;
         var _loc2_:Rectangle = null;
         this._deliver = false;
         this._isCleaning = false;
         this._pick = false;
         super.initVisualRep();
         this._progressBarLayer = new Sprite();
         disp.addChild(this._progressBarLayer);
         this.speechBubble = cafeIsoWorld.addInfoBox(this,StaticOverlayVO.OVERLAY_TYPE_SPEECH_BALLOON) as ChatOverlay;
         if(this.playerVO.seekingJob)
         {
            this.jobIconBox = cafeIsoWorld.addInfoBox(this,StaticOverlayVO.OVERLAY_TYPE_WITH_SEEKINGJOBICON,[""],CafeConstants.WODID_SEEKINGJOBICON);
         }
         if(this.playerVO.isWaiter)
         {
            _loc1_ = "";
            if(this.playerVO.isEqual(CafeModel.userData.playerID,CafeModel.userData.userID))
            {
               _loc1_ = CafeModel.languageData.getTextById("player_action");
            }
            this.jobProgress = new JobProgress(this);
            this.jobProgress.showProgressTip(CafeModel.languageData.getTextById("player_working"),_loc1_);
            this._progressBarLayer.addChild(this.jobProgress.disp);
            _loc2_ = this.jobProgress.disp.getBounds(null);
            this._progressBarLayer.scaleX = this._progressBarLayer.scaleY = 0.8;
            this._progressBarLayer.y = this.overlayPosition.y - (_loc2_.top / 2 + 5);
         }
      }
      
      protected function incrementAction() : void
      {
         this.jobProgress.incrementAmount();
      }
      
      override public function remove() : void
      {
         super.remove();
         while(this._progressBarLayer.numChildren > 0)
         {
            this._progressBarLayer.removeChildAt(0);
         }
      }
      
      private function get playerVO() : PlayerMovingVO
      {
         return vo as PlayerMovingVO;
      }
      
      public function updateSeekingJobIcon(param1:Boolean) : void
      {
         if(!param1 && this.jobIconBox)
         {
            cafeIsoWorld.removeInfoBox(this.jobIconBox);
            this.jobIconBox = null;
         }
         if(param1 && this.jobIconBox == null)
         {
            this.jobIconBox = cafeIsoWorld.addInfoBox(this,StaticOverlayVO.OVERLAY_TYPE_WITH_SEEKINGJOBICON,[""],CafeConstants.WODID_SEEKINGJOBICON);
         }
         this.playerVO.seekingJob = param1;
      }
      
      public function get isSeekingJob() : Boolean
      {
         return this.playerVO.seekingJob;
      }
      
      public function get isWaiter() : Boolean
      {
         return this.playerVO.isWaiter;
      }
      
      override public function reachedObjectAction() : void
      {
         if(this.playerVO.isWaiter)
         {
            if(this._isCleaning)
            {
               setAniState(ANIM_STATUS_WORK);
            }
         }
         else
         {
            super.reachedObjectAction();
         }
      }
      
      public function cleanstart(param1:BasicChair) : void
      {
         if(!this.playerVO.isWaiter || _isMoving)
         {
            return;
         }
         this._isCleaning = true;
         this._chair = param1;
         this._chair.table.isClickable = false;
         this._chair.table.clickedByPlayer = true;
         walkToObject(this._chair.isoGridPos);
      }
      
      public function cleanend() : void
      {
         if(this._chair)
         {
            this._currentDish = this._chair.table.currentDish;
            this._chair.table.clickedByPlayer = false;
            this._chair.table.removeDish();
            if(this._currentDish && !transportDish && this.playerVO.isWaiter)
            {
               addDish(this._currentDish,BasicDishVO.GFX_FRAME_EATFULL);
            }
         }
         setAniState(IsoMovingObject.ANIM_STATUS_STAND);
         this._isCleaning = false;
      }
      
      public function deliverstart(param1:BasicChair) : void
      {
         if(!this.playerVO || !param1 || !this.playerVO.isWaiter || _isMoving)
         {
            return;
         }
         this._deliver = true;
         if(!transportDish)
         {
            this._currentDish = CafeModel.wodData.createVObyWOD(this.playerVO.dishId) as BasicDishVO;
            if(this._currentDish)
            {
               addDish(this._currentDish);
            }
         }
         this._chair = param1;
         this._chair.guest.isClickable = false;
         this._chair.guest.clickedByPlayer = true;
         if(this.playerVO.userId != CafeModel.userData.userID)
         {
            clearPath();
            this.changePlayerPos(this.walkablePos);
         }
         walkToObject(this._chair.isoGridPos);
      }
      
      public function deliverend() : void
      {
         this._deliver = false;
         if(!this._currentDish)
         {
            this._currentDish = CafeModel.wodData.createVObyWOD(this.playerVO.dishId) as BasicDishVO;
         }
         if(this._chair && this._currentDish)
         {
            this._chair.table.addDish(this._currentDish.wodId);
            this._chair.guest.clickedByPlayer = false;
         }
         if(transportDish)
         {
            removeDish();
         }
      }
      
      public function pickupdish(param1:BasicCounter) : void
      {
         if(!this.playerVO.isWaiter)
         {
            return;
         }
         this._counter = param1;
         if(this._counter)
         {
            this._currentDish = VOHelper.clone(this._counter.currentDish) as BasicDishVO;
            this._counter.servDish();
         }
         else
         {
            this._currentDish = CafeModel.wodData.createVObyWOD(this.playerVO.dishId) as BasicDishVO;
         }
         if(this._currentDish)
         {
            addDish(this._currentDish);
         }
      }
      
      public function pickdowndish(param1:BasicCounter) : void
      {
         this._counter = param1;
         if(this._counter && this._currentDish && dishFrame == BasicDishVO.GFX_FRAME_READY)
         {
            this._counter.addDish(this._currentDish.wodId,1);
         }
         if(transportDish)
         {
            removeDish();
         }
      }
      
      public function walkToCounter(param1:BasicCounter) : void
      {
         this._pick = true;
         this._counter = param1;
         if(this._counter)
         {
            clearPath();
            this.changePlayerPos(this.walkablePos);
            walkToObject(this._counter.isoGridPos);
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
      
      private function changePlayerPos(param1:Point, param2:Number = 0.0) : void
      {
         if(param1 && param1 != isoGridPos)
         {
            deltaDepth = param2;
            changeIsoPos(param1);
         }
      }
      
      private function get walkablePos() : Point
      {
         if(!this._walkablePos)
         {
            this._walkablePos = cafeIsoWorld.freeDoorPoint.clone();
         }
         return this._walkablePos;
      }
      
      override protected function updateVisualRep(param1:Number) : void
      {
         super.updateVisualRep(param1);
         if(!this.playerVO.isWaiter)
         {
            return;
         }
         var _loc2_:int = param1 - lastVisualUpdate;
         this.playerVO.workTimeLeft -= _loc2_ / 1000;
         if(this.playerVO.workTimeLeft <= 0)
         {
            this.resetWaiter();
         }
         else
         {
            if(this.jobProgress)
            {
               this.jobProgress.update(Math.floor(this.playerVO.workTimeLeft / CafeConstants.workTimeLeft * 100));
            }
            if(CafeModel.userData.heroVO == this.playerVO)
            {
               if(this.playerVO.workTimeLeft < 30 && !this.workTickSound)
               {
                  this.workTickSound = CafeSoundController.getInstance().playLoopedSoundEffect(CafeSoundController.SND_TIMERLOOP);
               }
            }
         }
      }
      
      public function stopWorkTickSound() : void
      {
         if(this.workTickSound)
         {
            CafeSoundController.getInstance().stopLoopedSoundEffect(this.workTickSound);
            this.workTickSound = null;
         }
      }
      
      public function resetWaiter() : void
      {
         this.playerVO.isWaiter = false;
         this._deliver = false;
         if(this._isCleaning)
         {
            setAniState(IsoMovingObject.ANIM_STATUS_STAND);
         }
         this._isCleaning = false;
         this._pick = false;
         if(transportDish)
         {
            removeDish();
         }
         if(this._chair && this._chair.table)
         {
            this._chair.table.clickedByPlayer = false;
         }
         if(this._chair && this._chair.guest)
         {
            this._chair.guest.clickedByPlayer = false;
         }
         while(this._progressBarLayer.numChildren > 0)
         {
            this._progressBarLayer.removeChildAt(0);
         }
         if(CafeModel.userData.heroVO == this.playerVO)
         {
            world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.HERO_EVENT,[CafeIsoEvent.HERO_CHANGE_JOBSTATE]));
            this.stopWorkTickSound();
         }
      }
      
      public function get isCleaning() : Boolean
      {
         return this._isCleaning;
      }
      
      public function get isFreeForWaiterAction() : Boolean
      {
         if((getVisualVO() as PlayerMovingVO).isWaiter && !this.isCleaning && !isMoving)
         {
            return true;
         }
         return false;
      }
   }
}
