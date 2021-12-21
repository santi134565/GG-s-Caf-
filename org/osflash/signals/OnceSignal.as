package org.osflash.signals
{
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   
   public class OnceSignal implements IOnceSignal
   {
       
      
      protected var _valueClasses:Array;
      
      protected var slots:SlotList;
      
      public function OnceSignal(... rest)
      {
         this.slots = SlotList.NIL;
         super();
         this.valueClasses = rest.length == 1 && rest[0] is Array ? rest[0] : rest;
      }
      
      public function get valueClasses() : Array
      {
         return this._valueClasses;
      }
      
      public function set valueClasses(value:Array) : void
      {
         this._valueClasses = !!value ? value.slice() : [];
         var _loc2_:int = this._valueClasses.length;
         while(_loc2_--)
         {
            if(!(this._valueClasses[_loc2_] is Class))
            {
               throw new ArgumentError("Invalid valueClasses argument: " + "item at index " + _loc2_ + " should be a Class but was:<" + this._valueClasses[_loc2_] + ">." + getQualifiedClassName(this._valueClasses[_loc2_]));
            }
         }
      }
      
      public function get numListeners() : uint
      {
         return this.slots.length;
      }
      
      public function addOnce(listener:Function) : ISlot
      {
         return this.registerListener(listener,true);
      }
      
      public function remove(listener:Function) : ISlot
      {
         var _loc2_:ISlot = this.slots.find(listener);
         if(!_loc2_)
         {
            return null;
         }
         this.slots = this.slots.filterNot(listener);
         return _loc2_;
      }
      
      public function removeAll() : void
      {
         this.slots = SlotList.NIL;
      }
      
      public function dispatch(... rest) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Class = null;
         var _loc4_:int = this._valueClasses.length;
         var _loc5_:int;
         if((_loc5_ = rest.length) < _loc4_)
         {
            throw new ArgumentError("Incorrect number of arguments. " + "Expected at least " + _loc4_ + " but received " + _loc5_ + ".");
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            if(!(rest[_loc6_] is this._valueClasses[_loc6_] || rest[_loc6_] === null))
            {
               throw new ArgumentError("Value object <" + rest[_loc6_] + "> is not an instance of <" + this._valueClasses[_loc6_] + ">.");
            }
            _loc6_++;
         }
         var _loc7_:SlotList;
         if((_loc7_ = this.slots).nonEmpty)
         {
            while(_loc7_.nonEmpty)
            {
               _loc7_.head.execute(rest);
               _loc7_ = _loc7_.tail;
            }
         }
      }
      
      protected function registerListener(listener:Function, once:Boolean = false) : ISlot
      {
         var _loc3_:ISlot = null;
         if(this.registrationPossible(listener,once))
         {
            _loc3_ = new Slot(listener,this,once);
            this.slots = this.slots.prepend(_loc3_);
            return _loc3_;
         }
         return this.slots.find(listener);
      }
      
      protected function registrationPossible(listener:Function, once:Boolean) : Boolean
      {
         if(!this.slots.nonEmpty)
         {
            return true;
         }
         var _loc3_:ISlot = this.slots.find(listener);
         if(!_loc3_)
         {
            return true;
         }
         if(_loc3_.once != once)
         {
            throw new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first.");
         }
         return false;
      }
   }
}
