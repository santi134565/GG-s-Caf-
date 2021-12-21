package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeHighscoreEvent extends Event
   {
      
      public static const GET_HIGHSCORE_DATA:String = "gethighscoredata";
       
      
      public var params:Array;
      
      public function CafeHighscoreEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
