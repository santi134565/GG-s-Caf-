package com.goodgamestudios.graphics.animation.event
{
   import flash.events.Event;
   
   public class FrameEvent extends Event
   {
      
      public static const ENTER:String = "enter";
      
      public static const LOOP_END:String = "loopEnd";
      
      public static const END:String = "end";
       
      
      public function FrameEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
      }
   }
}
