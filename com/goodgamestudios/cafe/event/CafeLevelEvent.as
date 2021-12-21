package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeLevelEvent extends Event
   {
      
      public static const INIT_LEVELDATA:String = "initLeveldata";
      
      public static const RATING_CHANGE:String = "ratingchange";
      
      public static const LUXUS_CHANGE:String = "luxuschange";
      
      public static const SIZE_CHANGE:String = "sizeChange";
       
      
      public var params:Array;
      
      public function CafeLevelEvent(param1:String, param2:Array = null, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.params = param2;
      }
   }
}
