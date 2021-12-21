package org.osflash.signals
{
   public class Slot implements ISlot
   {
       
      
      protected var _signal:IOnceSignal;
      
      protected var _enabled:Boolean = true;
      
      protected var _listener:Function;
      
      protected var _once:Boolean = false;
      
      protected var _priority:int = 0;
      
      protected var _params:Array;
      
      public function Slot(listener:Function, signal:IOnceSignal, once:Boolean = false, priority:int = 0)
      {
         super();
         this._listener = listener;
         this._once = once;
         this._signal = signal;
         this._priority = priority;
         this.verifyListener(listener);
      }
      
      public function execute0() : void
      {
         if(!this._enabled)
         {
            return;
         }
         if(this._once)
         {
            this.remove();
         }
         if(this._params && this._params.length)
         {
            this._listener.apply(null,this._params);
            return;
         }
         this._listener();
      }
      
      public function execute1(value:Object) : void
      {
         if(!this._enabled)
         {
            return;
         }
         if(this._once)
         {
            this.remove();
         }
         if(this._params && this._params.length)
         {
            this._listener.apply(null,[value].concat(this._params));
            return;
         }
         this._listener(value);
      }
      
      public function execute(valueObjects:Array) : void
      {
         if(!this._enabled)
         {
            return;
         }
         if(this._once)
         {
            this.remove();
         }
         if(this._params && this._params.length)
         {
            valueObjects = valueObjects.concat(this._params);
         }
         var _loc2_:int = valueObjects.length;
         if(_loc2_ == 0)
         {
            this._listener();
         }
         else if(_loc2_ == 1)
         {
            this._listener(valueObjects[0]);
         }
         else if(_loc2_ == 2)
         {
            this._listener(valueObjects[0],valueObjects[1]);
         }
         else if(_loc2_ == 3)
         {
            this._listener(valueObjects[0],valueObjects[1],valueObjects[2]);
         }
         else
         {
            this._listener.apply(null,valueObjects);
         }
      }
      
      public function get listener() : Function
      {
         return this._listener;
      }
      
      public function set listener(value:Function) : void
      {
         if(null == value)
         {
            throw new ArgumentError("Given listener is null.\nDid you want to set enabled to false instead?");
         }
         this.verifyListener(value);
         this._listener = value;
      }
      
      public function get once() : Boolean
      {
         return this._once;
      }
      
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function toString() : String
      {
         return "[Slot listener: " + this._listener + ", once: " + this._once + ", priority: " + this._priority + ", enabled: " + this._enabled + "]";
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(value:Boolean) : void
      {
         this._enabled = value;
      }
      
      public function get params() : Array
      {
         return this._params;
      }
      
      public function set params(value:Array) : void
      {
         this._params = value;
      }
      
      public function remove() : void
      {
         this._signal.remove(this._listener);
      }
      
      protected function verifyListener(listener:Function) : void
      {
         if(null == listener)
         {
            throw new ArgumentError("Given listener is null.");
         }
         if(null == this._signal)
         {
            throw new Error("Internal signal reference has not been set yet.");
         }
      }
   }
}
