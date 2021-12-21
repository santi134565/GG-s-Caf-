package org.osflash.signals
{
   public interface IOnceSignal
   {
       
      
      function get valueClasses() : Array;
      
      function set valueClasses(value:Array) : void;
      
      function get numListeners() : uint;
      
      function addOnce(listener:Function) : ISlot;
      
      function dispatch(... rest) : void;
      
      function remove(listener:Function) : ISlot;
      
      function removeAll() : void;
   }
}
