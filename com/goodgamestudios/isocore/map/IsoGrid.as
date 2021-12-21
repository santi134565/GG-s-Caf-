package com.goodgamestudios.isocore.map
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class IsoGrid
   {
       
      
      private var _tileSize:Point;
      
      private var _gridSize:Point;
      
      public function IsoGrid(param1:Point, param2:Point)
      {
         super();
         this._tileSize = param1;
         this._gridSize = param2;
      }
      
      public function gridPosToPixelPos(param1:Point) : Point
      {
         return new Point((param1.x - param1.y) * this.tileW,(param1.x + param1.y) * this.tileW / 2);
      }
      
      public function gridPosCenterToPixelPos(param1:Point) : Point
      {
         return new Point((param1.x - param1.y) * this.tileW + this.tileW,(param1.x + param1.y) * this.tileW / 2 + this.tileW / 2);
      }
      
      public function pixelPosToIsoPixelPos(param1:Point, param2:int) : Point
      {
         var _loc3_:Point = new Point(param1.x - param1.y,(param1.x + param1.y) / 2);
         _loc3_.y += param2;
         return _loc3_;
      }
      
      public function pixelPosToGridPos(param1:Point) : Point
      {
         var _loc2_:Number = (2 * param1.y - param1.x) / 2;
         var _loc3_:Number = param1.x + _loc2_;
         _loc2_ = Math.round(_loc2_ / this.tileW);
         _loc3_ = Math.round(_loc3_ / this.tileW) - 1;
         return new Point(_loc3_,_loc2_);
      }
      
      public function get leftBorderInPixel() : int
      {
         var _loc1_:Point = this.gridPosToPixelPos(new Point(0,this._gridSize.y));
         return _loc1_.x + this.tileW;
      }
      
      public function get rightBorderInPixel() : int
      {
         var _loc1_:Point = this.gridPosToPixelPos(new Point(this._gridSize.x,0));
         return _loc1_.x + this.tileW;
      }
      
      public function get bottomBorderInPixel() : int
      {
         var _loc1_:Point = this.gridPosToPixelPos(new Point(this._gridSize.x,this._gridSize.y));
         return _loc1_.y;
      }
      
      public function getDepthByXY(param1:Point) : int
      {
         var _loc2_:int = param1.x + param1.y;
         return _loc2_ * (_loc2_ + 1) / 2 + param1.x;
      }
      
      public function getPosOnBorder(param1:Point) : Point
      {
         var _loc2_:Point = this.pixelPosToGridPos(param1);
         var _loc3_:Point = new Point(0,0);
         if(param1.x - this.tileW < 0)
         {
            _loc3_.y = _loc2_.y;
            if(_loc2_.y > this._gridSize.y - 1)
            {
               _loc3_.y = this._gridSize.y - 1;
            }
            else if(_loc2_.x < 1)
            {
               _loc3_.y = 1 + Math.floor(Math.abs((param1.x - this.tileW) / this.tileW));
            }
            if(_loc3_.y > this._gridSize.y - 1)
            {
               _loc3_.y = this._gridSize.y - 1;
            }
         }
         else
         {
            _loc3_.x = _loc2_.x;
            if(_loc2_.x > this._gridSize.x - 1)
            {
               _loc3_.x = this._gridSize.x - 1;
            }
            else if(_loc2_.y < 1)
            {
               _loc3_.x = 1 + Math.floor((param1.x - this.tileW) / this.tileW);
            }
            if(_loc3_.x > this._gridSize.x - 1)
            {
               _loc3_.x = this._gridSize.x - 1;
            }
         }
         return _loc3_;
      }
      
      public function getNextPosOnMap(param1:Point, param2:Rectangle = null) : Point
      {
         if(!param2)
         {
            param2 = new Rectangle(0,0,1,1);
         }
         var _loc3_:Point = this.pixelPosToGridPos(param1);
         var _loc4_:Point = _loc3_.clone();
         if(_loc3_.x > this._gridSize.x - param2.width + param2.x)
         {
            _loc4_.x = this._gridSize.x - param2.width + param2.x;
         }
         else if(_loc3_.x < 1 + param2.x)
         {
            _loc4_.x = 1 + param2.x;
         }
         if(_loc3_.y > this._gridSize.y - param2.height + param2.y)
         {
            _loc4_.y = this._gridSize.y - param2.height + param2.y;
         }
         else if(_loc3_.y < 1 + param2.y)
         {
            _loc4_.y = 1 + param2.y;
         }
         return _loc4_;
      }
      
      public function get tileH() : int
      {
         return this._tileSize.y;
      }
      
      public function get tileW() : int
      {
         return this._tileSize.x / 2;
      }
      
      public function get tileSize() : Point
      {
         return this._tileSize;
      }
      
      public function set tileSize(param1:Point) : void
      {
         this._tileSize = param1;
      }
      
      public function get gridSize() : Point
      {
         return this._gridSize;
      }
      
      public function set gridSize(param1:Point) : void
      {
         this._gridSize = param1;
      }
   }
}
