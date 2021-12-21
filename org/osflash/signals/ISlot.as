package org.osflash.signals
{
   public interface ISlot
   {
       
      
      function get listener() : Function;
      
      function set listener(value:Function) : void;
      
      function get params() : Array;
      
      function set params(value:Array) : void;
      
      function get once() : Boolean;
      
      function get priority() : int;
      
      function get enabled() : Boolean;
      
      function set enabled(value:Boolean) : void;
      
      function execute0() : void;
      
      function execute1(value:Object) : void;
      
      function execute(valueObjects:Array) : void;
      
      function remove() : void;
   }
}
