package com.adobe.utils
{
   import flash.utils.Dictionary;
   
   public class DictionaryUtil
   {
       
      
      public function DictionaryUtil()
      {
         super();
      }
      
      public static function getKeys(param1:Dictionary) : Array
      {
         var _loc3_:* = null;
         var _loc2_:Array = new Array();
         for(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function getValues(param1:Dictionary) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function containsKey(param1:Dictionary, param2:Object) : Boolean
      {
         var _loc4_:* = undefined;
         var _loc3_:Boolean = false;
         for(_loc4_ in param1)
         {
            if(param2 === _loc4_)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      public static function containsValue(param1:Dictionary, param2:Object) : Boolean
      {
         var _loc4_:* = undefined;
         var _loc3_:Boolean = false;
         for each(_loc4_ in param1)
         {
            if(_loc4_ === param2)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
   }
}
