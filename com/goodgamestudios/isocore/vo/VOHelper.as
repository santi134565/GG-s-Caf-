package com.goodgamestudios.isocore.vo
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class VOHelper
   {
       
      
      public function VOHelper()
      {
         super();
      }
      
      public static function populateFromDictionary(param1:VisualVO, param2:Dictionary) : void
      {
         var _loc3_:* = null;
         for(_loc3_ in param2)
         {
            param1[_loc3_] = param2[_loc3_];
         }
      }
      
      public static function clone(param1:Object) : Object
      {
         var _loc4_:String = null;
         var _loc7_:XML = null;
         var _loc8_:XML = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Class = getDefinitionByName(getQualifiedClassName(param1)) as Class;
         var _loc3_:Object = new _loc2_();
         var _loc5_:String = "";
         var _loc6_:XML = describeType(param1);
         for each(_loc7_ in describeType(param1).variable)
         {
            _loc4_ = _loc7_.@name.toString();
            _loc3_[_loc4_] = param1[_loc4_];
         }
         for each(_loc8_ in describeType(param1).accessor)
         {
            _loc4_ = _loc8_.@name.toString();
            _loc3_[_loc4_] = param1[_loc4_];
         }
         return _loc3_;
      }
      
      public static function areEqual(param1:Object, param2:Object) : Boolean
      {
         var _loc6_:String = null;
         var _loc9_:XML = null;
         var _loc10_:XML = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc3_:String = getQualifiedClassName(param1);
         var _loc4_:String = getQualifiedClassName(param2);
         if(_loc3_ != _loc4_)
         {
            return false;
         }
         var _loc5_:* = true;
         var _loc7_:String = "";
         var _loc8_:XML = describeType(param1);
         for each(_loc9_ in describeType(param1).variable)
         {
            _loc6_ = _loc9_.@name.toString();
            _loc5_ = param1[_loc6_] == param2[_loc6_];
         }
         for each(_loc10_ in describeType(param1).accessor)
         {
            _loc6_ = _loc10_.@name.toString();
            _loc5_ = param1[_loc6_] == param2[_loc6_];
         }
         return _loc5_;
      }
      
      private static function updateXMLList(param1:XMLList, param2:Array, param3:VisualVO, param4:VisualVO) : void
      {
         var _loc5_:String = null;
         var _loc7_:XML = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc6_:String = "";
         for each(_loc7_ in param1)
         {
            _loc5_ = _loc7_.@name.toString();
            _loc6_ = _loc7_.@type.toString();
            if(_loc5_ == null)
            {
               continue;
            }
            switch(_loc6_)
            {
               case "Array":
                  _loc8_ = param4[_loc5_] as Array;
                  if((_loc9_ = param3[_loc5_] as Array) == null && _loc8_ != null)
                  {
                     param2.push(_loc5_);
                     param3[_loc5_] = param4[_loc5_];
                  }
                  else if(_loc9_ != null && _loc8_ != null && _loc8_.length == _loc9_.length)
                  {
                     _loc10_ = false;
                     _loc11_ = 0;
                     while(_loc11_ < _loc8_.length)
                     {
                        if(_loc9_[_loc11_] != _loc8_[_loc11_])
                        {
                           _loc10_ = true;
                        }
                        _loc11_++;
                     }
                     if(_loc10_)
                     {
                        param2.push(_loc5_);
                        param3[_loc5_] = param4[_loc5_];
                     }
                  }
                  break;
               default:
                  if(param3[_loc5_] != param4[_loc5_])
                  {
                     param2.push(_loc5_);
                     param3[_loc5_] = param4[_loc5_];
                  }
                  break;
            }
         }
      }
      
      public static function getPropertyValueArray(param1:VisualVO) : Array
      {
         var _loc3_:String = null;
         var _loc5_:XML = null;
         var _loc6_:Object = null;
         var _loc2_:Array = new Array();
         var _loc4_:String = "";
         for each(_loc5_ in describeType(param1).variable)
         {
            _loc3_ = _loc5_.@name.toString();
            _loc4_ = _loc5_.@type.toString();
            (_loc6_ = new Object()).property = _loc3_;
            _loc6_.value = param1[_loc3_];
            _loc6_.dataType = _loc4_;
            _loc6_.group = param1.group;
            _loc2_.push(_loc6_);
         }
         return _loc2_.reverse();
      }
   }
}
