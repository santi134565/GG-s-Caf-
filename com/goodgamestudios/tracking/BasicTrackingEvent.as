package com.goodgamestudios.tracking
{
   import flash.net.URLVariables;
   
   public class BasicTrackingEvent
   {
       
      
      protected var referrer:String;
      
      public function BasicTrackingEvent(param1:String)
      {
         super();
         this.referrer = param1;
      }
      
      public function getVars() : URLVariables
      {
         return null;
      }
   }
}
