package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeGiftEvent extends Event
   {
      
      public static const CHANGE_MYGIFTS:String = "changeMyGifts";
      
      public static const CHANGE_SENDABLEGIFTS:String = "changeSendableGifts";
      
      public static const CHANGE_ALLREADYSENDPLAYERLIST:String = "changeAllreadySendPlayerlist";
       
      
      public function CafeGiftEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
