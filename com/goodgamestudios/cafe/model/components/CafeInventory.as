package com.goodgamestudios.cafe.model.components
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.event.CafeInventoryEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import flash.utils.Dictionary;
   
   public class CafeInventory
   {
       
      
      public var inventoryItems:Dictionary;
      
      public function CafeInventory()
      {
         super();
      }
      
      public function parseInventory(param1:Array) : void
      {
      }
      
      public function hasItem(param1:int) : Boolean
      {
         if(DictionaryUtil.containsKey(this.inventoryItems,param1))
         {
            return true;
         }
         return false;
      }
      
      public function getInventoryAmountByWodId(param1:int) : int
      {
         if(DictionaryUtil.containsKey(this.inventoryItems,param1))
         {
            return this.inventoryItems[param1].inventoryAmount;
         }
         return 0;
      }
      
      public function getInventoryAmountByGroup(param1:String) : int
      {
         var _loc3_:ShopVO = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.inventoryItems)
         {
            if(_loc3_.group == param1)
            {
               _loc2_ += _loc3_.inventoryAmount;
            }
         }
         return _loc2_;
      }
      
      public function getInventoryAmountByName(param1:String) : int
      {
         return this.getInventoryByName(param1).length;
      }
      
      public function getInventoryByWodId(param1:int) : ShopVO
      {
         if(DictionaryUtil.containsKey(this.inventoryItems,param1))
         {
            return this.inventoryItems[param1];
         }
         return null;
      }
      
      public function getInventoryByGroup(param1:String) : Array
      {
         var _loc3_:ShopVO = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.inventoryItems)
         {
            if(_loc3_.group == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getInventoryByName(param1:String) : Array
      {
         var _loc3_:ShopVO = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.inventoryItems)
         {
            if(_loc3_.name == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function addItem(param1:int, param2:int = 1) : void
      {
         var _loc3_:ShopVO = null;
         if(!this.inventoryItems)
         {
            this.inventoryItems = new Dictionary();
         }
         if(DictionaryUtil.containsKey(this.inventoryItems,param1))
         {
            this.inventoryItems[param1].inventoryAmount += param2;
         }
         else
         {
            _loc3_ = CafeModel.wodData.createVObyWOD(param1) as ShopVO;
            _loc3_.inventoryAmount = param2;
            this.inventoryItems[param1] = _loc3_;
         }
         BasicController.getInstance().dispatchEvent(new CafeInventoryEvent(CafeInventoryEvent.UPDATE_INVENTORY,param1));
      }
      
      public function removeItem(param1:int, param2:int = 1) : void
      {
         if(DictionaryUtil.containsKey(this.inventoryItems,param1))
         {
            if(this.inventoryItems[param1].inventoryAmount <= param2)
            {
               delete this.inventoryItems[param1];
            }
            else
            {
               this.inventoryItems[param1].inventoryAmount -= param2;
            }
         }
         BasicController.getInstance().dispatchEvent(new CafeInventoryEvent(CafeInventoryEvent.UPDATE_INVENTORY,param1));
      }
   }
}
