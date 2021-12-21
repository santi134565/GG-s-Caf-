package com.goodgamestudios.cafe.world.objects.table
{
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.DishHolderFloorObject;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class BasicTable extends DishHolderFloorObject
   {
      
      private static const TIMEFAKTOR:int = 22000;
      
      private static const DISH_YSHIFT:int = -32;
      
      private static const DISH_STATE_READY:int = 1;
      
      private static const DISH_STATE_EATHALF:int = 2;
      
      public static const DISH_STATE_EATFULL:int = 3;
       
      
      private var _currentDishState:int = 1;
      
      private var _isClickedByPlayer:Boolean;
      
      private var endEatTime:Number = 0;
      
      private var startEating:Boolean = false;
      
      private var finishEating:Boolean = false;
      
      public function BasicTable()
      {
         super();
         dishYShift = DISH_YSHIFT;
         this.isClickable = false;
         this._isClickedByPlayer = false;
      }
      
      override public function set isClickable(param1:Boolean) : void
      {
         super.isClickable = param1;
      }
      
      override public function update(param1:Number) : void
      {
         if(currentDish && this.startEating && !this.finishEating)
         {
            this.switchDishState();
         }
      }
      
      private function setTimes(param1:int = 0) : void
      {
         if(!currentDish)
         {
            return;
         }
         var _loc2_:Number = getTimer() - param1 * 1000;
         this.endEatTime = _loc2_ + TIMEFAKTOR;
      }
      
      private function eatTimeLeft(param1:Number) : int
      {
         return this.endEatTime - param1;
      }
      
      public function guestEatUp() : void
      {
         if(!currentDish)
         {
            return;
         }
         this.currentDishState = DISH_STATE_EATFULL;
      }
      
      public function switchDishState() : void
      {
         if(this.eatTimeLeft(getTimer()) < 0 && this._currentDishState != DISH_STATE_EATFULL)
         {
            this.currentDishState = DISH_STATE_EATFULL;
            this.finishEating = true;
            return;
         }
         if(this.eatTimeLeft(getTimer()) < TIMEFAKTOR / 2 && this._currentDishState != DISH_STATE_EATHALF)
         {
            this.currentDishState = DISH_STATE_EATHALF;
            return;
         }
      }
      
      public function addDish(param1:int, param2:int = 1) : void
      {
         var _loc3_:BasicDishVO = CafeModel.wodData.createVObyWOD(param1) as BasicDishVO;
         if(_loc3_)
         {
            currentDish = _loc3_;
            addDishGfx(currentDish);
            this.currentDishState = param2;
            if(this.startEating)
            {
               this.setTimes();
            }
         }
      }
      
      public function set currentDishState(param1:int) : void
      {
         switch(param1)
         {
            case DISH_STATE_READY:
               switchDishGfx(BasicDishVO.GFX_FRAME_READY);
               break;
            case DISH_STATE_EATHALF:
               switchDishGfx(BasicDishVO.GFX_FRAME_EATHALF);
               break;
            case DISH_STATE_EATFULL:
               switchDishGfx(BasicDishVO.GFX_FRAME_EATFULL);
               this.endEatTime = 0;
         }
         this._currentDishState = param1;
      }
      
      public function get currentDishState() : int
      {
         return this._currentDishState;
      }
      
      public function initEating() : void
      {
         this.startEating = true;
         this.finishEating = false;
         this.setTimes();
      }
      
      public function removeDish() : void
      {
         this.isClickable = false;
         this.startEating = false;
         currentDish = null;
         removeDishGfx();
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         if(isClickable && cafeIsoWorld.myPlayer.isFreeForWaiterAction)
         {
            disp.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.TABLE_CLICK));
         }
         else
         {
            super.onMouseDown(param1);
         }
      }
      
      override protected function onRollOverRun(param1:MouseEvent) : void
      {
         if(isClickable)
         {
            addGlow();
         }
      }
      
      override protected function onRollOutRun(param1:MouseEvent) : void
      {
         if(!this._isClickedByPlayer)
         {
            removeGlow();
         }
      }
      
      public function set clickedByPlayer(param1:Boolean) : void
      {
         this._isClickedByPlayer = param1;
         if(this._isClickedByPlayer && CafeModel.userData.isMyPlayerWaiter)
         {
            addGlow();
         }
         else
         {
            removeGlow();
         }
      }
   }
}
