package com.goodgamestudios.language.countryMapper
{
   public class CountryDetectionVO
   {
       
      
      public var browserLanguage:String;
      
      public var flashRuntimeLanguage:String;
      
      public var timezoneOffset:Number;
      
      public var countryByNetworkCookie:String;
      
      public var countryByFlashvar:String;
      
      public var countryByInstance:String;
      
      public var fakeGeoIpResponse:String = null;
      
      public var alsoDetectUnavailableCountries:Boolean;
      
      public function CountryDetectionVO(browserLanguage:String, flashRuntimeLanguage:String, timezoneOffset:Number, countryByNetworkCookie:String = "", countryByFlashVar:String = "", countryByInstance:String = "")
      {
         super();
         this.browserLanguage = browserLanguage;
         this.flashRuntimeLanguage = flashRuntimeLanguage;
         this.timezoneOffset = timezoneOffset;
         this.countryByNetworkCookie = countryByNetworkCookie;
         this.countryByFlashvar = countryByFlashVar;
         this.countryByInstance = countryByInstance;
      }
      
      public function toString() : String
      {
         var _loc1_:String = fakeGeoIpResponse != null ? ", geoIpResponse: " + fakeGeoIpResponse : "";
         return "browserLanguage: " + browserLanguage + ", flashplayerLanguage: " + flashRuntimeLanguage + ", timezoneOffset: " + timezoneOffset + ", countryByNetworkCookie: " + countryByNetworkCookie + ", countryByFlashvar: " + countryByFlashvar + ", countryByInstance: " + countryByInstance + _loc1_;
      }
   }
}
