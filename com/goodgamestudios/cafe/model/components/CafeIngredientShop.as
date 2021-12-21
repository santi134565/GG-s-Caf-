package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.event.CafeInventoryEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.utils.Dictionary;
   
   public class CafeIngredientShop
   {
       
      
      private var _ingredients:Vector.<BasicIngredientVO>;
      
      public function CafeIngredientShop()
      {
         super();
      }
      
      public function buildIngredientShop(param1:Dictionary) : void
      {
         var _loc2_:VisualVO = null;
         this._ingredients = new Vector.<BasicIngredientVO>();
         for each(_loc2_ in param1)
         {
            if(_loc2_.group == "Ingredient")
            {
               this._ingredients.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
         }
      }
      
      public function setAvailibility(param1:Array) : void
      {
         var _loc2_:Array = null;
         var _loc3_:BasicIngredientVO = null;
         if(param1[0].length > 0)
         {
            _loc2_ = param1[0].split("#");
            for each(_loc3_ in this._ingredients)
            {
               if(_loc2_.indexOf(String(_loc3_.wodId)) >= 0)
               {
                  _loc3_.availibility = false;
               }
               else
               {
                  _loc3_.availibility = true;
               }
            }
         }
         BasicController.getInstance().dispatchEvent(new CafeInventoryEvent(CafeInventoryEvent.CHANGE_AVAILIBILITY));
      }
      
      public function getIngredientVOById(param1:int) : BasicIngredientVO
      {
         var _loc2_:BasicIngredientVO = null;
         for each(_loc2_ in this._ingredients)
         {
            if(_loc2_.wodId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get ingredients() : Vector.<BasicIngredientVO>
      {
         return this._ingredients.sort(this.sortByLevelMoney);
      }
      
      private function sortByLevelMoney(param1:BasicIngredientVO, param2:BasicIngredientVO) : Number
      {
         if(param1.itemLevel < param2.itemLevel)
         {
            return -1;
         }
         if(param1.itemLevel > param2.itemLevel)
         {
            return 1;
         }
         if(param1.events.length > 0 && param2.events.length > 0)
         {
            if(param1.events[0] > param2.events[0])
            {
               return -1;
            }
            if(param1.events[0] < param2.events[0])
            {
               return 1;
            }
         }
         if(param1.itemGold < param2.itemGold)
         {
            return -1;
         }
         if(param1.itemGold > param2.itemGold)
         {
            return 1;
         }
         if(param1.itemCash < param2.itemCash)
         {
            return -1;
         }
         if(param1.itemCash > param2.itemCash)
         {
            return 1;
         }
         return param1.type.localeCompare(param2.type);
      }
   }
}
