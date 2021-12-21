package com.goodgamestudios.stringhelper
{
   public class NumberStringHelper
   {
       
      
      public function NumberStringHelper()
      {
         super();
      }
      
      public static function groupString(param1:Number, param2:Function) : String
      {
         var _loc3_:String = param1.toString().substring(param1.toString().charAt(0) == "-" ? Number(1) : Number(0),param1.toString().indexOf(".") == -1 ? Number(int.MAX_VALUE) : Number(param1.toString().indexOf(".")));
         var _loc4_:int = Math.floor(_loc3_.length / 3);
         var _loc5_:String = "";
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = _loc3_.substr(_loc3_.length - 3,3) + _loc5_;
            _loc3_ = _loc3_.substr(0,_loc3_.length - 3);
            if(_loc3_.length > 0)
            {
               _loc5_ = param2("generic_decimalseparator") + _loc5_;
            }
            _loc6_++;
         }
         var _loc7_:String = param1.toString().indexOf(".") == -1 ? "" : param2("generic_comma") + param1.toString().substr(param1.toString().indexOf(".") + 1);
         return (param1 < 0 ? "-" : "") + _loc3_ + _loc5_ + _loc7_;
      }
   }
}
