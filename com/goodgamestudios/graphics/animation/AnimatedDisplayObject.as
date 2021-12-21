package com.goodgamestudios.graphics.animation
{
   import com.goodgamestudios.graphics.animation.event.FrameEvent;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class AnimatedDisplayObject extends EventDispatcher
   {
       
      
      public var scaleMatrix:Matrix;
      
      public var frameRanges:Array;
      
      private var _currentFrameRange:int = 0;
      
      protected var _lastFrameStepTime:Number;
      
      protected var _startTime:Number;
      
      protected var _id:int;
      
      protected var _name:String;
      
      protected var _timePerFrame:Number = 50;
      
      protected var _frameRate:int = 15;
      
      protected var _frameAmount:int;
      
      protected var _frameNr:int;
      
      protected var _isPlaying:Boolean;
      
      protected var _bounds:Rectangle;
      
      protected var _hasAnimChilds:Boolean;
      
      protected var _loops:int;
      
      public function AnimatedDisplayObject(param1:int, param2:int, param3:String)
      {
         super();
         this._id = param2;
         this._name = param3;
         this._loops = param1;
         this._frameNr = 1;
      }
      
      public function processAnimation(param1:MovieClip, param2:Matrix = null, param3:Boolean = false) : void
      {
         this.scaleMatrix = param2;
      }
      
      public function processMultiLoopAnimation(param1:MovieClip, param2:Matrix = null) : void
      {
         this.scaleMatrix = param2;
      }
      
      public function setFrameRate(param1:int) : void
      {
         this._frameRate = param1;
         this._timePerFrame = 1000 / param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get lengthInMillis() : int
      {
         return this.frameAmount * this._timePerFrame;
      }
      
      public function get firstFrame() : int
      {
         if(this.frameRanges)
         {
            return this.frameRanges[this._currentFrameRange][0];
         }
         return 1;
      }
      
      public function get frameAmount() : int
      {
         if(this.frameRanges)
         {
            return this.frameRanges[this._currentFrameRange][1] - this.frameRanges[this._currentFrameRange][0] + 1;
         }
         return this._frameAmount;
      }
      
      public function get disp() : Sprite
      {
         return null;
      }
      
      public function get colorLayer() : Object
      {
         return null;
      }
      
      public function get frameRate() : int
      {
         return this._frameRate;
      }
      
      public function get frameNr() : int
      {
         return this._frameNr;
      }
      
      public function get bounds() : Rectangle
      {
         return this._bounds;
      }
      
      public function isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function play() : void
      {
         if(this._isPlaying)
         {
            this.reset();
            this.play();
         }
         else
         {
            this._lastFrameStepTime = getTimer();
            this._frameNr = !!this.frameRanges ? int(this.frameRanges[this._currentFrameRange][0]) : 1;
            this._startTime = this._lastFrameStepTime - (this._frameNr - 1) * this._timePerFrame;
            this._isPlaying = true;
         }
      }
      
      public function stop() : void
      {
         this._isPlaying = false;
      }
      
      public function reset() : void
      {
         this.stop();
         this._frameNr = this.firstFrame;
         this.draw();
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         this._frameNr = param1;
         this.play();
      }
      
      public function gotoAndStop(param1:int) : void
      {
         if(param1 < 1 || param1 > this.frameAmount)
         {
            return;
         }
         this._frameNr = param1;
         this.stop();
         this.draw();
      }
      
      public function gotoAndStopAtFirst() : void
      {
         this._frameNr = this.firstFrame;
         this.stop();
         this.draw();
      }
      
      public function gotoAndStopAtLast() : void
      {
         this._frameNr = this.frameAmount;
         this.stop();
         this.draw();
      }
      
      public function playForward() : void
      {
         if(!this.isPlaying())
         {
            return;
         }
         var _loc1_:Number = getTimer() - this._startTime;
         var _loc2_:int = Math.floor(_loc1_ / this.lengthInMillis);
         var _loc3_:int = Math.max(1,Math.ceil((_loc1_ - this.lengthInMillis * _loc2_) / this._timePerFrame)) + this.firstFrame - 1;
         if(this._frameNr > _loc3_ || _loc2_ >= this._loops && this._loops != -1)
         {
            while(this._frameNr < this.frameAmount)
            {
               ++this._frameNr;
               this.dispatchFrameEvent(FrameEvent.ENTER);
               if(!this.isPlaying())
               {
                  return;
               }
            }
            this._isPlaying = this._loops > _loc2_ || this._loops == -1;
            this.dispatchFrameEvent(FrameEvent.LOOP_END);
            if(!this.isPlaying())
            {
               this.dispatchFrameEvent(FrameEvent.END);
               return;
            }
            this._frameNr = this.firstFrame;
         }
         while(this._frameNr < _loc3_)
         {
            ++this._frameNr;
            this.dispatchFrameEvent(FrameEvent.ENTER);
            if(!this.isPlaying())
            {
               return;
            }
         }
         this.draw();
      }
      
      public function getCurrentFrame() : BitmapData
      {
         return null;
      }
      
      protected function draw() : void
      {
      }
      
      protected function dispatchFrameEvent(param1:String) : void
      {
      }
      
      public function set currentFrameRange(param1:int) : void
      {
         if(this.frameRanges && param1 < this.frameRanges.length)
         {
            this._currentFrameRange = param1;
         }
         else
         {
            this._currentFrameRange = 0;
         }
      }
      
      public function get currentFrameRange() : int
      {
         return this._currentFrameRange;
      }
   }
}
