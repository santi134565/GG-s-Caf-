package com.goodgamestudios.cafe.world.vo.moving
{
   public class VestedMovingVO extends BasicMovingVO
   {
       
      
      private var _avatarParts:Array;
      
      public function VestedMovingVO()
      {
         super();
      }
      
      public function get avatarParts() : Array
      {
         return this._avatarParts;
      }
      
      public function set avatarParts(param1:Array) : void
      {
         this._avatarParts = param1;
      }
   }
}
