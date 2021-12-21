package com.goodgamestudios.cafe.world.objects.counter
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.info.CounterToolTip;
   import com.goodgamestudios.cafe.world.objects.DishHolderFloorObject;
   import com.goodgamestudios.cafe.world.vo.counter.BasicCounterVO;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import flash.events.MouseEvent;
   
   public class BasicCounter extends DishHolderFloorObject
   {
      
      private static const COUNTER_ERROR_OK:int = 0;
      
      public static const COUNTER_STATUS_FREE:int = 0;
      
      public static const COUNTER_STATUS_FULL:int = 1;
      
      private static const DISH_ID_NODISH:int = -1;
      
      private static const DISH_YSHIFT:int = -35;
       
      
      private var infoToolTip:CounterToolTip;
      
      public var currentStatus:int;
      
      public function BasicCounter()
      {
         super();
         dishYShift = DISH_YSHIFT;
         isMutable = true;
         isClickable = true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.infoToolTip = new CounterToolTip(this);
         world.toolTipLayer.addChild(this.infoToolTip.disp);
         this.initDish();
      }
      
      override public function get removeAllowed() : Boolean
      {
         if(this.currentStatus == COUNTER_STATUS_FREE)
         {
            return true;
         }
         return false;
      }
      
      override public function update(param1:Number) : void
      {
         if(!this.infoToolTip.isVisible)
         {
            return;
         }
         this.infoToolTip.update();
      }
      
      public function initDish() : void
      {
         if(this.counterVO.dishID == DISH_ID_NODISH)
         {
            this.setStatus(COUNTER_STATUS_FREE);
         }
         else
         {
            this.addDish(this.counterVO.dishID,this.counterVO.dishAmount);
         }
      }
      
      public function refreshDish() : void
      {
         var _loc1_:BasicDishVO = null;
         if(this.counterVO.dishID == DISH_ID_NODISH)
         {
            this.setStatus(COUNTER_STATUS_FREE);
         }
         else
         {
            _loc1_ = CafeModel.wodData.createVObyWOD(this.counterVO.dishID) as BasicDishVO;
            switch(this.currentStatus)
            {
               case COUNTER_STATUS_FREE:
                  currentDish = _loc1_;
                  this.setStatus(COUNTER_STATUS_FULL);
                  currentDish.amount = _loc1_.getServings();
                  break;
               case COUNTER_STATUS_FULL:
                  if(this.counterVO.dishID == currentDish.wodId)
                  {
                     currentDish.amount = this.counterVO.dishAmount;
                  }
            }
         }
      }
      
      public function servDish() : void
      {
         isInWorkList = false;
         if(currentDish)
         {
            --currentDish.amount;
            if(currentDish.amount == 0)
            {
               this.counterVO.dishID = DISH_ID_NODISH;
               this.initDish();
            }
         }
      }
      
      public function addDish(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:BasicDishVO;
         (_loc4_ = CafeModel.wodData.createVObyWOD(param1) as BasicDishVO).fancy = param3;
         if(param2 < 0)
         {
            param2 = _loc4_.getServings();
         }
         switch(this.currentStatus)
         {
            case COUNTER_STATUS_FREE:
               currentDish = _loc4_;
               this.setStatus(COUNTER_STATUS_FULL);
               currentDish.amount = param2;
               break;
            case COUNTER_STATUS_FULL:
               if(param1 == currentDish.wodId)
               {
                  currentDish.amount += param2;
               }
         }
      }
      
      public function addOneServingDish(param1:int) : Boolean
      {
         var _loc2_:BasicDishVO = null;
         switch(this.currentStatus)
         {
            case COUNTER_STATUS_FREE:
               _loc2_ = CafeModel.wodData.createVObyWOD(param1) as BasicDishVO;
               if(_loc2_)
               {
                  _loc2_.checkFancyRequirements(CafeModel.wodData.voList);
                  currentDish = _loc2_;
                  this.setStatus(COUNTER_STATUS_FULL);
                  currentDish.amount = 1;
                  return true;
               }
               break;
            case COUNTER_STATUS_FULL:
               if(param1 == currentDish.wodId)
               {
                  currentDish.amount += 1;
                  return true;
               }
               break;
         }
         return false;
      }
      
      private function removeDish() : void
      {
         currentDish = null;
         removeDishGfx();
      }
      
      public function setStatus(param1:int) : void
      {
         if(param1 != this.currentStatus)
         {
            switch(param1)
            {
               case COUNTER_STATUS_FREE:
                  this.removeDish();
                  break;
               case COUNTER_STATUS_FULL:
                  addDishGfx(currentDish);
                  switchDishGfx(BasicDishVO.GFX_FRAME_READY);
            }
            this.currentStatus = param1;
         }
      }
      
      public function counterActionClean(param1:Array) : void
      {
         var _loc2_:int = param1[0];
         switch(_loc2_)
         {
            case COUNTER_ERROR_OK:
               this.setStatus(COUNTER_STATUS_FREE);
         }
      }
      
      override protected function onMouseUpRun(param1:MouseEvent) : void
      {
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.COUNTER_CLICK,[this]));
      }
      
      override protected function onRollOverRun(param1:MouseEvent) : void
      {
         if(isClickable)
         {
            addGlow();
         }
         if(cafeIsoWorld.cafeWorldType == CafeConstants.CAFE_WORLD_TYPE_MYCAFE)
         {
            this.showInfoToolTip();
         }
      }
      
      override protected function onRollOutRun(param1:MouseEvent) : void
      {
         this.infoToolTip.hide();
         removeGlow();
      }
      
      public function updateToolTipTextFields() : void
      {
         if(this.infoToolTip)
         {
            this.infoToolTip.updateAllTextFields();
         }
      }
      
      public function get counterVO() : BasicCounterVO
      {
         return vo as BasicCounterVO;
      }
      
      private function showInfoToolTip() : void
      {
         switch(this.currentStatus)
         {
            case COUNTER_STATUS_FREE:
               this.infoToolTip.showInfoToolTip(CounterToolTip.STATE_FREE);
               break;
            case COUNTER_STATUS_FULL:
               this.infoToolTip.showInfoToolTip(CounterToolTip.STATE_FULL);
         }
      }
   }
}
