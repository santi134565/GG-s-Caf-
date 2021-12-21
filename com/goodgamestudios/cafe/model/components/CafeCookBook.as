package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.isocore.vo.VOHelper;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.utils.Dictionary;
   
   public class CafeCookBook
   {
       
      
      private var _dishes:Vector.<BasicDishVO>;
      
      public function CafeCookBook()
      {
         super();
      }
      
      public function buildCookBook(param1:Dictionary) : void
      {
         var _loc2_:VisualVO = null;
         var _loc3_:BasicDishVO = null;
         this._dishes = new Vector.<BasicDishVO>();
         for each(_loc2_ in param1)
         {
            if(_loc2_.group == "Dish")
            {
               _loc3_ = CafeModel.wodData.createVObyWOD(_loc2_.wodId) as BasicDishVO;
               _loc3_.checkFancyRequirements(param1);
               this._dishes.push(_loc3_);
            }
         }
      }
      
      public function get dishes() : Vector.<BasicDishVO>
      {
         return this._dishes.sort(this.sortByLevelEvent);
      }
      
      private function sortByLevelEvent(param1:BasicDishVO, param2:BasicDishVO) : Number
      {
         if(param1.level < param2.level)
         {
            return -1;
         }
         if(param1.level > param2.level)
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
            if(param1.baseDuration < param2.baseDuration)
            {
               return -1;
            }
            if(param1.baseDuration > param2.baseDuration)
            {
               return 1;
            }
         }
         return 0;
      }
      
      public function getDishesByLevel(param1:int) : Array
      {
         var _loc3_:* = null;
         var _loc4_:BasicDishVO = null;
         var _loc2_:Array = new Array();
         for(_loc3_ in this._dishes)
         {
            if((_loc4_ = this._dishes[_loc3_]).level == param1 && _loc4_.isItemAvalibleByEvent())
            {
               _loc2_.push(VOHelper.clone(_loc4_));
            }
         }
         return _loc2_;
      }
   }
}
