package com.goodgamestudios.basic.event
{
   import flash.events.Event;
   
   public class BasicUserEvent extends Event
   {
      
      public static const LOGGEDIN_TIME_INTERVAL:String = "loggedintimeinterval";
      
      public static const REGISTERED:String = "registered";
       
      
      public var params:Array;
      
      public function BasicUserEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
