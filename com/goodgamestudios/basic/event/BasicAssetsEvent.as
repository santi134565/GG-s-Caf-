package com.goodgamestudios.basic.event
{
   import flash.events.Event;
   
   public class BasicAssetsEvent extends Event
   {
      
      public static const ASSETS_COMPLETE:String = "assetsComplete";
       
      
      public function BasicAssetsEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
