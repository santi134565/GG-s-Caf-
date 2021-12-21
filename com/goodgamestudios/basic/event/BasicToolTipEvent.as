package com.goodgamestudios.basic.event
{
   import flash.events.Event;
   
   public class BasicToolTipEvent extends Event
   {
      
      public static const TOOLTIP_HIDE:String = "tooltiphide";
       
      
      public var params:Array;
      
      public function BasicToolTipEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
