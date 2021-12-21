package com.goodgamestudios.constants.enums
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class BasicEnum
   {
      
      private static var _basicValues:Dictionary = new Dictionary();
      
      protected static const instantiationKey:Number = Math.random();
       
      
      private var _name:String;
      
      public function BasicEnum(name:String, doNotInstantiate:Number)
      {
         super();
         if(doNotInstantiate != instantiationKey)
         {
            throwInstantiationError();
         }
         this._name = name;
         var _loc3_:Class = Object(this).constructor;
         if(_basicValues[_loc3_] == null)
         {
            _basicValues[_loc3_] = new Vector.<BasicEnum>();
         }
         _basicValues[_loc3_].push(this);
      }
      
      protected static function getByProperty(enumType:Class, propertyName:String, propertyValue:*, valueNone:BasicEnum) : BasicEnum
      {
         var _loc6_:* = valueNone;
         var _loc5_:Vector.<BasicEnum>;
         if((_loc5_ = _basicValues[enumType]) != null)
         {
            for each(var _loc7_ in _loc5_)
            {
               if(_loc7_.hasOwnProperty(propertyName) && _loc7_[propertyName] == propertyValue)
               {
                  _loc6_ = _loc7_;
                  break;
               }
            }
         }
         return _loc6_;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function toString() : String
      {
         return getClassName() + "." + _name;
      }
      
      protected function getClassName() : String
      {
         return getQualifiedClassName(this).match("[^:]*$")[0];
      }
      
      protected function throwInstantiationError() : void
      {
         throw new Error("Only instantiate " + getClassName() + " within itself!");
      }
   }
}
