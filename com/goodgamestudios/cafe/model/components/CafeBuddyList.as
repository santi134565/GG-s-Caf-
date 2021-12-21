package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeBuddyEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.BuddyVO;
   
   public class CafeBuddyList
   {
      
      private static const DELIMITER1:String = "|||";
      
      private static const DELIMITER2:String = "|";
      
      private static const INGAMEBUDDIES:int = 0;
       
      
      private const MAX_SOCIALUSER:int = 250;
      
      private var flashVarBuddyData:String = "";
      
      private var _preSocialBuddies:Array;
      
      private var _completeSocialBuddies:Array;
      
      private var _ingameBuddies:Array;
      
      public function CafeBuddyList(param1:String = null)
      {
         this._preSocialBuddies = [];
         this._completeSocialBuddies = [];
         this._ingameBuddies = [];
         super();
         this.flashVarBuddyData = param1;
         this._preSocialBuddies = [];
         this._completeSocialBuddies = [];
      }
      
      public function getSocialBuddyData() : void
      {
         var _loc6_:BuddyVO = null;
         this._preSocialBuddies = [];
         this._completeSocialBuddies = [];
         var _loc1_:Array = new Array();
         if(this.flashVarBuddyData)
         {
            _loc1_ = this.flashVarBuddyData.split(DELIMITER1);
         }
         if(!this.flashVarBuddyData || this.flashVarBuddyData == "" || _loc1_[0] == "")
         {
            BasicController.getInstance().dispatchEvent(new CafeBuddyEvent(CafeBuddyEvent.CHANGE_BUDDYDATA));
            return;
         }
         var _loc2_:Array = _loc1_[0].split(DELIMITER2);
         if(_loc2_[0] == "")
         {
            return;
         }
         var _loc3_:Array = _loc1_[1].split(DELIMITER2);
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc5_ < Math.min(_loc2_.length,this.MAX_SOCIALUSER))
         {
            (_loc6_ = new BuddyVO()).pln = String(_loc2_[_loc5_]);
            _loc6_.thumbUrl = _loc3_[_loc5_];
            _loc4_ += _loc6_.pln + DELIMITER2;
            this._preSocialBuddies.push(_loc6_);
            _loc5_++;
         }
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_SOCIAL_BUDDIES,[_loc4_]);
      }
      
      public function addSocialBuddyAvatarInfo(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:BuddyVO = null;
         var _loc2_:Array = String(param1.shift()).split("||");
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.split("|");
            _loc5_ = String(_loc4_.shift());
            _loc6_ = parseInt(_loc4_.shift());
            for each(_loc7_ in this._preSocialBuddies)
            {
               if(_loc7_.pln == _loc5_)
               {
                  _loc7_.playerId = _loc6_;
                  if(this.isIngameBuddyByPlayerId(_loc6_))
                  {
                     this.removeBuddy(_loc6_);
                  }
                  _loc7_.playerXp = _loc4_.shift();
                  _loc7_.playerName = _loc4_.shift();
                  _loc7_.isSocialFriend = true;
                  if(_loc7_.playerName != "")
                  {
                     _loc7_.buddyGender = _loc4_.shift();
                     CafeModel.otherUserData.parseAvatarParts(_loc4_.shift(),_loc7_);
                     this._completeSocialBuddies.push(_loc7_);
                  }
               }
            }
         }
         this._completeSocialBuddies.sortOn("playerXp",Array.NUMERIC | Array.DESCENDING);
         BasicController.getInstance().dispatchEvent(new CafeBuddyEvent(CafeBuddyEvent.CHANGE_BUDDYDATA));
      }
      
      public function addIngameBuddyAvatarInfo(param1:Array) : void
      {
         var _loc2_:String = null;
         this._ingameBuddies = [];
         if(param1[0] == "")
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            this.addBuddy(_loc2_);
         }
         this._ingameBuddies.sortOn("playerXp",Array.NUMERIC | Array.DESCENDING);
         BasicController.getInstance().dispatchEvent(new CafeBuddyEvent(CafeBuddyEvent.CHANGE_BUDDYDATA));
      }
      
      public function getBuddyByPlayerId(param1:int) : BuddyVO
      {
         var _loc2_:BuddyVO = null;
         var _loc3_:BuddyVO = null;
         for each(_loc2_ in this.socialBuddyList)
         {
            if(_loc2_.playerId == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc3_ in this.ingameBuddyList)
         {
            if(_loc3_.playerId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function isIngameBuddyByPlayerId(param1:int) : Boolean
      {
         var _loc2_:BuddyVO = null;
         for each(_loc2_ in this.ingameBuddyList)
         {
            if(_loc2_.playerId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isSocialBuddyByPlayerId(param1:int) : Boolean
      {
         var _loc2_:BuddyVO = null;
         for each(_loc2_ in this.socialBuddyList)
         {
            if(_loc2_.playerId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isBuddyByPlayerId(param1:int) : Boolean
      {
         var _loc2_:BuddyVO = null;
         for each(_loc2_ in this.completeBuddyList)
         {
            if(_loc2_ && _loc2_.playerId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function addBuddy(param1:String) : void
      {
         this._ingameBuddies.push(CafeModel.otherUserData.buildBuddyVO(param1));
         BasicController.getInstance().dispatchEvent(new CafeBuddyEvent(CafeBuddyEvent.CHANGE_BUDDYDATA));
      }
      
      public function removeBuddy(param1:int) : void
      {
         var _loc3_:BuddyVO = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.ingameBuddyList.length)
         {
            _loc3_ = this.ingameBuddyList[_loc2_];
            if(_loc3_.playerId == param1)
            {
               this.ingameBuddyList.splice(_loc2_,1);
               BasicController.getInstance().dispatchEvent(new CafeBuddyEvent(CafeBuddyEvent.CHANGE_BUDDYDATA));
               return;
            }
            _loc2_++;
         }
      }
      
      public function reset() : void
      {
         this._preSocialBuddies = [];
         this._completeSocialBuddies = [];
         this._ingameBuddies = [];
      }
      
      public function get socialBuddyList() : Array
      {
         if(this._completeSocialBuddies)
         {
            return this._completeSocialBuddies;
         }
         return [];
      }
      
      public function get ingameBuddyList() : Array
      {
         if(this._ingameBuddies)
         {
            return this._ingameBuddies;
         }
         return [];
      }
      
      public function get completeBuddyList() : Array
      {
         if(this._completeSocialBuddies)
         {
            this._completeSocialBuddies.sortOn("playerXp",Array.NUMERIC | Array.DESCENDING);
         }
         if(this._ingameBuddies)
         {
            this._ingameBuddies.sortOn("playerXp",Array.NUMERIC | Array.DESCENDING);
         }
         return this._completeSocialBuddies.concat(this._ingameBuddies);
      }
      
      public function get amountSocialFriends() : int
      {
         return this._completeSocialBuddies.length;
      }
      
      public function get amountIngameFriends() : int
      {
         return this._ingameBuddies.length;
      }
      
      public function get amountAllFriends() : int
      {
         return this.completeBuddyList.length;
      }
   }
}
