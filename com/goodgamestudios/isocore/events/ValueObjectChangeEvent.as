package com.goodgamestudios.isocore.events
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class ValueObjectChangeEvent extends Event
   {
      
      public static const CHANGE:String = "ValueObjectChange";
       
      
      public var changedProperties:Array;
      
      public var oldValues:Dictionary;
      
      public function ValueObjectChangeEvent(param1:Array, param2:Boolean = false, param3:Boolean = false)
      {
         this.oldValues = new Dictionary();
         super(CHANGE,param2,param3);
         this.changedProperties = param1;
      }
   }
}
