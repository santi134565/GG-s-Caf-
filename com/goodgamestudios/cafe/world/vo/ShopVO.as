package com.goodgamestudios.cafe.world.vo
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.isocore.vo.VisualVO;
   
   public class ShopVO extends VisualVO
   {
       
      
      public var itemCash:int;
      
      public var itemGold:int;
      
      public var itenXp:int;
      
      public var itemLevel:int;
      
      public var itemAmount:int;
      
      public var isNew:Boolean;
      
      public var inventoryAmount:int;
      
      public var worldIndex:int;
      
      public var friends:int;
      
      public var releaseDate:Number;
      
      public var goldNoFriends:int;
      
      public var events:Array;
      
      public function ShopVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         this.worldIndex = parseInt(param1.attribute("world"));
         this.itemCash = parseInt(param1.attribute("cash"));
         this.itemGold = parseInt(param1.attribute("gold"));
         this.itenXp = parseInt(param1.attribute("xp"));
         this.itemLevel = parseInt(param1.attribute("level"));
         this.friends = parseInt(param1.attribute("friends"));
         this.releaseDate = parseInt(param1.attribute("releaseDate"));
         this.goldNoFriends = parseInt(param1.attribute("goldNoFriends"));
         var _loc2_:String = param1.attribute("events");
         this.events = _loc2_.split("+");
      }
      
      public function get highestEventId() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         for each(_loc2_ in this.events)
         {
            _loc1_ = Math.max(_loc1_,_loc2_);
         }
         return _loc1_;
      }
      
      public function set highestEventId(param1:int) : void
      {
      }
      
      public function calculateSaleValueCash() : int
      {
         return Math.round(this.itemCash * CafeConstants.sellFactorCash + this.itemGold * CafeConstants.sellFactorGold);
      }
      
      public function calculateSaleValueGold() : int
      {
         return 0;
      }
      
      public function getLuxury() : int
      {
         return this.itemGold * 2 + Math.max(0,Math.min(5,this.itemCash / 4000));
      }
      
      override public function isItemAvalibleByEvent() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(_loc1_ in this.events)
         {
            for each(_loc2_ in CafeModel.sessionData.currentEvents)
            {
               if(_loc1_ == _loc2_)
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}
