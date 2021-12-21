package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeGiftEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.vo.BuddyVO;
   import com.goodgamestudios.cafe.world.vo.gift.GiftVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.geom.Point;
   
   public class CafeGiftList
   {
       
      
      public var numNewGifts:int;
      
      private var _myGifts:Array;
      
      private var _sendableGifts:Array;
      
      private var _allreadySendPlayerId:Array;
      
      private var _canSendGifts:Boolean;
      
      public function CafeGiftList()
      {
         super();
         this.reset();
      }
      
      public function reset() : void
      {
         this.numNewGifts = 0;
         this._myGifts = new Array();
         this._sendableGifts = new Array();
         this._allreadySendPlayerId = new Array();
         this._canSendGifts = true;
      }
      
      public function parseMyGifts(param1:Array) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:GiftVO = null;
         this._myGifts = new Array();
         if(param1.length > 0)
         {
            _loc2_ = param1[0].split("#");
            while(_loc2_.length > 0 && _loc2_[0] != "")
            {
               _loc3_ = _loc2_.shift().split("+");
               (_loc4_ = new GiftVO(_loc3_.shift(),_loc3_.shift())).giftAmount = _loc3_.shift();
               _loc4_.senderPlayerId = _loc3_.shift();
               _loc4_.date = _loc3_.shift();
               this._myGifts.push(_loc4_);
            }
         }
         BasicController.getInstance().dispatchEvent(new CafeGiftEvent(CafeGiftEvent.CHANGE_MYGIFTS));
      }
      
      public function parseSendableGifts(param1:Array) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:GiftVO = null;
         this._sendableGifts = new Array();
         if(param1.length > 0)
         {
            _loc2_ = param1[0].split("#");
            while(_loc2_.length > 0 && _loc2_[0] != "")
            {
               _loc3_ = _loc2_.shift().split("+");
               (_loc4_ = new GiftVO(-1,_loc3_.shift())).giftAmount = _loc3_.shift();
               this._sendableGifts.push(_loc4_);
            }
         }
         BasicController.getInstance().dispatchEvent(new CafeGiftEvent(CafeGiftEvent.CHANGE_SENDABLEGIFTS));
      }
      
      public function parseAllreadySendPlayerIds(param1:Array) : void
      {
         var _loc2_:Array = null;
         this._allreadySendPlayerId = new Array();
         this._canSendGifts = int(param1.shift()) == 1;
         if(param1.length > 0)
         {
            _loc2_ = param1[0].split("+");
            while(_loc2_.length > 0 && _loc2_[0] != "")
            {
               this._allreadySendPlayerId.push(_loc2_.shift());
            }
         }
         BasicController.getInstance().dispatchEvent(new CafeGiftEvent(CafeGiftEvent.CHANGE_ALLREADYSENDPLAYERLIST));
      }
      
      public function removeGift(param1:int) : void
      {
         var _loc3_:GiftVO = null;
         if(this.layoutManager.currentState != CafeLayoutManager.STATE_MY_CAFE)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._myGifts.length)
         {
            _loc3_ = this._myGifts[_loc2_];
            if(_loc3_.id == param1)
            {
               this._myGifts.splice(_loc2_,1);
               BasicController.getInstance().dispatchEvent(new CafeGiftEvent(CafeGiftEvent.CHANGE_MYGIFTS));
               return;
            }
            _loc2_++;
         }
      }
      
      public function useGift(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BasicCounter = null;
         var _loc2_:int = param1.shift();
         var _loc3_:int = param1.shift();
         var _loc4_:VisualVO = CafeModel.wodData.createVObyWOD(_loc2_);
         switch(_loc4_.group)
         {
            case CafeConstants.GROUP_DISH:
               _loc5_ = param1.shift();
               _loc6_ = param1.shift();
               if(_loc7_ = this.layoutManager.isoScreen.isoWorld.getIsoObjectByPoint(new Point(_loc5_,_loc6_)) as BasicCounter)
               {
                  _loc7_.addDish(_loc2_,_loc3_);
               }
               break;
            case CafeConstants.GROUP_INGREDIENT:
               if(this.layoutManager.currentState == CafeLayoutManager.STATE_MY_CAFE)
               {
                  CafeModel.inventoryFridge.addItem(_loc2_,_loc3_);
               }
         }
      }
      
      public function getSendableGiftByWodId(param1:int) : GiftVO
      {
         var _loc2_:GiftVO = null;
         for each(_loc2_ in this._sendableGifts)
         {
            if(_loc2_.giftWodId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMyGifts() : Array
      {
         return this._myGifts.sortOn("date",[Array.DESCENDING]);
      }
      
      public function get canSendGifts() : Boolean
      {
         return this._canSendGifts;
      }
      
      public function getSendableGifts() : Array
      {
         return this._sendableGifts.sortOn("category");
      }
      
      public function getSendablePlayerList(param1:Array) : Array
      {
         var _loc3_:BuddyVO = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            if(!this.allreadySendedPlayer(_loc3_.playerId))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_.sortOn("playerXp",[Array.DESCENDING]);
      }
      
      public function get numGifts() : int
      {
         return this.numNewGifts + this._myGifts.length;
      }
      
      private function allreadySendedPlayer(param1:int) : Boolean
      {
         return this._allreadySendPlayerId.indexOf(param1.toString()) >= 0;
      }
      
      protected function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
   }
}
