package com.goodgamestudios.isocore.vo
{
   import flash.geom.Point;
   
   public class LevelVO
   {
       
      
      public var rating:int;
      
      public var luxury:int;
      
      public var ownerPlayerID:int;
      
      public var ownerUserID:int;
      
      public var ownerName:String;
      
      public var mapSize:Point;
      
      public var background:VisualVO;
      
      public var floorTiles:Array;
      
      public var objects:Array;
      
      public var expansion:VisualVO;
      
      public var expansionId:int;
      
      public var mapSizeX:int;
      
      public var mapSizeY:int;
      
      public var stageLevel:int;
      
      public var worldType:int;
      
      public var door:VisualVO;
      
      public function LevelVO()
      {
         super();
      }
      
      public function removeObject(param1:VisualVO) : void
      {
         var _loc3_:VisualVO = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.objects.length)
         {
            _loc3_ = this.objects[_loc2_] as VisualVO;
            if(_loc3_ == param1)
            {
               this.objects.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
   }
}
