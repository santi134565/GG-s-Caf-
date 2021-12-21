package com.goodgamestudios.basic.event
{
   import flash.events.Event;
   
   public class BasicComboboxEvent extends Event
   {
      
      public static const COMBOBOXCHANGE:String = "comboboxchange";
      
      public static const COMBOBOXSELECT:String = "comboboxselect";
       
      
      public var state:int;
      
      public function BasicComboboxEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false)
      {
         this.state = param2;
         super(param1,param3,param4);
      }
   }
}
