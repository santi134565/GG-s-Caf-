package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafePanelEvent extends Event
   {
      
      public static const MOUSE_ON_PANEL:String = "mouseonpanel";
      
      public static const TEASER_ON_LOGINPANEL:String = "loginteaser";
       
      
      public var params:Array = null;
      
      public function CafePanelEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
