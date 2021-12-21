package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeInventoryEvent extends Event
   {
      
      public static const CHANGE_AVAILIBILITY:String = "changeAvailibility";
      
      public static const CHANGE_AMOUNT:String = "changeAmount";
      
      public static const UPDATE_INVENTORY:String = "updateInventory";
      
      public static const CHANGE_FRIDGESIZE:String = "changeFridgesize";
       
      
      public var wodId:int;
      
      public function CafeInventoryEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Boolean = false)
      {
         this.wodId = param2;
         super(param1,param3,param4);
      }
   }
}
