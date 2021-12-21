package com.goodgamestudios.cafe.world.vo.moving
{
   import com.goodgamestudios.cafe.world.vo.IPlayerVO;
   
   public class PlayerMovingVO extends PlateholderMovingVO implements IPlayerVO
   {
       
      
      public var workTimeLeft:Number;
      
      private var _isWaiter:Boolean = false;
      
      private var _openJobs:int;
      
      private var _allowFriendRequest:Boolean = true;
      
      private var _seekingJob:Boolean = false;
      
      private var _playerId:int;
      
      private var _userId:int;
      
      private var _playerName:String;
      
      private var _playerXp:int;
      
      public function PlayerMovingVO()
      {
         super();
      }
      
      public function get seekingJob() : Boolean
      {
         return this._seekingJob;
      }
      
      public function set seekingJob(param1:Boolean) : void
      {
         this._seekingJob = param1;
      }
      
      public function get playerId() : int
      {
         return this._playerId;
      }
      
      public function set playerId(param1:int) : void
      {
         this._playerId = param1;
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function set userId(param1:int) : void
      {
         this._userId = param1;
      }
      
      public function get allowFriendRequest() : Boolean
      {
         return this._allowFriendRequest;
      }
      
      public function set allowFriendRequest(param1:Boolean) : void
      {
         this._allowFriendRequest = param1;
      }
      
      public function get openJobs() : int
      {
         return this._openJobs;
      }
      
      public function set openJobs(param1:int) : void
      {
         this._openJobs = param1;
      }
      
      public function get isWaiter() : Boolean
      {
         return this._isWaiter;
      }
      
      public function set isWaiter(param1:Boolean) : void
      {
         this._isWaiter = param1;
      }
      
      public function isEqual(param1:int, param2:int) : Boolean
      {
         if(param1 >= 0)
         {
            return this.playerId == param1;
         }
         return this.userId == param2;
      }
      
      public function set playerName(param1:String) : void
      {
         this._playerName = param1;
      }
      
      public function get playerName() : String
      {
         return this._playerName;
      }
      
      public function set playerXp(param1:int) : void
      {
         this._playerXp = param1;
      }
      
      public function get playerXp() : int
      {
         return this._playerXp;
      }
   }
}
