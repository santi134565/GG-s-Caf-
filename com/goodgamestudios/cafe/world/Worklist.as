package com.goodgamestudios.cafe.world
{
   public class Worklist
   {
       
      
      public var workList:Array;
      
      private var _working:Boolean = false;
      
      public function Worklist()
      {
         this.workList = [];
         super();
      }
      
      public function get length() : int
      {
         return this.workList.length;
      }
      
      public function set working(param1:Boolean) : void
      {
         this._working = param1;
      }
      
      public function get working() : Boolean
      {
         return this._working;
      }
      
      public function get isWorking() : Boolean
      {
         if(this.workList.length > 0 || this._working)
         {
            return true;
         }
         return false;
      }
      
      public function add(param1:Array) : void
      {
         this.workList.push(param1);
      }
      
      public function append(param1:Array) : void
      {
         this.workList.unshift(param1);
      }
      
      public function getElement() : *
      {
         return this.workList.shift();
      }
   }
}
