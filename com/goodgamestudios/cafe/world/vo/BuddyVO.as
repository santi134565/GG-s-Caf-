package com.goodgamestudios.cafe.world.vo
{
   public class BuddyVO implements IPlayerVO
   {
       
      
      public var thumbUrl:String = "";
      
      public var buddyGender:int;
      
      public var isSocialFriend:Boolean;
      
      private var _pln:String;
      
      private var _playerId:int;
      
      private var _openJobs:int = 0;
      
      private var _playerName:String;
      
      private var _playerXp:int;
      
      private var _avatarParts:Array;
      
      public function BuddyVO()
      {
         super();
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
         return -1;
      }
      
      public function set userId(param1:int) : void
      {
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
      
      public function set avatarParts(param1:Array) : void
      {
         this._avatarParts = param1;
      }
      
      public function get avatarParts() : Array
      {
         return this._avatarParts;
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
         return false;
      }
      
      public function set isWaiter(param1:Boolean) : void
      {
      }
      
      public function get seekingJob() : Boolean
      {
         return false;
      }
      
      public function set seekingJob(param1:Boolean) : void
      {
      }
      
      public function isEqual(param1:int, param2:int) : Boolean
      {
         if(param1 >= 0)
         {
            return this.playerId == param1;
         }
         return this.userId == param2;
      }
      
      public function get pln() : String
      {
         return this._pln;
      }
      
      public function set pln(param1:String) : void
      {
         this._pln = param1;
      }
   }
}
