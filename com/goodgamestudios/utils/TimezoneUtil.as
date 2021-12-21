package com.goodgamestudios.utils
{
   public class TimezoneUtil
   {
       
      
      public function TimezoneUtil()
      {
         super();
      }
      
      public static function getTrackingTimezone() : int
      {
         return Math.round(getFlashTimezoneWithoutDST() * -1 / 60) + 13;
      }
      
      public static function getUTCTimezoneWithoutDST() : Number
      {
         return convertFlashTimezoneToUTCTimezone(getFlashTimezoneWithoutDST());
      }
      
      public static function getUTCTimezoneWithDST() : Number
      {
         return convertFlashTimezoneToUTCTimezone(getFlashTimezoneWithDST());
      }
      
      public static function getFlashTimezoneWithoutDST() : Number
      {
         var _loc2_:Number = new Date().fullYear;
         var _loc4_:Date = new Date(_loc2_,0,1);
         var _loc3_:Date = new Date(_loc2_,6,1);
         return Number(Math.max(_loc4_.timezoneOffset,_loc3_.timezoneOffset));
      }
      
      public static function getFlashTimezoneWithDST() : Number
      {
         var _loc1_:Date = new Date();
         return _loc1_.timezoneOffset;
      }
      
      public static function getDST() : Number
      {
         var _loc2_:Number = getFlashTimezoneWithoutDST();
         var _loc1_:Number = new Date().timezoneOffset - _loc2_;
         return convertFlashTimezoneToUTCTimezone(_loc1_);
      }
      
      public static function hasDST() : Boolean
      {
         var _loc1_:Number = new Date().fullYear;
         var _loc3_:Date = new Date(_loc1_,0,1);
         var _loc2_:Date = new Date(_loc1_,6,1);
         return _loc3_.timezoneOffset != _loc2_.timezoneOffset;
      }
      
      public static function isDSTActive() : Boolean
      {
         var _loc2_:Number = getFlashTimezoneWithoutDST();
         var _loc1_:Number = new Date().timezoneOffset - _loc2_;
         return _loc1_ == 0 ? false : true;
      }
      
      public static function convertFlashTimezoneToUTCTimezone(flashTimezone:Number) : Number
      {
         return flashTimezone / 60 * -1;
      }
      
      public static function convertUTCTimezoneToFlashTimezone(utcTimezone:int) : int
      {
         return utcTimezone * 60 * -1;
      }
   }
}
