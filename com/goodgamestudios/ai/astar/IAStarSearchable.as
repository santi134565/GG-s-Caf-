package com.goodgamestudios.ai.astar
{
   public interface IAStarSearchable
   {
       
      
      function isWalkable(param1:int, param2:int) : Boolean;
      
      function isWalkLeftUp(param1:int, param2:int) : Boolean;
      
      function isWalkRightUp(param1:int, param2:int) : Boolean;
      
      function isWalkLeftDown(param1:int, param2:int) : Boolean;
      
      function isWalkRightDown(param1:int, param2:int) : Boolean;
      
      function getWidth() : int;
      
      function getHeight() : int;
   }
}
