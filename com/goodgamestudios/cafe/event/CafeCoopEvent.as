package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeCoopEvent extends Event
   {
      
      public static const CHANGE_ACTIVE_COOPLIST:String = "changeactivecooplist";
      
      public static const CHANGE_ACTIVE_DETAILS:String = "changeactivedetails";
      
      public static const COOP_FINISHED:String = "coopfinished";
       
      
      public var params:Array;
      
      public function CafeCoopEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
