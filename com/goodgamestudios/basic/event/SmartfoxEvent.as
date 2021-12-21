package com.goodgamestudios.basic.event
{
   import flash.events.Event;
   
   public class SmartfoxEvent extends Event
   {
      
      public static const CONNECT_START:String = "connectStart";
      
      public static const CONNECT_FAILED:String = "connectFailed";
      
      public static const CONNECT_TIMEOUT:String = "connectTimeout";
      
      public static const CONNECT_SUCCESS:String = "connectSuccess";
      
      public static const CONNECTION_LOST:String = "connectionLost";
      
      public static const JOINED_ROOM:String = "joinedRoom";
      
      public static const GUEST_LOGIN_FAILED:String = "guestLoginFailed";
      
      public static const GUEST_LOGIN_SUCCESS:String = "guestLoginSuccess";
      
      public static const EXTENSION_RESPONSE:String = "extensionResponse";
       
      
      public var cmdId:String;
      
      public var params:Array;
      
      public function SmartfoxEvent(param1:String, param2:String = "", param3:Array = null, param4:Boolean = false, param5:Boolean = false)
      {
         this.cmdId = param2;
         this.params = param3;
         super(param1,param4,param5);
      }
   }
}
