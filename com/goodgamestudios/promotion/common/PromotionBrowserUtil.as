package com.goodgamestudios.promotion.common
{
   import flash.external.ExternalInterface;
   
   public class PromotionBrowserUtil
   {
       
      
      public function PromotionBrowserUtil()
      {
         super();
      }
      
      public static function retrieveReferrer(loaderURL:String) : String
      {
         var _loc2_:* = "";
         try
         {
            _loc2_ = ExternalInterface.call("function getLocation() {return document.referrer;}");
            if(_loc2_ == null || _loc2_.indexOf("http") == -1)
            {
               _loc2_ = ExternalInterface.call("document.location.toString");
            }
            trace("PromotionBrowserUtil, retrieveReferrer() -> referrer: " + _loc2_);
         }
         catch(e:Error)
         {
            trace("PromotionBrowserUtil, retrieveReferrer() -> ExternalInterface: Script access denied!");
         }
         if(_loc2_ == null || _loc2_.indexOf("http") == -1)
         {
            _loc2_ = loaderURL;
         }
         return PromotionUrlUtil.getCleanReferrer(_loc2_);
      }
      
      public static function getBrowserLanguage() : String
      {
         var _loc1_:* = null;
         if(!ExternalInterface.available)
         {
            return "n.a.";
         }
         try
         {
            _loc1_ = ExternalInterface.call("function getBrowserLang(){return navigator.language;}");
            if(_loc1_ == null || _loc1_.length <= 1)
            {
               _loc1_ = ExternalInterface.call("function getBrowserLang(){return navigator.browserLanguage;}");
            }
            return _loc1_;
         }
         catch(error:SecurityError)
         {
            return "n.a.";
         }
      }
      
      public static function getUrlVariables() : Object
      {
         var _loc1_:* = null;
         if(ExternalInterface.available)
         {
            try
            {
               _loc1_ = ExternalInterface.call("function(){ var map = {};var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {\tmap[key] = value;});return map;}");
            }
            catch(e:Error)
            {
               trace("Getting url variables from javascript failed!");
            }
         }
         for(var _loc2_ in _loc1_)
         {
            _loc1_[_loc2_] = decodeURI(_loc1_[_loc2_]);
         }
         return _loc1_;
      }
      
      public static function getMainDomainURL() : String
      {
         var _loc1_:String = "";
         try
         {
            _loc1_ = ExternalInterface.call("function getLocation() {return document.referrer;}");
            if(_loc1_ == null || _loc1_.indexOf("http") == -1)
            {
               _loc1_ = ExternalInterface.call("document.location.toString");
            }
         }
         catch(e:Error)
         {
            trace("Script access denied!");
         }
         return _loc1_;
      }
   }
}
