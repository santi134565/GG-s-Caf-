package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.event.CafeInventoryEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import flash.utils.Dictionary;
   
   public class CafeInventoryFridge extends CafeInventory
   {
       
      
      private var inventorySize:int;
      
      private var _capacityMax:int;
      
      private var _used:int;
      
      public function CafeInventoryFridge()
      {
         super();
      }
      
      override public function parseInventory(param1:Array) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:ShopVO = null;
         inventoryItems = new Dictionary();
         this._used = 0;
         this._capacityMax = 0;
         if(param1[0] != "")
         {
            this.inventorySize = param1.shift();
            this._capacityMax = this.inventorySize;
            _loc2_ = param1[0].split("#");
            if(_loc2_[0] != "")
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc5_ = (_loc4_ = _loc2_[_loc3_].split("+")).shift();
                  (_loc6_ = CafeModel.wodData.createVObyWOD(_loc5_) as ShopVO).inventoryAmount = _loc4_.shift();
                  inventoryItems[_loc5_] = _loc6_;
                  if((_loc6_ as BasicIngredientVO).category != "fancy")
                  {
                     this._used += _loc6_.inventoryAmount;
                  }
                  _loc3_++;
               }
            }
         }
         BasicController.getInstance().dispatchEvent(new CafeInventoryEvent(CafeInventoryEvent.CHANGE_FRIDGESIZE));
      }
      
      public function isItemInInventoryFridge(param1:int) : Boolean
      {
         var _loc2_:BasicIngredientVO = null;
         for each(_loc2_ in inventoryItems)
         {
            if(_loc2_.wodId == param1 && _loc2_.amount > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function addCapacity(param1:int) : void
      {
         this._capacityMax += param1;
         BasicController.getInstance().dispatchEvent(new CafeInventoryEvent(CafeInventoryEvent.CHANGE_FRIDGESIZE));
      }
      
      public function removeCapacity(param1:int) : void
      {
         this._capacityMax -= param1;
         BasicController.getInstance().dispatchEvent(new CafeInventoryEvent(CafeInventoryEvent.CHANGE_FRIDGESIZE));
      }
      
      public function get capacity() : int
      {
         return this._capacityMax - this._used;
      }
      
      public function get inUsed() : int
      {
         return this._used;
      }
      
      public function get numFancy() : int
      {
         var _loc2_:ShopVO = null;
         var _loc1_:int = 0;
         for each(_loc2_ in inventoryItems)
         {
            if(_loc2_ && (_loc2_ as BasicIngredientVO).category == "fancy")
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get maxCapacity() : int
      {
         return this._capacityMax;
      }
      
      override public function addItem(param1:int, param2:int = 1) : void
      {
         if((CafeModel.wodData.voList[param1] as BasicIngredientVO).category != "fancy")
         {
            this._used += param2;
         }
         super.addItem(param1,param2);
      }
      
      override public function removeItem(param1:int, param2:int = 1) : void
      {
         if((CafeModel.wodData.voList[param1] as BasicIngredientVO).category != "fancy")
         {
            this._used -= param2;
         }
         super.removeItem(param1,param2);
      }
   }
}
