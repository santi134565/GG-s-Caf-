package com.goodgamestudios.tracking
{
   import flash.net.URLVariables;
   
   public class FirstInstanceTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 4;
       
      
      public var tutorialLength:String;
      
      public var sessionLength:String;
      
      public var registered:String;
      
      public var gameState:String;
      
      public var variant:String;
      
      public function FirstInstanceTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.var_1 = this.tutorialLength;
         _loc1_.var_2 = this.sessionLength;
         _loc1_.var_3 = this.registered;
         _loc1_.var_4 = this.variant;
         _loc1_.var_data = this.gameState + ";" + referrer;
         return _loc1_;
      }
   }
}
