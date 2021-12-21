package com.goodgamestudios.math
{
   public class MathBase
   {
       
      
      public function MathBase()
      {
         super();
         throw new Error("MathBase is a static class and cannot be instantiated.");
      }
      
      public static function toFloatString(param1:Number, param2:int = 4) : String
      {
         param2 = Math.pow(10,param2);
         return (Math.round(param1 * param2) / param2).toString();
      }
      
      public static function max(... rest) : Number
      {
         return maxArray(rest);
      }
      
      public static function min(... rest) : Number
      {
         return minArray(rest);
      }
      
      public static function maxArray(param1:Array) : Number
      {
         return Math.max.apply(MathBase,param1);
      }
      
      public static function minArray(param1:Array) : Number
      {
         return Math.min.apply(MathBase,param1);
      }
      
      public static function floor(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = Math.pow(10,param2);
         return Math.floor(param1 * _loc3_) / _loc3_;
      }
      
      public static function ceil(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = Math.pow(10,param2);
         return Math.ceil(param1 * _loc3_) / _loc3_;
      }
      
      public static function round(param1:Number, param2:Number) : Number
      {
         return Math.round(param1 * Math.pow(10,param2)) / Math.pow(10,param2);
      }
      
      public static function random(param1:Number, param2:Number) : Number
      {
         return Math.round(Math.random() * (param2 - param1)) + param1;
      }
      
      public static function constrain(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 < param2)
         {
            param1 = param2;
         }
         else if(param1 > param3)
         {
            param1 = param3;
         }
         return param1;
      }
      
      public static function clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function limit(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : Number
      {
         if(!param4)
         {
            return clamp(param1,param2,param3);
         }
         while(param1 > param3)
         {
            param1 -= param3 - param2;
         }
         while(param1 < param2)
         {
            param1 += param3 - param2;
         }
         return param1;
      }
      
      public static function distance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param1 - param2;
         var _loc6_:Number = param3 - param4;
         return Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
      }
      
      public static function proportion(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 1) : Number
      {
         var _loc6_:Number = !param5 ? Number(1) : Number(param5);
         var _loc7_:Number;
         return (_loc7_ = (param4 - param3) / (param2 - param1)) * (_loc6_ - param1) + param3;
      }
      
      public static function percent(param1:Number, param2:Number) : Number
      {
         if(param2 == 0)
         {
            return 0;
         }
         return param1 / param2 * 100;
      }
      
      public static function isPositive(param1:Number) : Boolean
      {
         return param1 >= 0;
      }
      
      public static function isNegative(param1:Number) : Boolean
      {
         return param1 < 0;
      }
      
      public static function isOdd(param1:Number) : Boolean
      {
         var _loc2_:Number = new Number(param1);
         var _loc3_:Number = new Number(2);
         return Boolean(_loc2_ % _loc3_);
      }
      
      public static function isEven(param1:Number) : Boolean
      {
         var _loc2_:Number = new Number(param1);
         var _loc3_:Number = new Number(2);
         return _loc2_ % _loc3_ == 0;
      }
      
      public static function isPrime(param1:Number) : Boolean
      {
         if(param1 > 2 && param1 % 2 == 0)
         {
            return false;
         }
         var _loc2_:Number = Math.sqrt(param1);
         var _loc3_:Number = 3;
         while(_loc3_ <= _loc2_)
         {
            if(param1 % _loc3_ == 0)
            {
               return false;
            }
            _loc3_ += 2;
         }
         return true;
      }
      
      public static function factorial(param1:Number) : Number
      {
         if(param1 == 0)
         {
            return 1;
         }
         var _loc2_:Number = param1.valueOf();
         var _loc3_:Number = _loc2_ - 1;
         while(_loc3_)
         {
            _loc2_ *= _loc3_;
            _loc3_--;
         }
         return _loc2_;
      }
      
      public static function getDivisors(param1:Number) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:Number = 1;
         var _loc4_:Number = param1 / 2;
         while(_loc3_ <= _loc4_)
         {
            if(param1 % _loc3_ == 0)
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         if(param1 != 0)
         {
            _loc2_.push(param1.valueOf());
         }
         return _loc2_;
      }
      
      public static function isInteger(param1:Number) : Boolean
      {
         return param1 % 1 == 0;
      }
      
      public static function isNatural(param1:Number) : Boolean
      {
         return param1 >= 0 && param1 % 1 == 0;
      }
      
      public static function sanitizeFloat(param1:Number, param2:uint = 5) : Number
      {
         var _loc3_:Number = Math.pow(10,param2);
         return Math.round(_loc3_ * param1) / _loc3_;
      }
      
      public static function fuzzyEqual(param1:Number, param2:Number, param3:int = 5) : Boolean
      {
         var _loc4_:Number = param1 - param2;
         var _loc5_:Number = Math.pow(10,-param3);
         return _loc4_ < _loc5_ && _loc4_ > -_loc5_;
      }
      
      public static function getSign(param1:Number) : int
      {
         if(param1 < 0)
         {
            return -1;
         }
         return 1;
      }
   }
}
