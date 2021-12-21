package mx.utils
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class StringUtil
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      public function StringUtil()
      {
         super();
      }
      
      public static function trim(str:String) : String
      {
         if(str == null)
         {
            return "";
         }
         var _loc2_:int = 0;
         while(isWhitespace(str.charAt(_loc2_)))
         {
            _loc2_++;
         }
         var _loc3_:int = str.length - 1;
         while(isWhitespace(str.charAt(_loc3_)))
         {
            _loc3_--;
         }
         if(_loc3_ >= _loc2_)
         {
            return str.slice(_loc2_,_loc3_ + 1);
         }
         return "";
      }
      
      public static function trimArrayElements(value:String, delimiter:String) : String
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(value != "" && value != null)
         {
            _loc3_ = value.split(delimiter);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_[_loc5_] = StringUtil.trim(_loc3_[_loc5_]);
               _loc5_++;
            }
            if(_loc4_ > 0)
            {
               value = _loc3_.join(delimiter);
            }
         }
         return value;
      }
      
      public static function isWhitespace(character:String) : Boolean
      {
         switch(character)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
               return true;
            default:
               return false;
         }
      }
      
      public static function substitute(str:String, ... rest) : String
      {
         var _loc4_:Array = null;
         if(str == null)
         {
            return "";
         }
         var _loc3_:uint = rest.length;
         if(_loc3_ == 1 && rest[0] is Array)
         {
            _loc3_ = (_loc4_ = rest[0] as Array).length;
         }
         else
         {
            _loc4_ = rest;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            str = str.replace(new RegExp("\\{" + _loc5_ + "\\}","g"),_loc4_[_loc5_]);
            _loc5_++;
         }
         return str;
      }
      
      public static function repeat(str:String, n:int) : String
      {
         if(n == 0)
         {
            return "";
         }
         var _loc3_:String = str;
         var _loc4_:int = 1;
         while(_loc4_ < n)
         {
            _loc3_ += str;
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function restrict(str:String, restrict:String) : String
      {
         var _loc6_:uint = 0;
         if(restrict == null)
         {
            return str;
         }
         if(restrict == "")
         {
            return "";
         }
         var _loc3_:Array = [];
         var _loc4_:int = str.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = str.charCodeAt(_loc5_);
            if(testCharacter(_loc6_,restrict))
            {
               _loc3_.push(_loc6_);
            }
            _loc5_++;
         }
         return String.fromCharCode.apply(null,_loc3_);
      }
      
      private static function testCharacter(charCode:uint, restrict:String) : Boolean
      {
         var _loc9_:uint = 0;
         var _loc11_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:* = true;
         var _loc7_:uint = 0;
         var _loc8_:int;
         if((_loc8_ = restrict.length) > 0)
         {
            if((_loc9_ = restrict.charCodeAt(0)) == 94)
            {
               _loc3_ = true;
            }
         }
         var _loc10_:int = 0;
         while(_loc10_ < _loc8_)
         {
            _loc9_ = restrict.charCodeAt(_loc10_);
            _loc11_ = false;
            if(!_loc4_)
            {
               if(_loc9_ == 45)
               {
                  _loc5_ = true;
               }
               else if(_loc9_ == 94)
               {
                  _loc6_ = !_loc6_;
               }
               else if(_loc9_ == 92)
               {
                  _loc4_ = true;
               }
               else
               {
                  _loc11_ = true;
               }
            }
            else
            {
               _loc11_ = true;
               _loc4_ = false;
            }
            if(_loc11_)
            {
               if(_loc5_)
               {
                  if(_loc7_ <= charCode && charCode <= _loc9_)
                  {
                     _loc3_ = _loc6_;
                  }
                  _loc5_ = false;
                  _loc7_ = 0;
               }
               else
               {
                  if(charCode == _loc9_)
                  {
                     _loc3_ = _loc6_;
                  }
                  _loc7_ = _loc9_;
               }
            }
            _loc10_++;
         }
         return _loc3_;
      }
   }
}
