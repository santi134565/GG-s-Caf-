package com.goodgamestudios.tracking
{
   import flash.net.URLVariables;
   
   public class ConnectionTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 2;
       
      
      public var connectionTime:String;
      
      public var roundTrip:String;
      
      public var downloadRate:String;
      
      public var bluebox:String;
      
      public function ConnectionTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.var_1 = this.connectionTime;
         _loc1_.var_2 = this.roundTrip;
         _loc1_.var_3 = this.downloadRate;
         _loc1_.var_data = referrer;
         return _loc1_;
      }
   }
}
