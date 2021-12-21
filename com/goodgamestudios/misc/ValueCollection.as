package com.goodgamestudios.misc
{
   public class ValueCollection
   {
       
      
      private var currentPointerPosition:uint = 0;
      
      private var _collection:Array;
      
      public function ValueCollection()
      {
         this._collection = new Array();
         super();
      }
      
      public function increasePointer() : void
      {
         if(this.currentPointerPosition < this._collection.length)
         {
            ++this.currentPointerPosition;
         }
      }
      
      public function decreasePointer() : void
      {
         if(this.currentPointerPosition > 0)
         {
            --this.currentPointerPosition;
         }
      }
      
      public function pointerJump(param1:uint) : void
      {
         if(param1 > 0 && param1 < this._collection.length)
         {
            this.currentPointerPosition = param1;
         }
      }
      
      public function add(param1:*) : void
      {
         this._collection.push(param1);
      }
      
      public function get currIntValue() : int
      {
         if(this.currentPointerPosition <= this._collection.length)
         {
            return int(this._collection[this.currentPointerPosition++]);
         }
         return NaN;
      }
      
      public function get currNumberValue() : Number
      {
         if(this.currentPointerPosition <= this._collection.length)
         {
            return this._collection[this.currentPointerPosition++] as Number;
         }
         return NaN;
      }
      
      public function get currStringValue() : String
      {
         if(this.currentPointerPosition <= this._collection.length)
         {
            return this._collection[this.currentPointerPosition++] as String;
         }
         return null;
      }
      
      public function get currUntypedValue() : *
      {
         if(this.currentPointerPosition <= this._collection.length)
         {
            return this._collection[this.currentPointerPosition++];
         }
         return null;
      }
   }
}
