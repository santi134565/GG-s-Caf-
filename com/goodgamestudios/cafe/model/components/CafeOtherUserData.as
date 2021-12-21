package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.event.CafeOtherUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.BuddyVO;
   import com.goodgamestudios.cafe.world.vo.avatar.BasicAvatarVO;
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   import flash.geom.Point;
   
   public class CafeOtherUserData
   {
       
      
      private var otherUser:Array;
      
      public function CafeOtherUserData()
      {
         super();
         this.resetOtherUser();
      }
      
      public function resetOtherUser() : void
      {
         this.otherUser = [];
      }
      
      public function muteUser(param1:OtherplayerMovingVO, param2:Boolean) : void
      {
         if(param1)
         {
            param1.isMute = param2;
         }
      }
      
      public function setAllowBuddyByUserId(param1:int, param2:int) : void
      {
         var _loc3_:OtherplayerMovingVO = this.getUserByUserId(param1);
         if(_loc3_)
         {
            _loc3_.allowFriendRequest = param2 == 1;
         }
      }
      
      public function getUserByUserId(param1:int) : OtherplayerMovingVO
      {
         var _loc3_:OtherplayerMovingVO = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.otherUser.length)
         {
            _loc3_ = this.otherUser[_loc2_] as OtherplayerMovingVO;
            if(_loc3_.userId == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getUserByPlayerId(param1:int) : OtherplayerMovingVO
      {
         var _loc3_:OtherplayerMovingVO = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.otherUser.length)
         {
            _loc3_ = this.otherUser[_loc2_] as OtherplayerMovingVO;
            if(_loc3_.playerId == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function addUser(param1:String, param2:Boolean = false) : OtherplayerMovingVO
      {
         var _loc8_:Array = null;
         var _loc9_:BasicAvatarVO = null;
         if(!param1)
         {
            return null;
         }
         var _loc3_:Array = param1.split("+");
         var _loc4_:OtherplayerMovingVO;
         (_loc4_ = CafeModel.wodData.createVObyWOD(1607) as OtherplayerMovingVO).userId = int(_loc3_.shift());
         _loc4_.playerId = int(_loc3_.shift());
         if(_loc4_.playerId == CafeModel.userData.playerID && _loc4_.userId != CafeModel.userData.userID && _loc4_.playerId != -1)
         {
            return null;
         }
         _loc4_.playerXp = int(_loc3_.shift());
         _loc4_.isoPos = new Point(_loc3_.shift(),_loc3_.shift());
         _loc4_.workTimeLeft = _loc3_.shift();
         _loc4_.isWaiter = _loc4_.workTimeLeft > 0;
         _loc4_.openJobs = _loc3_.shift();
         _loc4_.seekingJob = parseInt(_loc3_.shift()) == 1;
         _loc4_.allowFriendRequest = parseInt(_loc3_.shift()) == 1;
         _loc4_.playerName = String(_loc3_.shift());
         _loc4_.gender = int(_loc3_.shift());
         var _loc5_:Array = _loc3_.shift().split("#");
         var _loc6_:Array = new Array();
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc7_].split("$");
            (_loc9_ = CafeModel.wodData.createVObyWOD(_loc8_.shift()) as BasicAvatarVO).currentColor = _loc8_.shift();
            _loc6_.push(_loc9_);
            _loc7_++;
         }
         _loc4_.avatarParts = _loc6_;
         this.pushUser(_loc4_);
         BasicController.getInstance().dispatchEvent(new CafeOtherUserEvent(CafeOtherUserEvent.OTHER_USER_JOIN,_loc4_,param2));
         return _loc4_;
      }
      
      public function updateUser(param1:String) : void
      {
         var _loc10_:Array = null;
         var _loc11_:BasicAvatarVO = null;
         var _loc2_:Array = param1.split("+");
         var _loc3_:int = int(_loc2_.shift());
         var _loc4_:int = int(_loc2_.shift());
         var _loc5_:int = 0;
         while(_loc5_ < this.otherUser.length)
         {
            if(this.otherUser[_loc5_].isEqual(_loc4_,_loc3_))
            {
               this.otherUser[_loc5_].playerXp = int(_loc2_[0]);
               this.otherUser[_loc5_].openJobs = int(_loc2_[4]);
               BasicController.getInstance().dispatchEvent(new CafeOtherUserEvent(CafeOtherUserEvent.OTHER_USER_UPDATE,this.otherUser[_loc5_] as OtherplayerMovingVO));
               return;
            }
            _loc5_++;
         }
         var _loc6_:OtherplayerMovingVO;
         (_loc6_ = CafeModel.wodData.createVObyWOD(1607) as OtherplayerMovingVO).userId = _loc3_;
         _loc6_.playerId = _loc4_;
         _loc6_.playerXp = int(_loc2_.shift());
         _loc6_.isoPos = new Point(_loc2_.shift(),_loc2_.shift());
         _loc6_.workTimeLeft = _loc2_.shift();
         _loc6_.isWaiter = _loc6_.workTimeLeft > 0;
         _loc6_.openJobs = _loc2_.shift();
         _loc6_.seekingJob = parseInt(_loc2_.shift()) == 1;
         _loc6_.allowFriendRequest = parseInt(_loc2_.shift()) == 1;
         _loc6_.playerName = String(_loc2_.shift());
         _loc6_.gender = int(_loc2_.shift());
         var _loc7_:Array = _loc2_.shift().split("#");
         var _loc8_:Array = new Array();
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_.length)
         {
            _loc10_ = _loc7_[_loc9_].split("$");
            (_loc11_ = CafeModel.wodData.createVObyWOD(_loc10_.shift()) as BasicAvatarVO).currentColor = _loc10_.shift();
            _loc8_.push(_loc11_);
            _loc9_++;
         }
         _loc6_.avatarParts = _loc8_;
         BasicController.getInstance().dispatchEvent(new CafeOtherUserEvent(CafeOtherUserEvent.OTHER_USER_UPDATE,_loc6_));
      }
      
      public function renameUser(param1:int, param2:String) : void
      {
         var _loc4_:OtherplayerMovingVO = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.otherUser.length)
         {
            if((_loc4_ = this.otherUser[_loc3_] as OtherplayerMovingVO).userId == param1)
            {
               _loc4_.playerName = param2;
               return;
            }
            _loc3_++;
         }
      }
      
      private function pushUser(param1:OtherplayerMovingVO) : void
      {
         var _loc3_:OtherplayerMovingVO = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.otherUser.length)
         {
            _loc3_ = this.otherUser[_loc2_] as OtherplayerMovingVO;
            if(_loc3_.isEqual(param1.playerId,param1.userId))
            {
               this.otherUser[_loc2_] = param1;
               return;
            }
            _loc2_++;
         }
         this.otherUser.push(param1);
      }
      
      public function removeUser(param1:int) : void
      {
         var _loc3_:OtherplayerMovingVO = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.otherUser.length)
         {
            _loc3_ = this.otherUser[_loc2_] as OtherplayerMovingVO;
            if(_loc3_.userId == param1)
            {
               this.otherUser.splice(_loc2_,1);
               BasicController.getInstance().dispatchEvent(new CafeOtherUserEvent(CafeOtherUserEvent.OTHER_USER_QUIT,_loc3_));
               return;
            }
            _loc2_++;
         }
      }
      
      public function getPlayerArray() : Array
      {
         var _loc3_:OtherplayerMovingVO = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this.otherUser.length)
         {
            _loc3_ = this.otherUser[_loc2_] as OtherplayerMovingVO;
            if(_loc3_.playerName != CafeModel.userData.userName)
            {
               _loc1_.push(_loc3_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get numberOfWaiter() : int
      {
         var _loc3_:OtherplayerMovingVO = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.otherUser.length)
         {
            _loc3_ = this.otherUser[_loc2_] as OtherplayerMovingVO;
            if(_loc3_.isWaiter)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get numberOfOtherUser() : int
      {
         return this.otherUser.length;
      }
      
      public function buildBuddyVO(param1:String) : BuddyVO
      {
         var _loc2_:BuddyVO = new BuddyVO();
         this.parseBuddyString(param1,_loc2_);
         return _loc2_;
      }
      
      public function parseBuddyString(param1:String, param2:BuddyVO) : void
      {
         var _loc3_:Array = param1.split("+");
         param2.playerId = _loc3_.shift();
         param2.playerXp = _loc3_.shift();
         param2.playerName = _loc3_.shift();
         param2.buddyGender = _loc3_.shift();
         this.parseAvatarParts(_loc3_.shift(),param2);
      }
      
      public function parseAvatarParts(param1:String, param2:BuddyVO) : void
      {
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:BasicAvatarVO = null;
         var _loc3_:Array = param1.split("#");
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc7_ = (_loc6_ = _loc3_[_loc5_].split("$")).shift();
            (_loc8_ = CafeModel.wodData.createVObyWOD(_loc7_) as BasicAvatarVO).currentColor = _loc6_.shift();
            _loc4_.push(_loc8_);
            _loc5_++;
         }
         param2.avatarParts = _loc4_;
      }
      
      public function changeAvatarParts(param1:String, param2:int) : OtherplayerMovingVO
      {
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:BasicAvatarVO = null;
         var _loc3_:OtherplayerMovingVO = this.getUserByPlayerId(param2);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:Array = param1.split("+");
         _loc3_.playerName = _loc4_.shift();
         _loc3_.gender = _loc4_.shift();
         _loc4_ = _loc4_.shift().split("#");
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_ = (_loc7_ = _loc4_[_loc6_].split("$")).shift();
            (_loc9_ = CafeModel.wodData.createVObyWOD(_loc8_) as BasicAvatarVO).currentColor = _loc7_.shift();
            _loc5_.push(_loc9_);
            _loc6_++;
         }
         _loc3_.avatarParts = _loc5_;
         return _loc3_;
      }
   }
}
