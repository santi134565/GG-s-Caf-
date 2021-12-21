package com.goodgamestudios.promotion.common
{
   public class PromotionUrlUtil
   {
       
      
      public function PromotionUrlUtil()
      {
         super();
      }
      
      public static function getCleanReferrer(referrer:String) : String
      {
         return getProtocol(referrer) + "://" + getServerName(referrer);
      }
      
      public static function getServerNameWithPort(url:String) : String
      {
         var _loc2_:int = url.indexOf("/") + 2;
         var _loc3_:int = url.indexOf("/",_loc2_);
         return _loc3_ == -1 ? url.substring(_loc2_) : url.substring(_loc2_,_loc3_);
      }
      
      public static function getServerName(url:String) : String
      {
         var _loc2_:String = getServerNameWithPort(url);
         var _loc3_:int = _loc2_.indexOf("]");
         _loc3_ = _loc3_ > -1 ? _loc2_.indexOf(":",_loc3_) : int(_loc2_.indexOf(":"));
         if(_loc3_ > 0)
         {
            _loc2_ = _loc2_.substring(0,_loc3_);
         }
         return _loc2_;
      }
      
      public static function getProtocol(url:String) : String
      {
         var _loc2_:int = url.indexOf("/");
         var _loc3_:int = url.indexOf(":/");
         if(_loc3_ > -1 && _loc3_ < _loc2_)
         {
            return url.substring(0,_loc3_);
         }
         _loc3_ = url.indexOf("::");
         if(_loc3_ > -1 && _loc3_ < _loc2_)
         {
            return url.substring(0,_loc3_);
         }
         return "";
      }
   }
}
