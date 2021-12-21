package com.goodgamestudios.isocore.map
{
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.objects.IsoStaticObject;
   import flash.geom.Point;
   
   public class MotionDetector
   {
       
      
      public var target:IsoStaticObject;
      
      public var tile1:Point;
      
      public var tile2:Point;
      
      public function MotionDetector(param1:IsoStaticObject, param2:Point, param3:Point)
      {
         super();
         this.target = param1;
         this.tile1 = param2;
         this.tile2 = param3;
      }
      
      public function checkAlarm(param1:Point, param2:Point) : void
      {
         if(param1.x == this.tile1.x && param1.y == this.tile1.y && (param2.x == this.tile2.x && param2.y == this.tile2.y) || param1.x == this.tile2.x && param1.y == this.tile2.y && (param2.x == this.tile1.x && param2.y == this.tile1.y))
         {
            this.target.disp.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.MOTIONDETECTOR_ALARM));
         }
      }
   }
}
