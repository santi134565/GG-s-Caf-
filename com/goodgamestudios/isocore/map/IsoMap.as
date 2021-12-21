package com.goodgamestudios.isocore.map
{
   import com.goodgamestudios.isocore.IIsoWorld;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.isocore.objects.IsoMovingObject;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.tiles.IsoTile;
   import com.goodgamestudios.isocore.vo.VOHelper;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.geom.Point;
   
   public class IsoMap
   {
       
      
      protected var _world:IIsoWorld;
      
      protected var _floorTilesVO:Array;
      
      private var _floorTilesVE:Array;
      
      protected var _mapSize:Point;
      
      protected var _grid:IsoGrid;
      
      protected var _collisionMap:CollisionMap;
      
      private var _currentHero:IsoMovingObject;
      
      public var npcArray:Array;
      
      public var otherPlayerArray:Array;
      
      public function IsoMap(param1:IIsoWorld)
      {
         super();
         this._world = param1;
      }
      
      public function get mapSize() : Point
      {
         return this._mapSize;
      }
      
      public function set currentHero(param1:IsoMovingObject) : void
      {
         this._currentHero = param1;
      }
      
      public function get currentHero() : IsoMovingObject
      {
         return this._currentHero;
      }
      
      public function init(param1:Point, param2:Point) : void
      {
         this._mapSize = param1;
         this._grid = new IsoGrid(param2,this._mapSize);
         this._collisionMap = new CollisionMap(this._mapSize);
         this.npcArray = new Array();
         this.otherPlayerArray = new Array();
         this._floorTilesVO = this.world.levelData.floorTiles;
         this.buildMap();
         this.drawMap();
         this.initCamera();
      }
      
      public function initCamera() : void
      {
         var _loc1_:int = 100;
         this.world.camera.minX = Math.abs(this._grid.leftBorderInPixel) + _loc1_;
         this.world.camera.minY = _loc1_;
         this.world.camera.maxX = this._grid.rightBorderInPixel + _loc1_;
         this.world.camera.maxY = this._grid.bottomBorderInPixel + _loc1_;
      }
      
      public function changeFloorTexture(param1:Point, param2:VisualVO) : void
      {
         param2.isoPos = param1;
         this._floorTilesVO[param1.y][param1.x] = param2;
         (this._floorTilesVE[param1.y][param1.x] as IsoTile).tileTextureVO = param2;
      }
      
      public function changeFloorTextureRange(param1:Point, param2:Point, param3:VisualVO) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = param1.x;
         while(_loc4_ <= param2.x)
         {
            _loc5_ = param1.y;
            while(_loc5_ <= param2.y)
            {
               this.changeFloorTexture(new Point(_loc4_,_loc5_),VOHelper.clone(param3) as VisualVO);
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      public function resizeMap() : void
      {
         this.removeMap();
         this._mapSize = this.world.levelData.mapSize;
         this._grid.gridSize = this._mapSize;
         this.buildMap();
         this.drawMap();
         this.updateCollisionMap();
      }
      
      protected function removeMap() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this._floorTilesVE.length)
         {
            _loc2_ = 0;
            while(_loc2_ < this._floorTilesVE[_loc1_].length)
            {
               this.world.removeVisualElement(this._floorTilesVE[_loc1_][_loc2_].tileTexture);
               this._floorTilesVE[_loc1_][_loc2_] = null;
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function buildMap() : void
      {
         var _loc1_:VisualVO = null;
         var _loc3_:int = 0;
         this._floorTilesVE = [];
         var _loc2_:int = 0;
         while(_loc2_ < this._mapSize.y)
         {
            this._floorTilesVE[_loc2_] = [];
            _loc3_ = 0;
            while(_loc3_ < this._mapSize.x)
            {
               _loc1_ = this._floorTilesVO[_loc2_][_loc3_];
               this._floorTilesVE[_loc2_][_loc3_] = new IsoTile(this,_loc1_.isoPos,_loc1_);
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      protected function drawMap() : void
      {
         var _loc2_:int = 0;
         var _loc3_:VisualElement = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._floorTilesVE.length)
         {
            _loc2_ = 0;
            while(_loc2_ < this._floorTilesVE[_loc1_].length)
            {
               _loc3_ = this._floorTilesVE[_loc1_][_loc2_].tileTexture;
               this._world.addVisualElement(_loc3_);
               _loc2_++;
            }
            _loc1_++;
         }
         this._world.floorTileLayer.cacheAsBitmap = true;
      }
      
      public function updateCollisionMap() : void
      {
         var _loc2_:IsoObject = null;
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         this._collisionMap.clearMap(this._mapSize);
         var _loc1_:int = 0;
         while(_loc1_ < this._floorTilesVO.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this._floorTilesVO[_loc1_].length)
            {
               if(!this._floorTilesVO[_loc1_][_loc3_].walkable)
               {
                  _loc4_ = new Point(_loc3_,_loc1_);
                  this._collisionMap.setBlocked(_loc4_);
               }
               _loc3_++;
            }
            _loc1_++;
         }
         for each(_loc2_ in this.world.isoObjects)
         {
            if(!_loc2_.isWalkable)
            {
               this._collisionMap.setBlocked(_loc2_.isoGridPos);
            }
         }
      }
      
      public function getfloorVEbyXY(param1:Point) : VisualElement
      {
         if(MapHelper.isXYonMap(param1,this._mapSize))
         {
            return this._floorTilesVE[param1.y][param1.x].tileTexture;
         }
         return null;
      }
      
      public function getFloorWODid(param1:Point) : int
      {
         if(MapHelper.isXYonMap(param1,this._mapSize))
         {
            return (this._floorTilesVO[param1.y][param1.x] as VisualVO).wodId;
         }
         return -1;
      }
      
      public function getNpcById(param1:int) : IsoMovingObject
      {
         var _loc2_:IsoMovingObject = null;
         for each(_loc2_ in this.npcArray)
         {
            if((_loc2_.getVisualVO() as Object).npcId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function removeNpcById(param1:int) : void
      {
         var _loc3_:IsoMovingObject = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.npcArray)
         {
            if((_loc3_.getVisualVO() as Object).npcId != param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         this.npcArray = _loc2_;
      }
      
      public function removeNpcByVE(param1:IsoMovingObject) : void
      {
         var _loc3_:IsoMovingObject = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.npcArray)
         {
            if(_loc3_ != param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         this.npcArray = _loc2_;
      }
      
      public function getOtherPlayerByIds(param1:int, param2:int) : IsoMovingObject
      {
         var _loc3_:IsoMovingObject = null;
         for each(_loc3_ in this.otherPlayerArray)
         {
            if((_loc3_.getVisualVO() as Object).userId == param1 && (_loc3_.getVisualVO() as Object).playerId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getOtherPlayerByUserId(param1:int) : IsoMovingObject
      {
         var _loc2_:IsoMovingObject = null;
         for each(_loc2_ in this.otherPlayerArray)
         {
            if((_loc2_.getVisualVO() as Object).userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getOtherPlayerByPlayerId(param1:int) : IsoMovingObject
      {
         var _loc2_:IsoMovingObject = null;
         for each(_loc2_ in this.otherPlayerArray)
         {
            if((_loc2_.getVisualVO() as Object).playerId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function removeOtherPlayerById(param1:int) : void
      {
         var _loc3_:IsoMovingObject = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.otherPlayerArray)
         {
            if((_loc3_.getVisualVO() as Object).userId != param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         this.otherPlayerArray = _loc2_;
      }
      
      public function isOnMap(param1:Point) : Boolean
      {
         if(MapHelper.isXYonMap(param1,this._mapSize))
         {
            return true;
         }
         return false;
      }
      
      public function isOnPlayMap(param1:Point) : Boolean
      {
         return false;
      }
      
      public function get floorTilesVO() : Array
      {
         return this._floorTilesVO;
      }
      
      public function get grid() : IsoGrid
      {
         return this._grid;
      }
      
      public function get world() : IIsoWorld
      {
         return this._world;
      }
      
      public function get collisionMap() : CollisionMap
      {
         return this._collisionMap;
      }
   }
}
