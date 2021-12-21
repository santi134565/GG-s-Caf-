package com.goodgamestudios.isocore.events
{
   import flash.events.Event;
   
   public class IsoWorldEvent extends Event
   {
      
      public static const WORLD_CHANGE:String = "worldChange";
      
      public static const OBJECT_STOP_DRAG:int = 0;
      
      public static const NEW_OBJECT:int = 1;
      
      public static const CHANGE_TILE:int = 2;
      
      public static const CHANGE_WALL:int = 3;
      
      public static const NEW_OBJECT_IS_ON_MAP:int = 4;
      
      public static const MOTIONDETECTOR_ALARM:String = "motiondetectoralarm";
      
      public static const SWITCH_WORLD_STATE:String = "switchworldstate";
      
      public static const ISOWORLD_MOUSEDOWN:String = "isoworldmousedown";
      
      public static const ISOWORLD_MOUSEUP:String = "isoworldmouseup";
      
      public static const START_WALK:String = "startWalk";
       
      
      public var params:Array;
      
      public function IsoWorldEvent(param1:String, param2:Array = null, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.params = param2;
      }
   }
}
