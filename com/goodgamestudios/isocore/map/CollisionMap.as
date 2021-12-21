package com.goodgamestudios.isocore.map
{
   import com.goodgamestudios.ai.astar.IAStarSearchable;
   import com.goodgamestudios.math.Random;
   import flash.geom.Point;
   
   public class CollisionMap implements IAStarSearchable
   {
       
      
      protected var _collisionMapSize:Point;
      
      protected var _collisionMap:Array;
      
      protected var _collisionMapWallobjects:Array;
      
      private var _wallShift:int = 1;
      
      protected var _tempWalkable:Point;
      
      private var _additionalBlockedPoints:Array;
      
      public function CollisionMap(param1:Point)
      {
         this._additionalBlockedPoints = [];
         super();
         this.clearMap(param1);
      }
      
      public function addAdditionalBlockedPoint(param1:Point) : void
      {
         this._additionalBlockedPoints.push(param1);
         this.setBlocked(param1);
      }
      
      public function clearAdditionalBlockedPoints() : void
      {
         var _loc1_:Point = null;
         for each(_loc1_ in this._additionalBlockedPoints)
         {
            this.setWalkable(_loc1_);
         }
         this._additionalBlockedPoints = [];
      }
      
      public function isWalkableByPoint(param1:Point) : Boolean
      {
         if(param1.x > -1 && param1.y > -1 && param1.x < this._collisionMapSize.x && param1.y < this._collisionMapSize.y)
         {
            return this._collisionMap[param1.y][param1.x];
         }
         return false;
      }
      
      public function isWalkable(param1:int, param2:int) : Boolean
      {
         if(param1 > -1 && param2 > -1 && param1 < this._collisionMapSize.x && param2 < this._collisionMapSize.y)
         {
            return this._collisionMap[param2][param1];
         }
         return false;
      }
      
      public function getWidth() : int
      {
         return int(this._collisionMapSize.x);
      }
      
      public function getHeight() : int
      {
         return int(this._collisionMapSize.y);
      }
      
      public function clearMap(param1:Point) : void
      {
         var _loc3_:int = 0;
         this._collisionMapSize = param1;
         this._collisionMap = [];
         this._collisionMapWallobjects = [];
         var _loc2_:int = 0;
         while(_loc2_ < this._collisionMapSize.y)
         {
            this._collisionMap[_loc2_] = [];
            this._collisionMapWallobjects[_loc2_] = [];
            _loc3_ = 0;
            while(_loc3_ < this._collisionMapSize.x)
            {
               this._collisionMap[_loc2_][_loc3_] = true;
               this._collisionMapWallobjects[_loc2_][_loc3_] = true;
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function setBlocked(param1:Point) : void
      {
         if(MapHelper.isXYonMap(param1,this._collisionMapSize))
         {
            this._collisionMap[param1.y][param1.x] = false;
         }
      }
      
      public function setWalkable(param1:Point) : void
      {
         if(MapHelper.isXYonMap(param1,this._collisionMapSize))
         {
            this._collisionMap[param1.y][param1.x] = true;
         }
      }
      
      public function isWalkLeftUp(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function isWalkRightUp(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function isWalkLeftDown(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function isWalkRightDown(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function setBlockedWallObj(param1:Point, param2:int = 0) : void
      {
         if(MapHelper.isXYonMap(param1,this._collisionMapSize))
         {
            this._collisionMapWallobjects[param1.y][param1.x] = false;
         }
      }
      
      public function setFreeWallObj(param1:Point, param2:int = 0) : void
      {
         if(MapHelper.isXYonMap(param1,this._collisionMapSize))
         {
            this._collisionMapWallobjects[param1.y][param1.x] = true;
         }
      }
      
      public function isWallIsFree(param1:Point, param2:int = 0) : Boolean
      {
         if(param1.x > -1 && param1.x < this._collisionMapSize.x && param1.y > -1 && param1.y < this._collisionMapSize.y)
         {
            return this._collisionMapWallobjects[param1.y][param1.x];
         }
         return false;
      }
      
      public function traceMap() : void
      {
         var _loc3_:int = 0;
         trace("---------");
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < this._collisionMapSize.y)
         {
            _loc1_[_loc2_] = [];
            _loc3_ = 0;
            while(_loc3_ < this._collisionMapSize.x)
            {
               if(!this._collisionMapWallobjects[_loc2_][_loc3_])
               {
                  _loc1_[_loc2_][_loc3_] = "X";
               }
               else
               {
                  _loc1_[_loc2_][_loc3_] = "_";
               }
               _loc3_++;
            }
            trace(_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      public function setTempWalkable(param1:Point) : void
      {
         this._tempWalkable = new Point(param1.x,param1.y);
         this.setWalkable(this._tempWalkable);
      }
      
      public function removeTempWalkable() : void
      {
         this.setBlocked(this._tempWalkable);
      }
      
      public function getRandomFreeTile() : Point
      {
         var _loc1_:Point = null;
         var _loc2_:int = 100;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.getRandomTile();
            if(this.isWalkableByPoint(_loc1_))
            {
               return _loc1_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getRandomTile() : Point
      {
         return new Point(Random.integer(this._wallShift,this._collisionMapSize.x),Random.integer(this._wallShift,this._collisionMapSize.y));
      }
   }
}
