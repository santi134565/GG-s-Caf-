package com.goodgamestudios.cafe.event
{
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   import flash.events.Event;
   
   public class CafeOtherUserEvent extends Event
   {
      
      public static const OTHER_USER_JOIN:String = "otheruserJoin";
      
      public static const OTHER_USER_QUIT:String = "otheruserQuit";
      
      public static const OTHER_USER_UPDATE:String = "otheruserUpdate";
       
      
      public var user:OtherplayerMovingVO;
      
      public var userJoined:Boolean;
      
      public function CafeOtherUserEvent(param1:String, param2:OtherplayerMovingVO = null, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         this.user = param2;
         this.userJoined = param3;
         super(param1,param4,param5);
      }
   }
}
