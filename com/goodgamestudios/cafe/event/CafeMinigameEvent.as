package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeMinigameEvent extends Event
   {
      
      public static const MUFFIN_PICK_MUFFIN:String = "muffinpickmuffin";
      
      public static const MUFFIN_GAMERESULTS:String = "muffingameresults";
      
      public static const MUFFIN_GUEST_PLAYED:String = "muffinguestplayed";
      
      public static const WHEELOFFORTUNE:String = "wheeloffortune";
       
      
      public var params:Array;
      
      public function CafeMinigameEvent(param1:String, param2:Array = null, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.params = param2;
      }
   }
}
