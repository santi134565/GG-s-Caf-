package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeBuddyEvent extends Event
   {
      
      public static const CHANGE_BUDDYDATA:String = "changebuddydata";
       
      
      public var params:Array;
      
      public function CafeBuddyEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
