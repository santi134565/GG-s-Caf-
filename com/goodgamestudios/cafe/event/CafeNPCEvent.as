package com.goodgamestudios.cafe.event
{
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import flash.events.Event;
   
   public class CafeNPCEvent extends Event
   {
      
      public static const CHANGED_NAME:String = "changedName";
      
      public static const WAITER_ADDED:String = "addedWatier";
      
      public static const WAITER_REMOVED:String = "removedWatier";
      
      public static const WAITER_TRAINED:String = "waiterTraining";
      
      public static const GUEST_ADDED:String = "addedGuest";
      
      public static const GUEST_REMOVED:String = "removedGuest";
       
      
      public var npcVO:NpcMovingVO;
      
      public function CafeNPCEvent(param1:String, param2:NpcMovingVO, param3:Boolean = false, param4:Boolean = false)
      {
         this.npcVO = param2;
         super(param1,param3,param4);
      }
   }
}
