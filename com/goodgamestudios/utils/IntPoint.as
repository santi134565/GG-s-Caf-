package com.goodgamestudios.utils
{
   public class IntPoint
   {
       
      
      public var x:int;
      
      public var y:int;
      
      public function IntPoint(param1:int = 0, param2:int = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function add(param1:IntPoint) : void
      {
         this.x += param1.x;
         this.y += param1.y;
      }
      
      public function addNew(param1:IntPoint) : IntPoint
      {
         return new IntPoint(this.x + param1.x,this.y + param1.y);
      }
      
      public function equals(param1:IntPoint) : Boolean
      {
         return this.x == param1.x && this.y == param1.y;
      }
      
      public function toString() : String
      {
         return "IntPoint(" + this.x + ", " + this.y + ")";
      }
   }
}
