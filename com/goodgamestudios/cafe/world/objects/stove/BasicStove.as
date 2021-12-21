package com.goodgamestudios.cafe.world.objects.stove
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.info.ProgressToolTip;
   import com.goodgamestudios.cafe.world.info.StoveInfoToolTip;
   import com.goodgamestudios.cafe.world.info.StoveIngredientTip;
   import com.goodgamestudios.cafe.world.objects.DishHolderFloorObject;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.moving.HeroMoving;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.dish.RequirementVO;
   import com.goodgamestudios.cafe.world.vo.stove.BasicStoveVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class BasicStove extends DishHolderFloorObject
   {
      
      public static const STOVE_ERROR_OK:int = 0;
      
      public static const STOVE_ERROR_NOSTOVE:int = 30;
      
      public static const STOVE_ERROR_BLOCKED:int = 31;
      
      public static const STOVE_ERROR_MISS_INGREDIENT:int = 32;
      
      public static const STOVE_ERROR_NOTREADY:int = 33;
      
      public static const STOVE_ERROR_ROTTEN:int = 34;
      
      public static const STOVE_ERROR_EMPTYSTOVE:int = 35;
      
      public static const STOVE_ERROR_STOVE_BLOCKED:int = 36;
      
      public static const STOVE_ERROR_COUNTER_BLOCKED:int = 37;
      
      public static const STOVE_ERROR_EDITORMODE:int = 38;
      
      public static const STOVE_ERROR_NOCLEANMONEY:int = 4;
      
      public static const STOVE_STATE_NEW:int = 0;
      
      public static const STOVE_STATE_GO:int = 1;
      
      public static const STOVE_STATUS_FREE:int = 0;
      
      public static const STOVE_STATUS_PREPARE:int = 1;
      
      public static const STOVE_STATUS_COOKING:int = 2;
      
      public static const STOVE_STATUS_READY:int = 3;
      
      public static const STOVE_STATUS_ROTTEN:int = 4;
      
      public static const STOVE_STATUS_DIRTY:int = 5;
      
      public static const DISH_ID_NODISH:int = -1;
      
      public static const DISH_ID_DIRTY:int = -2;
      
      private static const DISH_YSHIFT:int = -40;
      
      private static const DIRTLAYERNAME:String = "Basic_Stove_Dirtlayer";
      
      private static const FANCYFRONTLAYERNAME:String = "Basic_Stove_FancyshineFront";
      
      private static const FANCYBACKLAYERNAME:String = "Basic_Stove_FancyshineBack";
       
      
      public var currentStatus:int;
      
      private var _targetCounter:BasicCounter;
      
      private var prepareSteps:int;
      
      private var prepareStepsDone:int;
      
      private var startCookTime:Number;
      
      private var endCookTime:Number;
      
      private var rottenCookTime:Number;
      
      private var timeIsActive:Boolean = true;
      
      private var _isPreparing:Boolean = false;
      
      private var _prepareStepEndTime:Number;
      
      private var _prepareDuration:int = 1;
      
      private var _isCleaning:Boolean = false;
      
      private var _cleaningEndTime:Number;
      
      private var _cleaningDuration:int = 1;
      
      private var _isServing:Boolean = false;
      
      private var _servingEndTime:Number;
      
      private var _servingDuration:int = 1;
      
      private var dirtLayer:MovieClip;
      
      private var fancyFrontLayer:MovieClip;
      
      private var fancyBackLayer:MovieClip;
      
      private var progressLayer:MovieClip;
      
      private var infoLayer:Sprite;
      
      public var ingredientTip:StoveIngredientTip;
      
      private var infoToolTip:StoveInfoToolTip;
      
      private var progressToolTip:ProgressToolTip;
      
      public function BasicStove()
      {
         super();
         isMutable = true;
         dishYShift = DISH_YSHIFT;
         this.isClickable = true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.infoLayer = new Sprite();
         this.infoToolTip = new StoveInfoToolTip(this);
         world.toolTipLayer.addChild(this.infoToolTip.disp);
         this.ingredientTip = new StoveIngredientTip(this);
         this.infoLayer.addChild(this.ingredientTip.disp);
         this.progressToolTip = new ProgressToolTip(this);
         world.toolTipLayer.addChild(this.progressToolTip.disp);
         disp.addChild(this.infoLayer);
         this.initDish();
      }
      
      override public function remove() : void
      {
         super.remove();
         world.toolTipLayer.removeChild(this.progressToolTip.disp);
         world.toolTipLayer.removeChild(this.infoToolTip.disp);
      }
      
      private function initDish() : void
      {
         switch(this.stoveVO.dishID)
         {
            case DISH_ID_NODISH:
               this.setStatus(STOVE_STATUS_FREE);
               break;
            case DISH_ID_DIRTY:
               this.setStatus(STOVE_STATUS_DIRTY);
               break;
            default:
               this.addDish(this.stoveVO.dishID);
               if(this.stoveVO.timeUsed == -1)
               {
                  this.setStatus(STOVE_STATUS_PREPARE);
               }
               else
               {
                  this.setTimes(this.stoveVO.timeUsed,this.stoveVO.timeLeft);
                  if(this.stoveVO.timeLeft > 0)
                  {
                     this.setStatus(STOVE_STATUS_COOKING);
                  }
                  else if(currentDish.rottenDuration * 60 + this.stoveVO.timeLeft > 0)
                  {
                     this.setStatus(STOVE_STATUS_READY);
                  }
                  else
                  {
                     this.setStatus(STOVE_STATUS_ROTTEN);
                  }
               }
         }
      }
      
      override public function get removeAllowed() : Boolean
      {
         if(this.currentStatus == STOVE_STATUS_FREE)
         {
            return true;
         }
         return false;
      }
      
      public function setStatus(param1:int) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1 != this.currentStatus)
         {
            switch(param1)
            {
               case STOVE_STATUS_FREE:
                  this.removeDirtLayer();
                  break;
               case STOVE_STATUS_PREPARE:
                  this.prepareCook();
                  switchDishGfx(BasicDishVO.GFX_FRAME_PREPARE);
                  break;
               case STOVE_STATUS_COOKING:
                  _loc2_ = this.cookTimeLeft(getTimer());
                  _loc3_ = currentDish.getDuration() * 60000 / 2;
                  if(_loc2_ < _loc3_)
                  {
                     switchDishGfx(BasicDishVO.GFX_FRAME_COOKSECONDHALF);
                  }
                  else
                  {
                     switchDishGfx(BasicDishVO.GFX_FRAME_COOKFIRSTHALF);
                  }
                  break;
               case STOVE_STATUS_READY:
                  this.infoToolTip.hide();
                  switchDishGfx(BasicDishVO.GFX_FRAME_READY);
                  break;
               case STOVE_STATUS_ROTTEN:
                  this.infoToolTip.hide();
                  switchDishGfx(BasicDishVO.GFX_FRAME_ROTTEN);
                  this.addDirtLayer();
                  break;
               case STOVE_STATUS_DIRTY:
                  this.removeDishGfx();
                  this.addDirtLayer();
            }
            this.currentStatus = param1;
         }
         this.addIngeridentTip();
      }
      
      public function get isRotten() : Boolean
      {
         if(this.currentStatus == STOVE_STATUS_ROTTEN)
         {
            return true;
         }
         return false;
      }
      
      override public function set isClickable(param1:Boolean) : void
      {
         super.isClickable = param1;
         if(!isClickable)
         {
            this.ingredientTip.hide();
         }
      }
      
      override public function update(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(isClickable)
         {
            this.updateToolTip(param1);
         }
         switch(this.currentStatus)
         {
            case STOVE_STATUS_COOKING:
               if(!this.timeIsActive)
               {
                  return;
               }
               _loc3_ = this.cookTimeLeft(param1);
               _loc4_ = currentDish.getDuration() * 60000 / 2;
               if(this.cookTimeLeft(param1) < currentDish.getDuration() * 60000 / 2)
               {
                  switchDishGfx(BasicDishVO.GFX_FRAME_COOKSECONDHALF);
               }
               if(this.cookTimeLeft(param1) < 0)
               {
                  this.setStatus(STOVE_STATUS_READY);
               }
               break;
            case STOVE_STATUS_PREPARE:
               if(this._isPreparing)
               {
                  this.progressToolTip.update(Math.floor(100 - this.prepareTimeLeft(param1) / (this._prepareDuration * 10)));
                  if(this.prepareTimeLeft(param1) < 0)
                  {
                     this.prepareStepEnd();
                  }
               }
               break;
            case STOVE_STATUS_READY:
               if(this._isServing)
               {
                  this.progressToolTip.update(Math.floor(100 - this.servingTimeLeft(param1) / (this._servingDuration * 10)));
                  if(this.servingTimeLeft(param1) < 0)
                  {
                     this.servingEnd();
                  }
               }
               else
               {
                  if(!this.timeIsActive)
                  {
                     return;
                  }
                  if(this.rottenTimeLeft(param1) <= 0)
                  {
                     this.setStatus(STOVE_STATUS_ROTTEN);
                  }
               }
               break;
            case STOVE_STATUS_ROTTEN:
            case STOVE_STATUS_DIRTY:
               if(this._isCleaning)
               {
                  this.progressToolTip.update(Math.floor(100 - this.cleaningTimeLeft(param1) / (this._cleaningDuration * 10)));
                  if(this.cleaningTimeLeft(param1) < 0)
                  {
                     this.cleaningEnd();
                  }
               }
         }
      }
      
      public function stoveActionCook(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = param1[0];
         var _loc3_:int = param1[4];
         if(_loc2_ == STOVE_ERROR_OK)
         {
            switch(_loc3_)
            {
               case STOVE_STATE_NEW:
                  _loc4_ = param1[3];
                  this.stoveVO.cookedWithFancyIngredient = int(param1[5]) == 1;
                  this.addDish(_loc4_);
                  this.setStatus(STOVE_STATUS_PREPARE);
                  this.addIngeridentTip();
                  break;
               case STOVE_STATE_GO:
                  this.startCook(int(param1[6]));
            }
         }
      }
      
      public function stoveActionClean(param1:Array) : void
      {
         var _loc2_:int = param1[0];
         switch(_loc2_)
         {
            case STOVE_ERROR_OK:
               if(this.currentStatus == STOVE_STATUS_COOKING)
               {
                  this.cleanStove();
               }
               else
               {
                  this.cleaningStart();
               }
               break;
            case STOVE_ERROR_NOCLEANMONEY:
               this.removeFromWorklist();
         }
      }
      
      public function removeFromWorklist() : void
      {
         isInWorkList = false;
         this.playerCook.workNextItem();
      }
      
      public function stoveActionStartServe(param1:Array, param2:BasicCounter) : void
      {
         this._targetCounter = param2;
         this.servingStart();
      }
      
      public function stoveActionDeliverEnd(param1:Array) : Boolean
      {
         var _loc2_:int = param1[0];
         switch(_loc2_)
         {
            case STOVE_ERROR_OK:
               this.playerCook.removeDish();
               this._targetCounter.addDish(currentDish.wodId,-1,this.stoveVO.cookedWithFancyIngredient);
               currentDish = null;
               this._targetCounter = null;
               this.stoveVO.cookedWithFancyIngredient = false;
               this.playerCook.workNextItem();
               return true;
            default:
               return false;
         }
      }
      
      private function prepareCook() : void
      {
         this.prepareSteps = currentDish.requirements.length;
         if(this.stoveVO.cookedWithFancyIngredient)
         {
            this.prepareSteps += 1;
         }
         this.prepareStepsDone = 0;
      }
      
      public function prepareStepStart() : void
      {
         var _loc1_:String = null;
         if(this.prepareStepsDone < this.prepareSteps)
         {
            _loc1_ = this.prepareStepString;
            this.showProgressToolTip(CafeModel.languageData.getTextById(_loc1_));
            this._isPreparing = true;
            this._prepareStepEndTime = getTimer() + this._prepareDuration * 1000;
         }
      }
      
      private function prepareStepEnd() : void
      {
         this.progressToolTip.hide();
         this._isPreparing = false;
         isInWorkList = false;
         ++this.prepareStepsDone;
         this.playerCook.disp.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.WORKLIST_WORKNEXTITEM));
         if(this.prepareStepsDone == this.prepareSteps)
         {
            if(this.stoveVO.cookedWithFancyIngredient)
            {
               BasicController.getInstance().soundController.playSoundEffect(CafeSoundController.SND_FANCYPREPARESTEP);
            }
            this.startCook();
            world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.STOVE_EVENT,[CafeIsoEvent.STOVE_COOK,this]));
         }
         this.addIngeridentTip();
      }
      
      public function startCook(param1:Number = -1) : void
      {
         if(param1 < 0)
         {
            param1 = currentDish.baseDuration * 60;
         }
         this.setTimes(0,param1);
         this.setStatus(STOVE_STATUS_COOKING);
      }
      
      public function setDirtLayer() : void
      {
         this.progressToolTip.hide();
         this._isServing = false;
         this.setStatus(STOVE_STATUS_DIRTY);
      }
      
      public function cleaningStart() : void
      {
         this.showProgressToolTip(CafeModel.languageData.getTextById("preparestep_cleaning"));
         this._isCleaning = true;
         this._cleaningEndTime = getTimer() + this._cleaningDuration * 1000;
      }
      
      private function cleaningEnd() : void
      {
         this.progressToolTip.hide();
         this._isCleaning = false;
         isInWorkList = false;
         this.cleanStove();
         this.playerCook.disp.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.WORKLIST_WORKNEXTITEM));
      }
      
      private function cleanStove() : void
      {
         this.setStatus(STOVE_STATUS_FREE);
         this.removeDishGfx();
      }
      
      private function servingStart() : void
      {
         this.showProgressToolTip(CafeModel.languageData.getTextById("preparestep_serving"));
         this._isServing = true;
         this._servingEndTime = getTimer() + this._servingDuration * 1000;
      }
      
      private function servingEnd() : void
      {
         this.progressToolTip.hide();
         this._isServing = false;
         isInWorkList = false;
         this.setStatus(STOVE_STATUS_DIRTY);
         currentDish.fancy = this.stoveVO.cookedWithFancyIngredient;
         this.playerCook.deliverFood(currentDish,this._targetCounter,this);
      }
      
      private function updateToolTip(param1:Number) : void
      {
         if(!this.infoToolTip.isVisible)
         {
            return;
         }
         switch(this.currentStatus)
         {
            case STOVE_STATUS_COOKING:
               this.infoToolTip.update(Math.floor(this.cookTimeLeft(param1) / 1000),(this.endCookTime - this.startCookTime) / 1000);
               break;
            case STOVE_STATUS_READY:
               this.infoToolTip.update(Math.floor(this.rottenTimeLeft(param1) / 1000),(this.endCookTime - this.startCookTime) / 1000);
         }
      }
      
      public function updateToolTipTextFields() : void
      {
         if(this.infoToolTip)
         {
            this.infoToolTip.updateAllTextFields();
         }
         if(this.progressToolTip)
         {
            this.progressToolTip.updateAllTextFields();
         }
      }
      
      private function get currentPrepareRequirement() : RequirementVO
      {
         if(this.prepareStepsDone < this.prepareSteps - 1)
         {
            return currentDish.requirements[this.prepareStepsDone];
         }
         if(this.prepareStepsDone == this.prepareSteps - 1)
         {
            return !!this.stoveVO.cookedWithFancyIngredient ? currentDish.fancyRequirement : currentDish.requirements[this.prepareStepsDone];
         }
         return null;
      }
      
      public function get prepareStepString() : String
      {
         return "preparestep_" + String(currentDish.type).toLowerCase() + "_" + String(CafeModel.wodData.voList[this.currentPrepareRequirement.wodId].type).toLowerCase();
      }
      
      public function get cookStepString() : String
      {
         var _loc1_:String = "1";
         if(this.cookTimeLeft(getTimer()) < currentDish.getDuration() * 60000 / 2)
         {
            _loc1_ = "2";
         }
         return "cookstep_" + String(currentDish.type).toLowerCase() + _loc1_;
      }
      
      public function get ingredientMcName() : String
      {
         if(!this.currentPrepareRequirement)
         {
            return "";
         }
         var _loc1_:int = this.currentPrepareRequirement.wodId;
         return (CafeModel.wodData.voList[_loc1_] as VisualVO).getVisClassName();
      }
      
      private function showInfoToolTip() : void
      {
         switch(this.currentStatus)
         {
            case STOVE_STATUS_FREE:
               this.infoToolTip.showInfoToolTip(StoveInfoToolTip.STATE_FREE);
               break;
            case STOVE_STATUS_PREPARE:
               this.infoToolTip.showInfoToolTip(StoveInfoToolTip.STATE_PREPARE);
               break;
            case STOVE_STATUS_COOKING:
               this.infoToolTip.showInfoToolTip(StoveInfoToolTip.STATE_COOK);
               break;
            case STOVE_STATUS_READY:
               this.infoToolTip.showInfoToolTip(StoveInfoToolTip.STATE_READY);
               break;
            case STOVE_STATUS_ROTTEN:
               this.infoToolTip.showInfoToolTip(StoveInfoToolTip.STATE_SPOILED);
               break;
            case STOVE_STATUS_DIRTY:
               this.infoToolTip.showInfoToolTip(StoveInfoToolTip.STATE_CLEAN);
         }
         this.ingredientTip.hide();
      }
      
      public function addIngeridentTip() : void
      {
         if(isClickable && this.currentStatus == STOVE_STATUS_PREPARE)
         {
            if(this.prepareStepsDone < this.prepareSteps && !this.infoToolTip.isVisible)
            {
               this.ingredientTip.showIngredient(this.ingredientMcName);
            }
            else
            {
               this.ingredientTip.hide();
            }
         }
         else
         {
            this.ingredientTip.hide();
         }
      }
      
      private function showProgressToolTip(param1:String) : void
      {
         if(!isClickable)
         {
            return;
         }
         this.infoToolTip.hide();
         this.ingredientTip.hide();
         this.progressToolTip.showProgressTip(param1);
      }
      
      private function setTimes(param1:int = 0, param2:int = 0) : void
      {
         this.startCookTime = getTimer() - param1 * 1000;
         this.endCookTime = getTimer() + param2 * 1000;
         this.rottenCookTime = this.endCookTime + Math.max(CafeConstants.MIN_DISH_READY_TIME,currentDish.baseDuration) * 60 * 1000;
      }
      
      private function resetTimes() : void
      {
         this.startCookTime = -1;
         this.endCookTime = -1;
         this.rottenCookTime = -1;
      }
      
      public function cookTimeLeft(param1:Number) : int
      {
         return this.endCookTime < 0 ? 0 : int(this.endCookTime - param1);
      }
      
      private function rottenTimeLeft(param1:Number) : int
      {
         return this.rottenCookTime < 0 ? 0 : int(this.rottenCookTime - param1);
      }
      
      public function instaCook() : void
      {
         this.setStatus(STOVE_STATUS_READY);
         this.rottenCookTime = getTimer() + Math.max(CafeConstants.MIN_DISH_READY_TIME,currentDish.getDuration()) * 60000 / CafeConstants.timeFactor;
      }
      
      public function refreshFood(param1:Array) : void
      {
         var _loc2_:int = param1[0];
         switch(_loc2_)
         {
            case STOVE_ERROR_OK:
               this.removeDirtLayer();
               this.setStatus(STOVE_STATUS_READY);
               this.rottenCookTime = getTimer() + currentDish.baseDuration * 60000 / CafeConstants.timeFactor;
               this.removeFromWorklist();
               break;
            case STOVE_ERROR_NOCLEANMONEY:
               this.removeFromWorklist();
         }
      }
      
      private function prepareTimeLeft(param1:Number) : int
      {
         return this._prepareStepEndTime - param1;
      }
      
      private function cleaningTimeLeft(param1:Number) : int
      {
         return this._cleaningEndTime - param1;
      }
      
      private function servingTimeLeft(param1:Number) : int
      {
         return this._servingEndTime - param1;
      }
      
      public function activateTimer() : void
      {
         this.timeIsActive = true;
      }
      
      public function deactivateTimer() : void
      {
         this.timeIsActive = false;
      }
      
      public function addDish(param1:int) : void
      {
         var _loc2_:BasicDishVO = CafeModel.wodData.createVObyWOD(param1) as BasicDishVO;
         if(_loc2_)
         {
            _loc2_.checkFancyRequirements(CafeModel.wodData.voList);
            currentDish = _loc2_;
            if(this.stoveVO.cookedWithFancyIngredient)
            {
               this.addFacyLayer();
            }
            else
            {
               addDishGfx(currentDish);
            }
         }
      }
      
      private function addDirtLayer() : void
      {
         if(this.dirtLayer)
         {
            return;
         }
         var _loc1_:Class = getDefinitionByName(DIRTLAYERNAME) as Class;
         this.dirtLayer = new _loc1_();
         objectLayer.addChild(this.dirtLayer);
      }
      
      private function addFacyLayer() : void
      {
         if(this.fancyFrontLayer || this.fancyBackLayer)
         {
            return;
         }
         var _loc1_:Class = getDefinitionByName(FANCYFRONTLAYERNAME) as Class;
         this.fancyFrontLayer = new _loc1_();
         var _loc2_:Class = getDefinitionByName(FANCYBACKLAYERNAME) as Class;
         this.fancyBackLayer = new _loc2_();
         objectLayer.addChild(this.fancyBackLayer);
         addDishGfx(currentDish);
         objectLayer.addChild(this.fancyFrontLayer);
      }
      
      override protected function removeDishGfx() : void
      {
         if(this.stoveVO.cookedWithFancyIngredient)
         {
            this.removeFancyLayer();
         }
         super.removeDishGfx();
      }
      
      private function removeFancyLayer() : void
      {
         if(this.fancyFrontLayer)
         {
            objectLayer.removeChild(this.fancyFrontLayer);
            this.fancyFrontLayer = null;
         }
         if(this.fancyBackLayer)
         {
            objectLayer.removeChild(this.fancyBackLayer);
            this.fancyBackLayer = null;
         }
      }
      
      private function removeDirtLayer() : void
      {
         if(this.dirtLayer)
         {
            objectLayer.removeChild(this.dirtLayer);
            this.dirtLayer = null;
            this.resetTimes();
         }
      }
      
      override protected function onMouseUpRun(param1:MouseEvent) : void
      {
         disp.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.STOVE_EVENT,[CafeIsoEvent.STOVE_CLICK,this]));
      }
      
      override protected function onRollOverRun(param1:MouseEvent) : void
      {
         if(isClickable)
         {
            this.showInfoToolTip();
            this.ingredientTip.hide();
            addGlow();
         }
      }
      
      override protected function onRollOutRun(param1:MouseEvent) : void
      {
         this.infoToolTip.hide();
         this.addIngeridentTip();
         removeGlow();
      }
      
      private function get playerCook() : HeroMoving
      {
         return cafeIsoWorld.myPlayer;
      }
      
      public function get stoveVO() : BasicStoveVO
      {
         return vo as BasicStoveVO;
      }
   }
}
