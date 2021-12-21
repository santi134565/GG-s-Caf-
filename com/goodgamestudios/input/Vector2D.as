package com.goodgamestudios.input
{
   import flash.geom.Point;
   
   public class Vector2D
   {
      
      private static const RAD_TO_DEG:Number = 180 / Math.PI;
      
      private static const DEG_TO_RAD:Number = Math.PI / 180;
       
      
      public var x:Number;
      
      public var y:Number;
      
      private var _length:Number;
      
      private var v1:Vector2D;
      
      private var v2:Vector2D;
      
      private var _oldX:Number;
      
      private var _oldY:Number;
      
      public function Vector2D(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this._length = 0;
      }
      
      public static function is2ndInFOVof1st(param1:Vector2D, param2:Vector2D, param3:Number, param4:Vector2D) : Boolean
      {
         var _loc5_:Vector2D;
         (_loc5_ = param4.copy()).subtract(param1);
         _loc5_.normalize();
         return param2.dotOf(_loc5_) >= Math.cos(param3 / 2);
      }
      
      public static function pointToVector(param1:Point) : Vector2D
      {
         return new Vector2D(param1.x,param1.y);
      }
      
      public static function rotToHeading(param1:Number) : Vector2D
      {
         var _loc2_:Number = Math.cos(param1);
         var _loc3_:Number = Math.sin(param1);
         return new Vector2D(_loc2_,_loc3_);
      }
      
      public function get length() : Number
      {
         if(this._oldX != this.x || this._oldY != this.y)
         {
            this._oldX = this.x;
            this._oldY = this.y;
            this._length = Math.sqrt(this.x * this.x + this.y * this.y);
         }
         return this._length;
      }
      
      public function get lengthSq() : Number
      {
         return this.x * this.x + this.y * this.y;
      }
      
      public function isZero() : Boolean
      {
         return this.x == 0 || this.y == 0;
      }
      
      public function toString() : String
      {
         return "( " + this.x + ", " + this.y + " )";
      }
      
      public function toPoint() : Point
      {
         return new Point(this.x,this.y);
      }
      
      public function toRotation() : Number
      {
         var _loc1_:Number = Math.atan(this.y / this.x);
         if(this.y < 0 && this.x > 0)
         {
            return _loc1_;
         }
         if(this.y < 0 && this.x < 0 || this.y > 0 && this.x < 0)
         {
            return _loc1_ + 3.141592653589793;
         }
         return _loc1_ + 6.283185307179586;
      }
      
      public function Set(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function copy() : Vector2D
      {
         var _loc1_:Vector2D = new Vector2D(this.x,this.y);
         _loc1_._length = this._length;
         _loc1_._oldX = this.x;
         _loc1_._oldY = this.y;
         return _loc1_;
      }
      
      public function normalize() : void
      {
         if(this.length != 0)
         {
            this.x /= this._length;
            this.y /= this._length;
         }
      }
      
      public function reflect(param1:Vector2D) : void
      {
         this.v1 = param1.getReverse();
         this.v1.multiply(2 * this.dotOf(param1));
         this.addTo(this.v1);
      }
      
      public function addTo(param1:Vector2D) : void
      {
         this.x += param1.x;
         this.y += param1.y;
      }
      
      public function subtract(param1:Vector2D) : void
      {
         this.x -= param1.x;
         this.y -= param1.y;
      }
      
      public function multiply(param1:Number) : void
      {
         this.x *= param1;
         this.y *= param1;
      }
      
      public function divide(param1:Number) : void
      {
         if(param1 == 0)
         {
            trace("Vector::dividedBy() - Illegal Divide by Zero!");
         }
         else
         {
            this.x /= param1;
            this.y /= param1;
         }
      }
      
      public function truncate(param1:Number) : void
      {
         if(this.lengthSq > param1 * param1)
         {
            this.normalize();
            this.multiply(param1);
         }
      }
      
      public function wrapAround(param1:Vector2D, param2:Vector2D) : void
      {
         if(this.x > param2.x)
         {
            this.x = param1.x + (this.x - param2.x);
         }
         else if(this.x < param1.x)
         {
            this.x = param2.x + this.x;
         }
         if(this.y < param1.y)
         {
            this.y = param2.y + this.y;
         }
         else if(this.y > param2.y)
         {
            this.y = param1.y + (this.y - param2.y);
         }
      }
      
      public function addedTo(param1:Vector2D) : Vector2D
      {
         return new Vector2D(this.x + param1.x,this.y + param1.y);
      }
      
      public function subtractedBy(param1:Vector2D) : Vector2D
      {
         return new Vector2D(this.x - param1.x,this.y - param1.y);
      }
      
      public function multipliedBy(param1:Number) : Vector2D
      {
         return new Vector2D(this.x * param1,this.y * param1);
      }
      
      public function dividedBy(param1:Number) : Vector2D
      {
         if(param1 == 0)
         {
            trace("Vector::dividedBy() - Illegal Divide by Zero!");
            return new Vector2D();
         }
         return new Vector2D(this.x / param1,this.y / param1);
      }
      
      public function getNormalized() : Vector2D
      {
         if(this.length == 0)
         {
            return new Vector2D();
         }
         return new Vector2D(this.x / this._length,this.y / this._length);
      }
      
      public function getReverse() : Vector2D
      {
         return new Vector2D(-this.x,-this.y);
      }
      
      public function sign(param1:Vector2D) : int
      {
         if(this.y * param1.x > this.x * param1.y)
         {
            return -1;
         }
         return 1;
      }
      
      public function isParallelTo(param1:Vector2D) : Boolean
      {
         this.v1 = this.copy();
         this.v1.normalize();
         this.v2 = param1.copy();
         this.v2.normalize();
         return this.v1.x == this.v2.x && this.v1.y == this.v2.y || this.v1.x == -this.v2.x && this.v1.y == -this.v2.y;
      }
      
      public function getPerp() : Vector2D
      {
         return new Vector2D(-this.y,this.x);
      }
      
      public function dotOf(param1:Vector2D) : Number
      {
         return this.x * param1.x + this.y * param1.y;
      }
      
      public function crossOf(param1:Vector2D) : Number
      {
         return this.x * param1.y - this.y * param1.x;
      }
      
      public function angleTo(param1:Vector2D) : Number
      {
         return Math.acos(this.dotOf(param1) / (this.length * param1.length));
      }
      
      public function perpDotOf(param1:Vector2D) : Number
      {
         return this.getPerp().dotOf(param1);
      }
      
      public function projectionOn(param1:Vector2D) : Vector2D
      {
         this.v1 = param1.copy();
         this.v1.multiply(this.dotOf(param1) / param1.dotOf(param1));
         return this.v1;
      }
      
      public function distanceTo(param1:Vector2D) : Number
      {
         var _loc2_:Number = param1.x - this.x;
         var _loc3_:Number = param1.y - this.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc2_ * _loc2_);
      }
      
      public function distanceSqTo(param1:Vector2D) : Number
      {
         var _loc2_:Number = param1.y - this.y;
         var _loc3_:Number = param1.x - this.x;
         return _loc3_ * _loc3_ + _loc2_ * _loc2_;
      }
      
      public function isInsideRegion(param1:Vector2D, param2:Vector2D) : Boolean
      {
         return !(this.x < param1.x || this.x > param1.x + param2.x || this.y < param1.y || this.y > param1.y + param2.y);
      }
   }
}
