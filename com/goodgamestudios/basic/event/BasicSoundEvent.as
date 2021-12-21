package com.goodgamestudios.basic.event
{
   import flash.events.Event;
   
   public class BasicSoundEvent extends Event
   {
      
      public static const SONG_PLAYED_COMPLETE:String = "songplayedcomplete";
      
      public static const SONG_BUFFERED_COMPLETE:String = "songbufferedcomplete";
      
      public static const SONG_BUFFERED_ENOUGH:String = "songbufferedenough";
       
      
      public function BasicSoundEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
