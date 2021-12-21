package com.goodgamestudios.math
{
   public class Random
   {
       
      
      public function Random()
      {
         super();
         throw new Error("Random is a static class and cannot be instantiated.");
      }
      
      public static function randBit() : Number
      {
         return Math.random();
      }
      
      public static function hexColor() : uint
      {
         return Number("0x" + Math.floor(Math.random() * 16777215).toString(16).toUpperCase());
      }
      
      public static function float(param1:Number, param2:Number = NaN) : Number
      {
         if(isNaN(param2))
         {
            param2 = param1;
            param1 = 0;
         }
         return randBit() * (param2 - param1) + param1;
      }
      
      public static function boolean(param1:Number = 0.5) : Boolean
      {
         return randBit() < param1;
      }
      
      public static function sign(param1:Number = 0.5) : int
      {
         return randBit() < param1 ? 1 : -1;
      }
      
      public static function bit(param1:Number = 0.5) : int
      {
         return randBit() < param1 ? 1 : 0;
      }
      
      public static function integer(param1:Number, param2:Number = NaN) : int
      {
         if(isNaN(param2))
         {
            param2 = param1;
            param1 = 0;
         }
         return Math.floor(float(param1,param2));
      }
   }
}
