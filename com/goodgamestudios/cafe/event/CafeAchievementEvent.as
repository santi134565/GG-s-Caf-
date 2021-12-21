package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeAchievementEvent extends Event
   {
      
      public static const CHANGE_AMOUNT:String = "changeamount";
       
      
      public var params:Array = null;
      
      public function CafeAchievementEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
