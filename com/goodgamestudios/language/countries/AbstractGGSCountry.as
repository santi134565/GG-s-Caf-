package com.goodgamestudios.language.countries
{
   import com.goodgamestudios.constants.enums.CDN;
   
   public class AbstractGGSCountry
   {
       
      
      private var _flashLocaleId:String = "";
      
      private var _ggsCountryCode:String = "";
      
      private var _browserLanguageCodes:Vector.<String>;
      
      private var _flashRuntimeLanguageCodes:Vector.<String>;
      
      private var _ggsLanguageCode:String = "";
      
      private var _utcTimezoneMin:Number = 0;
      
      private var _utcTimezoneMax:Number = 0;
      
      private var _geoIpCodes:Vector.<String>;
      
      private var _cdn:CDN;
      
      private var _isDefault:Boolean;
      
      private var _useNonLatinCharset:Boolean;
      
      public function AbstractGGSCountry()
      {
         _browserLanguageCodes = new Vector.<String>();
         _flashRuntimeLanguageCodes = new Vector.<String>();
         _geoIpCodes = new Vector.<String>();
         _cdn = CDN.None;
         super();
      }
      
      public function get useNonLatinCharset() : Boolean
      {
         return _useNonLatinCharset;
      }
      
      public function set useNonLatinCharset(value:Boolean) : void
      {
         _useNonLatinCharset = value;
      }
      
      public function get browserLanguageCodes() : Vector.<String>
      {
         return _browserLanguageCodes;
      }
      
      public function set browserLanguageCodes(value:Vector.<String>) : void
      {
         _browserLanguageCodes = value;
      }
      
      public function get flashRuntimeLanguageCodes() : Vector.<String>
      {
         return _flashRuntimeLanguageCodes;
      }
      
      public function set flashRuntimeLanguageCodes(value:Vector.<String>) : void
      {
         _flashRuntimeLanguageCodes = value;
      }
      
      public function get ggsLanguageCode() : String
      {
         return _ggsLanguageCode;
      }
      
      public function set ggsLanguageCode(value:String) : void
      {
         _ggsLanguageCode = value;
         if(_ggsLanguageCode == "no")
         {
            _flashLocaleId = "nb-NO";
         }
         else if(_ggsLanguageCode == "zh")
         {
            _flashLocaleId = "zh-Hans-CN";
         }
         else
         {
            _flashLocaleId = _ggsLanguageCode + "-" + _ggsCountryCode;
         }
      }
      
      public function get ggsCountryCode() : String
      {
         return _ggsCountryCode;
      }
      
      public function set ggsCountryCode(value:String) : void
      {
         _ggsCountryCode = value;
      }
      
      public function get utcTimezoneMin() : Number
      {
         return _utcTimezoneMin;
      }
      
      public function set utcTimezoneMin(value:Number) : void
      {
         _utcTimezoneMin = value;
      }
      
      public function get utcTimezoneMax() : Number
      {
         return _utcTimezoneMax;
      }
      
      public function set utcTimezoneMax(value:Number) : void
      {
         _utcTimezoneMax = value;
      }
      
      public function get geoIpCodes() : Vector.<String>
      {
         return _geoIpCodes;
      }
      
      public function set geoIpCodes(value:Vector.<String>) : void
      {
         _geoIpCodes = value;
      }
      
      public function get isLanguageWrittenRightToLeft() : Boolean
      {
         return _ggsLanguageCode == "ar";
      }
      
      public function toString() : String
      {
         return "ggsCountryCode: \'" + ggsCountryCode + "\', ggsLangCode: \'" + _ggsLanguageCode + "\', flashLangCodes: \'" + _flashRuntimeLanguageCodes + "\', browserLangCodes: \'" + _browserLanguageCodes + "\', geoIpCodes: \'" + _geoIpCodes + "\', timeZoneOffset " + (!!isNaN(_utcTimezoneMin) ? "NA" : "from " + _utcTimezoneMin + " to " + _utcTimezoneMax);
      }
      
      public function get cdn() : CDN
      {
         return _cdn;
      }
      
      public function set cdn(value:CDN) : void
      {
         _cdn = value;
      }
      
      public function get isDefault() : Boolean
      {
         return _isDefault;
      }
      
      public function set isDefault(value:Boolean) : void
      {
         _isDefault = value;
      }
      
      public function get flashLocaleId() : String
      {
         return _flashLocaleId;
      }
      
      public function set flashLocaleId(value:String) : void
      {
         _flashLocaleId = value;
      }
   }
}
