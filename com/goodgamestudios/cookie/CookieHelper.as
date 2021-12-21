package com.goodgamestudios.cookie
{
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   
   public class CookieHelper
   {
      
      public static function flushFailedAfterPending():void
      {
      } 
      
      public function CookieHelper()
      {
         super();
      }
      
      public static function copyCookie(sourceCookie:SharedObject, targetCookie:SharedObject) : void
      {
         if(sourceCookie && targetCookie)
         {
            for(var _loc3_ in sourceCookie.data)
            {
               targetCookie.data[_loc3_] = sourceCookie.data[_loc3_];
            }
            CookieHelper.writeSharedObject(targetCookie);
         }
      }
      
      public static function isCookieEmpty(cookie:SharedObject) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = cookie.data;
         for(var _loc2_ in _loc3_)
         {
            _loc2_;
            return false;
         }
         return true;
      }
      
      public static function writeSharedObject(cookie:SharedObject) : void
      {
         var _loc2_:* = null;
         try
         {
            _loc2_ = cookie.flush();
         }
         catch(e:Error)
         {
            trace("CookieHelper, writeSharedObject() -> Saving Cookie failed: writeSharedObject() -> Saving Cookie failed! " + e.message);
         }
         if(_loc2_ && _loc2_ == "pending" && !cookie.hasEventListener("netStatus"))
         {
            cookie.addEventListener("netStatus",onNetStatusEvent);
         }
         else
         {
            cookie.close();
         }
      }
      
      private static function onNetStatusEvent(event:NetStatusEvent) : void
      {
         var _loc2_:SharedObject = event.currentTarget as SharedObject;
         switch(event.info.code)
         {
            case "SharedObject.Flush.Failed":
               trace("CookieHelper, onNetStatusEvent() -> SharedObject.Flush.Failed");
               flushFailedAfterPending();
               break;
            case "SharedObject.Flush.Success":
               trace("CookieHelper, onNetStatusEvent() -> SharedObject.Flush.Success");
               _loc2_.removeEventListener("netStatus",onNetStatusEvent);
               _loc2_.close();
         }
      }
      
      public static function encrypt(str:String) : String
      {
         return invertString(str);
      }
      
      public static function decrypt(str:String) : String
      {
         return invertString(str);
      }
      
      private static function invertString(str:String) : String
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < str.length)
         {
            _loc2_.push(String.fromCharCode(str.charCodeAt(_loc3_) ^ 255));
            _loc3_++;
         }
         return _loc2_.join("");
      }
   }
}
