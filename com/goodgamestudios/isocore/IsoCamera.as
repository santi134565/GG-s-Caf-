package com.goodgamestudios.isocore
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class IsoCamera
   {
       
      
      private const TILESIZE:Number = 40;
      
      private const ISOCAMERA_ZOOM_MAX:Number = 3;
      
      private const ISOCAMERA_ZOOM_MIN:Number = 3;
      
      private const ISOCAMERA_SCROLLBORDER_X:Number = 300;
      
      private const ISOCAMERA_SCROLLBORDER_Y_TOP:Number = 300;
      
      private const ISOCAMERA_SCROLLBORDER_Y_BOTTOM:Number = 460;
      
      private var _isocamera_scrollborder_x:Number = 300;
      
      private var _isocamera_scrollborder_y_top:Number = 300;
      
      private var _isocamera_scrollborder_y_bottom:Number = 460;
      
      private var _maxScrollBorderPoint1:Point;
      
      private var _maxScrollBorderPoint2:Point;
      
      private var _viewPort:Rectangle;
      
      private var _unscaledViewPort:Rectangle;
      
      private var _maxX:Number = 1;
      
      private var _maxY:Number = 1;
      
      private var _minX:int = 0;
      
      private var _minY:int = 0;
      
      private var _zoom:Number = 1;
      
      private var _zoomMax:Number;
      
      private var _worldLayer:Sprite;
      
      private var _world:IIsoWorld;
      
      private var _stage_height_mod:int = 0;
      
      public function IsoCamera(param1:Rectangle, param2:Sprite, param3:IIsoWorld)
      {
         this._zoomMax = this._zoom;
         super();
         this._world = param3;
         this._viewPort = param1.clone();
         this._unscaledViewPort = param1.clone();
         this._worldLayer = param2;
      }
      
      public function updateViewPort() : void
      {
         this._viewPort.x = -this._worldLayer.x / this._zoom;
         this._viewPort.y = -this._worldLayer.y / this._zoom;
         this._viewPort.width = this._unscaledViewPort.width / this._zoom;
         this._viewPort.height = this._unscaledViewPort.height / this._zoom;
      }
      
      private function get realStageHeight() : int
      {
         return this._worldLayer.stage.stageHeight + this._stage_height_mod;
      }
      
      public function get dragBounds() : Rectangle
      {
         var _loc1_:int = Math.abs(this._world.map.grid.leftBorderInPixel) + Math.abs(this._world.map.grid.rightBorderInPixel);
         var _loc2_:int = this._worldLayer.stage.stageWidth - (this._world.map.grid.rightBorderInPixel + this._isocamera_scrollborder_x) * this._zoom;
         var _loc3_:int = -_loc2_ + (Math.abs(this._world.map.grid.leftBorderInPixel) + this._isocamera_scrollborder_x) * this._zoom;
         var _loc4_:int;
         var _loc5_:int = -(_loc4_ = this.realStageHeight - (this._world.map.grid.bottomBorderInPixel + this._isocamera_scrollborder_y_bottom) * this._zoom) + this._isocamera_scrollborder_y_top * this._zoom;
         if(this._maxScrollBorderPoint1 && this._maxScrollBorderPoint2)
         {
            _loc2_ = Math.max(_loc2_,this._maxScrollBorderPoint1.x * this._zoom);
            _loc4_ = Math.max(_loc4_,this._maxScrollBorderPoint1.y * this._zoom);
            _loc3_ = Math.min(_loc3_,this._maxScrollBorderPoint2.x * this._zoom);
            _loc5_ = Math.min(_loc5_,this._maxScrollBorderPoint2.y * this._zoom);
         }
         return new Rectangle(_loc2_,_loc4_,_loc3_,_loc5_);
      }
      
      public function set zoom(param1:Number) : void
      {
         if(!this._world.worldLayer.stage)
         {
            return;
         }
         if(isNaN(param1) || param1 > this.ISOCAMERA_ZOOM_MIN)
         {
            return;
         }
         if(param1 <= this._zoomMax)
         {
            this._zoom = this._zoomMax;
         }
         else
         {
            this._zoom = param1;
         }
         this._worldLayer.scaleX = this._zoom;
         this._worldLayer.scaleY = this._zoom;
         this.updateViewPort();
         this.pushToBounds();
      }
      
      private function pushToBounds() : void
      {
         if(!this._world || !this._world.map || !this._world.map.grid)
         {
            return;
         }
         if(this._worldLayer.x > (Math.abs(this._world.map.grid.leftBorderInPixel) + this._isocamera_scrollborder_x) * this.zoom)
         {
            this._worldLayer.x = (Math.abs(this._world.map.grid.leftBorderInPixel) + this._isocamera_scrollborder_x) * this.zoom;
         }
         else if(this._world.worldLayer.stage.stageWidth - this._worldLayer.x * this.zoom > (this._world.map.grid.rightBorderInPixel + this._isocamera_scrollborder_x) * this._zoom)
         {
            this._worldLayer.x = this._world.worldLayer.stage.stageWidth - (this._world.map.grid.rightBorderInPixel + this._isocamera_scrollborder_x) * this._zoom;
         }
         if(this._worldLayer.y > this._isocamera_scrollborder_y_top * this.zoom)
         {
            this._worldLayer.y = this._isocamera_scrollborder_y_top * this.zoom;
         }
         else if(this.realStageHeight - this._worldLayer.y * this.zoom > (this._world.map.grid.bottomBorderInPixel + this._isocamera_scrollborder_y_bottom) * this._zoom)
         {
            this._worldLayer.y = this.realStageHeight - (this._world.map.grid.bottomBorderInPixel + this._isocamera_scrollborder_y_bottom) * this._zoom;
         }
      }
      
      public function calcMaxZoom() : void
      {
         this._zoomMax = this._unscaledViewPort.width / (this._minX + this._maxX);
         if(this._zoomMax > this.ISOCAMERA_ZOOM_MAX)
         {
            this._zoomMax = this.ISOCAMERA_ZOOM_MAX;
         }
      }
      
      public function zoomToMax() : void
      {
         this.calcMaxZoom();
         this.zoom = this._zoomMax - 0.001;
         this.updateViewPort();
      }
      
      public function zoom100pCenter() : void
      {
         this.zoomToMax();
         this._worldLayer.x = this._unscaledViewPort.width / 2 - this.TILESIZE * this.zoom;
         this._worldLayer.y = 0 + this.TILESIZE * 4;
      }
      
      public function resizeViewPort(param1:Number, param2:Number) : void
      {
         this._unscaledViewPort.width = param1;
         this._unscaledViewPort.height = param2;
         this.zoom100pCenter();
      }
      
      public function get zoom() : Number
      {
         return this._zoom;
      }
      
      public function get zoomMax() : Number
      {
         return this._zoomMax;
      }
      
      public function set zoomMax(param1:Number) : void
      {
         this._zoomMax = param1;
      }
      
      public function get viewPort() : Rectangle
      {
         return this._viewPort;
      }
      
      public function get unscaledViewPort() : Rectangle
      {
         return this._unscaledViewPort;
      }
      
      public function set maxX(param1:Number) : void
      {
         this._maxX = param1;
      }
      
      public function set maxY(param1:Number) : void
      {
         this._maxY = param1;
      }
      
      public function get maxX() : Number
      {
         return this._maxX;
      }
      
      public function get maxY() : Number
      {
         return this._maxY;
      }
      
      public function set minX(param1:Number) : void
      {
         this._minX = param1;
      }
      
      public function set minY(param1:Number) : void
      {
         this._minY = param1;
      }
      
      public function get minX() : Number
      {
         return this._minX;
      }
      
      public function get minY() : Number
      {
         return this._minY;
      }
      
      public function set stage_height_mod(param1:int) : void
      {
         this._stage_height_mod = param1;
      }
      
      public function get isocamera_scrollborder_x() : Number
      {
         return this._isocamera_scrollborder_x;
      }
      
      public function set isocamera_scrollborder_x(param1:Number) : void
      {
         this._isocamera_scrollborder_x = param1;
      }
      
      public function get isocamera_scrollborder_y_top() : Number
      {
         return this._isocamera_scrollborder_y_top;
      }
      
      public function set isocamera_scrollborder_y_top(param1:Number) : void
      {
         this._isocamera_scrollborder_y_top = param1;
      }
      
      public function get isocamera_scrollborder_y_bottom() : Number
      {
         return this._isocamera_scrollborder_y_bottom;
      }
      
      public function set isocamera_scrollborder_y_bottom(param1:Number) : void
      {
         this._isocamera_scrollborder_y_bottom = param1;
      }
      
      public function set maxScrollBorderPoint1(param1:Point) : void
      {
         this._maxScrollBorderPoint1 = param1;
      }
      
      public function set maxScrollBorderPoint2(param1:Point) : void
      {
         this._maxScrollBorderPoint2 = param1;
      }
   }
}
