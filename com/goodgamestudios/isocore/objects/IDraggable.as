package com.goodgamestudios.isocore.objects
{
   import flash.geom.Point;
   
   public interface IDraggable
   {
       
      
      function startDrag() : void;
      
      function stopDrag() : void;
      
      function dragMove(param1:Point) : void;
      
      function get isDragable() : Boolean;
      
      function get removeAllowed() : Boolean;
      
      function get wasOnMap() : Boolean;
      
      function get wodId() : int;
   }
}
