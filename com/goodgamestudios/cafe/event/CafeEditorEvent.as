package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeEditorEvent extends Event
   {
      
      public static const BUY_ITEM:String = "buyitem";
      
      public static const SELL_ITEM:String = "sellitem";
      
      public static const STORE_ITEM:String = "storeitem";
       
      
      public function CafeEditorEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
