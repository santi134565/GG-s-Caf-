package com.goodgamestudios.isocore.objects
{
   import flash.geom.Point;
   
   public class IsoStaticObject extends IsoObject
   {
       
      
      protected var _walkableTileOverride:Boolean = true;
      
      private var _oldIsoPos:Point;
      
      public function IsoStaticObject()
      {
         super();
      }
      
      override public function update(param1:Number) : void
      {
      }
      
      public function get isoRotation() : int
      {
         return vo.rotationDir;
      }
      
      public function set isoRotation(param1:int) : void
      {
         if(param1 > 3)
         {
            vo.rotationDir = 0;
         }
         else if(param1 < 0)
         {
            vo.rotationDir = 3;
         }
         else
         {
            vo.rotationDir = param1;
         }
      }
      
      public function startDrag() : void
      {
      }
      
      public function stopDrag() : void
      {
      }
      
      public function get oldIsoPos() : Point
      {
         return this._oldIsoPos;
      }
      
      public function set oldIsoPos(param1:Point) : void
      {
         this._oldIsoPos = param1;
      }
   }
}
