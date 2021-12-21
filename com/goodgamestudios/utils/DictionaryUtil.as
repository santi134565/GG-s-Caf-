package com.goodgamestudios.utils
{
   import flash.utils.Dictionary;
   
   public class DictionaryUtil
   {
       
      
      public function DictionaryUtil()
      {
         super();
      }
      
      public static function getKeys(d:Dictionary) : Array
      {
         var _loc2_:Array = [];
         for(var _loc3_ in d)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function getValues(d:Dictionary) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_ in d)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function containsKey(dictionary:Dictionary, key:Object) : Boolean
      {
         if(dictionary[key] === undefined)
         {
            return false;
         }
         return true;
      }
      
      public static function containsValue(dictionary:Dictionary, value:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         for each(var _loc4_ in dictionary)
         {
            if(_loc4_ === value)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      public static function clone(original:Dictionary) : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary();
         for(var _loc3_ in original)
         {
            _loc2_[_loc3_] = original[_loc3_];
         }
         return _loc2_;
      }
      
      public static function getKeyForValue(dictionary:Dictionary, value:Object) : Object
      {
         for(var _loc3_ in dictionary)
         {
            if(value === dictionary[_loc3_])
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function concatDictionaries(... rest) : Dictionary
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:Dictionary = rest[0] as Dictionary;
         _loc4_ = 1;
         while(_loc4_ < rest.length)
         {
            _loc2_ = rest[_loc4_];
            for(var _loc3_ in _loc2_)
            {
               _loc5_[_loc3_] = _loc2_[_loc3_];
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public static function getDictionaryLength(dictionary:Dictionary) : int
      {
         var _loc2_:int = 0;
         for(var _loc3_ in dictionary)
         {
            _loc2_++;
         }
         return _loc2_;
      }
   }
}
