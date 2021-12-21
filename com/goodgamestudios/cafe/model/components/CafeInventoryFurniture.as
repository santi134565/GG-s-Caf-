package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import flash.utils.Dictionary;
   
   public class CafeInventoryFurniture extends CafeInventory
   {
       
      
      public var numNew:int = 0;
      
      public function CafeInventoryFurniture()
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
         if(param1[0] != "")
         {
            _loc2_ = param1[0].split("#");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc5_ = (_loc4_ = _loc2_[_loc3_].split("+")).shift();
               if(_loc6_ = CafeModel.wodData.createVObyWOD(_loc5_) as ShopVO)
               {
                  _loc6_.inventoryAmount = _loc4_.shift();
                  inventoryItems[_loc5_] = _loc6_;
               }
               _loc3_++;
            }
         }
      }
   }
}
