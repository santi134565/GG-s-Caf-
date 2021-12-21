package com.goodgamestudios.parser.country
{
   import com.goodgamestudios.constants.enums.CDN;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   
   public class CountryXMLBuilder implements ICountryXMLBuilder
   {
       
      
      public function CountryXMLBuilder()
      {
         super();
      }
      
      public function buildCountry(ggsCountryCode:String, ggsLanguageCode:String, browserLanguagesCodes:Vector.<String>, geoIpCodes:Vector.<String>, flashLanguageCodes:Vector.<String>, timezoneStart:String, timezoneEnd:String, cdn:String, isDefault:Boolean) : AbstractGGSCountry
      {
         var _loc10_:AbstractGGSCountry;
         (_loc10_ = new AbstractGGSCountry()).ggsCountryCode = ggsCountryCode;
         _loc10_.ggsLanguageCode = ggsLanguageCode;
         _loc10_.browserLanguageCodes = browserLanguagesCodes;
         _loc10_.geoIpCodes = geoIpCodes;
         _loc10_.flashRuntimeLanguageCodes = flashLanguageCodes;
         _loc10_.utcTimezoneMin = parseFloat(timezoneStart);
         _loc10_.utcTimezoneMax = parseFloat(timezoneEnd);
         _loc10_.cdn = CDN.getByAbbreviation(cdn);
         _loc10_.isDefault = isDefault;
         return _loc10_;
      }
   }
}
