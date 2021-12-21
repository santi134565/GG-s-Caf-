package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeTutorialEvent extends Event
   {
      
      public static const TUTORIAL_STATE_CHANGE:String = "tutorialstatechange";
       
      
      public function CafeTutorialEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
