package com.goodgamestudios.isocore.map
{
   import com.goodgamestudios.isocore.objects.IsoStaticObject;
   import flash.geom.Point;
   
   public class MotionDetectorController
   {
      
      private static var motionDecArray:Array;
       
      
      public function MotionDetectorController()
      {
         super();
      }
      
      public static function addMotionDetector(param1:IsoStaticObject, param2:Point, param3:Point) : void
      {
         if(!motionDecArray)
         {
            motionDecArray = new Array();
         }
         var _loc4_:MotionDetector = new MotionDetector(param1,param2,param3);
         motionDecArray.push(_loc4_);
      }
      
      public static function removeMotionDetector(param1:IsoStaticObject) : void
      {
         var _loc3_:MotionDetector = null;
         var _loc2_:int = 0;
         while(_loc2_ < motionDecArray.length)
         {
            _loc3_ = motionDecArray[_loc2_] as MotionDetector;
            if(_loc3_.target == param1)
            {
               motionDecArray.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      public static function changeMotionDetectorPosition(param1:IsoStaticObject, param2:Point, param3:Point) : void
      {
         var _loc4_:MotionDetector = null;
         if(!motionDecArray)
         {
            return;
         }
         for each(_loc4_ in motionDecArray)
         {
            if(_loc4_.target == param1)
            {
               _loc4_.tile1 = param2;
               _loc4_.tile2 = param3;
               return;
            }
         }
      }
      
      public static function checkAlarm(param1:Point, param2:Point) : void
      {
         var _loc3_:MotionDetector = null;
         if(!motionDecArray)
         {
            return;
         }
         for each(_loc3_ in motionDecArray)
         {
            _loc3_.checkAlarm(param1,param2);
         }
      }
   }
}
