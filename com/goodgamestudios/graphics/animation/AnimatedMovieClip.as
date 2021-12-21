package com.goodgamestudios.graphics.animation
{
   import com.goodgamestudios.graphics.animation.event.FrameEvent;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class AnimatedMovieClip extends AnimatedDisplayObject
   {
       
      
      private var _mc:MovieClip;
      
      private var _mcs:Array;
      
      private var _loopChildren:Boolean;
      
      public function AnimatedMovieClip(param1:int = 1, param2:int = 1, param3:String = "")
      {
         this._mcs = new Array();
         super(param1,param2,param3);
      }
      
      override public function get disp() : Sprite
      {
         return this._mc;
      }
      
      override public function get colorLayer() : Object
      {
         if((this.disp as Object).cc)
         {
            return (this.disp as Object).cc;
         }
         return null;
      }
      
      public function get rotation() : Number
      {
         return this._mc.rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         this._mc.rotation = param1;
      }
      
      public function get alpha() : Number
      {
         return this._mc.alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._mc.alpha = param1;
      }
      
      public function get scaleX() : Number
      {
         return this._mc.scaleX;
      }
      
      public function get scaleY() : Number
      {
         return this._mc.scaleY;
      }
      
      public function set scaleX(param1:Number) : void
      {
         this._mc.scaleX = param1;
      }
      
      public function set scaleY(param1:Number) : void
      {
         this._mc.scaleY = param1;
      }
      
      public function get x() : Number
      {
         return this._mc.x;
      }
      
      public function set x(param1:Number) : void
      {
         this._mc.x = param1;
      }
      
      public function get y() : Number
      {
         return this._mc.y;
      }
      
      public function set y(param1:Number) : void
      {
         this._mc.y = param1;
      }
      
      override public function processAnimation(param1:MovieClip, param2:Matrix = null, param3:Boolean = false) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:AnimatedMovieClip = null;
         var _loc6_:int = 0;
         super.processAnimation(param1,param2);
         _hasAnimChilds = param3;
         this._loopChildren = false;
         this._mc = param1;
         MovieClipHelper.stopAllMovies(this._mc);
         if(param2 != null)
         {
            this._mc.transform.matrix = param2;
         }
         _frameAmount = param1.totalFrames;
         if(param3)
         {
            _loc6_ = 0;
            while(_loc6_ < param1.numChildren)
            {
               if((_loc4_ = param1.getChildAt(_loc6_) as MovieClip) != null)
               {
                  if(_loc4_.totalFrames > _frameAmount)
                  {
                     _frameAmount = _loc4_.totalFrames;
                  }
                  _loc4_.gotoAndStop(1);
                  (_loc5_ = new AnimatedMovieClip(-1)).processAnimation(_loc4_);
                  this._mcs.push(_loc5_);
               }
               _loc6_++;
            }
         }
         this.measureBounds();
         this.draw();
      }
      
      override public function processMultiLoopAnimation(param1:MovieClip, param2:Matrix = null) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:AnimatedMovieClip = null;
         super.processMultiLoopAnimation(param1,param2);
         _id = id;
         this._loopChildren = true;
         this._mc = param1;
         MovieClipHelper.stopAllMovies(this._mc);
         if(param2 != null)
         {
            this._mc.transform.matrix = param2;
         }
         _frameAmount = param1.totalFrames;
         var _loc5_:int = 0;
         while(_loc5_ < param1.numChildren)
         {
            if(param1.getChildAt(_loc5_) is MovieClip)
            {
               _loc3_ = param1.getChildAt(_loc5_) as MovieClip;
               if(_loc3_ != null)
               {
                  (_loc4_ = new AnimatedMovieClip(-1)).processAnimation(_loc3_);
                  _loc4_.setFrameRate(_frameRate);
                  this._mcs.push(_loc4_);
               }
            }
            _loc5_++;
         }
         this.measureBounds();
         this.draw();
      }
      
      public function wrapAnimation(param1:MovieClip, param2:int = 1) : void
      {
         this._mc = param1;
         _frameAmount = param1.totalFrames;
         this.measureBounds();
         _frameNr = param2;
         this.draw();
      }
      
      protected function measureBounds() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Rectangle = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _bounds = this._mc.getBounds(null);
         _loc1_ = 1;
         while(_loc1_ < _frameAmount)
         {
            if(_hasAnimChilds)
            {
               _loc2_ = 0;
               while(_loc2_ < this._mc.numChildren)
               {
                  _loc3_ = this._mc.getChildAt(_loc2_) as MovieClip;
                  if(_loc3_ != null)
                  {
                     _loc3_.nextFrame();
                  }
                  _loc2_++;
               }
            }
            else
            {
               this._mc.nextFrame();
            }
            if((_loc4_ = this._mc.getBounds(null)).left < _bounds.left)
            {
               _bounds.left = _loc4_.left;
            }
            if(_loc4_.top < _bounds.top)
            {
               _bounds.top = _loc4_.top;
            }
            if(_loc4_.right > _bounds.right)
            {
               _bounds.right = _loc4_.right;
            }
            if(_loc4_.bottom > _bounds.bottom)
            {
               _bounds.bottom = _loc4_.bottom;
            }
            _loc1_++;
         }
         _bounds.width = Math.ceil(_bounds.width * this._mc.transform.matrix.a);
         _bounds.height = Math.ceil(_bounds.height * this._mc.transform.matrix.d);
         _bounds.x = Math.ceil(_bounds.left * this._mc.transform.matrix.a);
         _bounds.y = Math.ceil(_bounds.top * this._mc.transform.matrix.d);
         this._mc.gotoAndStop(1);
      }
      
      override protected function dispatchFrameEvent(param1:String) : void
      {
         dispatchEvent(new FrameEvent(param1,this._mc.currentLabel));
      }
      
      override public function stop() : void
      {
         var _loc1_:AnimatedMovieClip = null;
         super.stop();
         MovieClipHelper.stopAllMovies(this._mc as DisplayObjectContainer);
         if(!this._loopChildren)
         {
            return;
         }
         for each(_loc1_ in this._mcs)
         {
            MovieClipHelper.stopAllMovies(_loc1_ as DisplayObjectContainer);
         }
      }
      
      override public function play() : void
      {
         var _loc1_:AnimatedMovieClip = null;
         super.play();
         if(!this._loopChildren)
         {
            return;
         }
         for each(_loc1_ in this._mcs)
         {
            _loc1_.play();
         }
      }
      
      override public function playForward() : void
      {
         var _loc1_:AnimatedMovieClip = null;
         super.playForward();
         if(!this._loopChildren)
         {
            return;
         }
         for each(_loc1_ in this._mcs)
         {
            _loc1_.playForward();
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(_hasAnimChilds)
         {
            _loc1_ = 0;
            while(_loc1_ < this._mc.numChildren)
            {
               _loc2_ = this._mc.getChildAt(_loc1_) as MovieClip;
               if(_loc2_ != null)
               {
                  _loc2_.gotoAndStop(_frameNr);
               }
               _loc1_++;
            }
         }
         else if(this._mc.currentFrame != _frameNr)
         {
            this._mc.gotoAndStop(_frameNr);
         }
      }
   }
}
