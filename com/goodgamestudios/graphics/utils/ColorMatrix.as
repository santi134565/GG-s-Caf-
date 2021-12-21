package com.goodgamestudios.graphics.utils
{
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   
   public class ColorMatrix
   {
      
      private static var r_lum:Number = 0.3086;
      
      private static var g_lum:Number = 0.6094;
      
      private static var b_lum:Number = 0.082;
      
      private static var IDENTITY:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
       
      
      public var matrix:Array;
      
      public function ColorMatrix(param1:Object = null)
      {
         super();
         if(param1 is ColorMatrix)
         {
            this.matrix = param1.matrix.concat();
         }
         else if(param1 is Array)
         {
            this.matrix = param1.concat();
         }
         else
         {
            this.reset();
         }
      }
      
      public function reset() : void
      {
         this.matrix = IDENTITY.concat();
      }
      
      public function clone() : ColorMatrix
      {
         return new ColorMatrix(this.matrix);
      }
      
      public function adjustSaturation(param1:Number) : void
      {
         var _loc2_:Number = 1 - param1;
         var _loc3_:Number = _loc2_ * r_lum;
         var _loc4_:Number = _loc2_ * g_lum;
         var _loc5_:Number = _loc2_ * b_lum;
         var _loc6_:Array = [_loc3_ + param1,_loc4_,_loc5_,0,0,_loc3_,_loc4_ + param1,_loc5_,0,0,_loc3_,_loc4_,_loc5_ + param1,0,0,0,0,0,1,0];
         this.concat(_loc6_);
      }
      
      public function adjustContrast(param1:Number, param2:Number, param3:Number) : void
      {
         param2 = Number(param2) || Number(param1);
         param3 = Number(param3) || Number(param1);
         param1 += 1;
         param2 += 1;
         param3 += 1;
         var _loc4_:Array = [param1,0,0,0,128 * (1 - param1),0,param2,0,0,128 * (1 - param2),0,0,param3,0,128 * (1 - param3),0,0,0,1,0];
         this.concat(_loc4_);
      }
      
      public function adjustBrightness(param1:Number, param2:Number, param3:Number) : void
      {
         param2 = Number(param2) || Number(param1);
         param3 = Number(param3) || Number(param1);
         var _loc4_:Array = [1,0,0,0,param1,0,1,0,0,param2,0,0,1,0,param3,0,0,0,1,0];
         this.concat(_loc4_);
      }
      
      public function adjustHue(param1:Number) : void
      {
         param1 *= Math.PI / 180;
         var _loc2_:Number = Math.cos(param1);
         var _loc3_:Number = Math.sin(param1);
         var _loc4_:Number = 0.213;
         var _loc5_:Number = 0.715;
         var _loc6_:Number = 0.072;
         var _loc7_:Array = [_loc4_ + _loc2_ * (1 - _loc4_) + _loc3_ * -_loc4_,_loc5_ + _loc2_ * -_loc5_ + _loc3_ * -_loc5_,_loc6_ + _loc2_ * -_loc6_ + _loc3_ * (1 - _loc6_),0,0,_loc4_ + _loc2_ * -_loc4_ + _loc3_ * 0.143,_loc5_ + _loc2_ * (1 - _loc5_) + _loc3_ * 0.14,_loc6_ + _loc2_ * -_loc6_ + _loc3_ * -0.283,0,0,_loc4_ + _loc2_ * -_loc4_ + _loc3_ * -(1 - _loc4_),_loc5_ + _loc2_ * -_loc5_ + _loc3_ * _loc5_,_loc6_ + _loc2_ * (1 - _loc6_) + _loc3_ * _loc6_,0,0,0,0,0,1,0,0,0,0,0,1];
         this.concat(_loc7_);
      }
      
      public function colorize(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = (param1 >> 16 & 255) / 255;
         var _loc4_:Number = (param1 >> 8 & 255) / 255;
         var _loc5_:Number = (param1 & 255) / 255;
         var _loc6_:Number;
         var _loc7_:Array = [(_loc6_ = 1 - param2) + param2 * _loc3_ * r_lum,param2 * _loc3_ * g_lum,param2 * _loc3_ * b_lum,0,0,param2 * _loc4_ * r_lum,_loc6_ + param2 * _loc4_ * g_lum,param2 * _loc4_ * b_lum,0,0,param2 * _loc5_ * r_lum,param2 * _loc5_ * g_lum,_loc6_ + param2 * _loc5_ * b_lum,0,0,0,0,0,1,0];
         this.concat(_loc7_);
      }
      
      public function fill(param1:Number) : void
      {
         var _loc2_:Number = param1 >> 16 & 255;
         var _loc3_:Number = param1 >> 8 & 255;
         var _loc4_:Number = param1 & 255;
         var _loc5_:Array = [0,0,0,0,_loc2_,0,0,0,0,_loc3_,0,0,0,0,_loc4_,0,0,0,1,0];
         this.concat(_loc5_);
      }
      
      public function setAlpha(param1:Number) : void
      {
         var _loc2_:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,param1,0];
         this.concat(_loc2_);
      }
      
      public function desaturate() : void
      {
         var _loc1_:Array = [r_lum,g_lum,b_lum,0,0,r_lum,g_lum,b_lum,0,0,r_lum,g_lum,b_lum,0,0,0,0,0,1,0];
         this.concat(_loc1_);
      }
      
      public function invert() : void
      {
         var _loc1_:Array = [-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0];
         this.concat(_loc1_);
      }
      
      public function threshold(param1:Number) : void
      {
         var _loc2_:Array = [r_lum * 256,g_lum * 256,b_lum * 256,0,-256 * param1,r_lum * 256,g_lum * 256,b_lum * 256,0,-256 * param1,r_lum * 256,g_lum * 256,b_lum * 256,0,-256 * param1,0,0,0,1,0];
         this.concat(_loc2_);
      }
      
      public function randomize(param1:Number) : void
      {
         var _loc2_:Number = 1 - param1;
         var _loc3_:Number = _loc2_ + param1 * (Math.random() - Math.random());
         var _loc4_:Number = param1 * (Math.random() - Math.random());
         var _loc5_:Number = param1 * (Math.random() - Math.random());
         var _loc6_:Number = param1 * 255 * (Math.random() - Math.random());
         var _loc7_:Number = param1 * (Math.random() - Math.random());
         var _loc8_:Number = _loc2_ + param1 * (Math.random() - Math.random());
         var _loc9_:Number = param1 * (Math.random() - Math.random());
         var _loc10_:Number = param1 * 255 * (Math.random() - Math.random());
         var _loc11_:Number = param1 * (Math.random() - Math.random());
         var _loc12_:Number = param1 * (Math.random() - Math.random());
         var _loc13_:Number = _loc2_ + param1 * (Math.random() - Math.random());
         var _loc14_:Number = param1 * 255 * (Math.random() - Math.random());
         var _loc15_:Array = [_loc3_,_loc4_,_loc5_,0,_loc6_,_loc7_,_loc8_,_loc9_,0,_loc10_,_loc11_,_loc12_,_loc13_,0,_loc14_,0,0,0,1,0];
         this.concat(_loc15_);
      }
      
      public function setChannels(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number;
         if((_loc5_ = ((param1 & 1) == 1 ? 1 : 0) + ((param1 & 2) == 2 ? 1 : 0) + ((param1 & 4) == 4 ? 1 : 0) + ((param1 & 8) == 8 ? 1 : 0)) > 0)
         {
            _loc5_ = 1 / _loc5_;
         }
         var _loc6_:Number;
         if((_loc6_ = ((param2 & 1) == 1 ? 1 : 0) + ((param2 & 2) == 2 ? 1 : 0) + ((param2 & 4) == 4 ? 1 : 0) + ((param2 & 8) == 8 ? 1 : 0)) > 0)
         {
            _loc6_ = 1 / _loc6_;
         }
         var _loc7_:Number;
         if((_loc7_ = ((param3 & 1) == 1 ? 1 : 0) + ((param3 & 2) == 2 ? 1 : 0) + ((param3 & 4) == 4 ? 1 : 0) + ((param3 & 8) == 8 ? 1 : 0)) > 0)
         {
            _loc7_ = 1 / _loc7_;
         }
         var _loc8_:Number;
         if((_loc8_ = ((param4 & 1) == 1 ? 1 : 0) + ((param4 & 2) == 2 ? 1 : 0) + ((param4 & 4) == 4 ? 1 : 0) + ((param4 & 8) == 8 ? 1 : 0)) > 0)
         {
            _loc8_ = 1 / _loc8_;
         }
         var _loc9_:Array = [(param1 & 1) == 1 ? _loc5_ : 0,(param1 & 2) == 2 ? _loc5_ : 0,(param1 & 4) == 4 ? _loc5_ : 0,(param1 & 8) == 8 ? _loc5_ : 0,0,(param2 & 1) == 1 ? _loc6_ : 0,(param2 & 2) == 2 ? _loc6_ : 0,(param2 & 4) == 4 ? _loc6_ : 0,(param2 & 8) == 8 ? _loc6_ : 0,0,(param3 & 1) == 1 ? _loc7_ : 0,(param3 & 2) == 2 ? _loc7_ : 0,(param3 & 4) == 4 ? _loc7_ : 0,(param3 & 8) == 8 ? _loc7_ : 0,0,(param4 & 1) == 1 ? _loc8_ : 0,(param4 & 2) == 2 ? _loc8_ : 0,(param4 & 4) == 4 ? _loc8_ : 0,(param4 & 8) == 8 ? _loc8_ : 0,0];
         this.concat(_loc9_);
      }
      
      public function blend(param1:ColorMatrix, param2:Number) : void
      {
         var _loc3_:Number = 1 - param2;
         var _loc4_:Number = 0;
         while(_loc4_ < 20)
         {
            this.matrix[_loc4_] = _loc3_ * this.matrix[_loc4_] + param2 * param1.matrix[_loc4_];
            _loc4_++;
         }
      }
      
      public function concat(param1:Array) : void
      {
         var _loc5_:Number = NaN;
         var _loc2_:Array = new Array();
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         while(_loc4_ < 4)
         {
            _loc5_ = 0;
            while(_loc5_ < 5)
            {
               _loc2_[_loc3_ + _loc5_] = param1[_loc3_] * this.matrix[_loc5_] + param1[_loc3_ + 1] * this.matrix[_loc5_ + 5] + param1[_loc3_ + 2] * this.matrix[_loc5_ + 10] + param1[_loc3_ + 3] * this.matrix[_loc5_ + 15] + (_loc5_ == 4 ? param1[_loc3_ + 4] : 0);
               _loc5_++;
            }
            _loc3_ += 5;
            _loc4_++;
         }
         this.matrix = _loc2_;
      }
      
      public function get filter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter(this.matrix);
      }
      
      public function get transformMatrix() : ColorTransform
      {
         return new ColorTransform(1,1,1,1,this.matrix[4] / 255,this.matrix[9] / 255,this.matrix[14] / 255);
      }
   }
}
