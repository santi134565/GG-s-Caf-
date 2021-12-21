package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeChatEvent extends Event
   {
      
      public static const ADD_MSG:String = "addmsg";
       
      
      public var userId:int;
      
      public var msg:String;
      
      public function CafeChatEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         this.userId = param2;
         this.msg = param3;
         super(param1,param4,param5);
      }
   }
}
