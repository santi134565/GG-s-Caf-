package com.goodgamestudios.basic.event
{
   import flash.events.Event;
   
   public class BasicFirstVisitEvent extends Event
   {
      
      public static const AVATARCREATION_FINISHED:String = "avaFinished";
       
      
      public function BasicFirstVisitEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
