package com.goodgamestudios.cafe.world.vo
{
   public interface IPlayerVO
   {
       
      
      function get playerId() : int;
      
      function set playerId(param1:int) : void;
      
      function get userId() : int;
      
      function set userId(param1:int) : void;
      
      function get playerXp() : int;
      
      function set playerXp(param1:int) : void;
      
      function get playerName() : String;
      
      function set playerName(param1:String) : void;
      
      function get avatarParts() : Array;
      
      function set avatarParts(param1:Array) : void;
      
      function get openJobs() : int;
      
      function set openJobs(param1:int) : void;
      
      function get isWaiter() : Boolean;
      
      function set isWaiter(param1:Boolean) : void;
      
      function get seekingJob() : Boolean;
      
      function set seekingJob(param1:Boolean) : void;
      
      function isEqual(param1:int, param2:int) : Boolean;
   }
}
