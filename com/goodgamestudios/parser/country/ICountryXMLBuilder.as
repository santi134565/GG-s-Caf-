package com.goodgamestudios.parser.country
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   
   public interface ICountryXMLBuilder
   {
       
      
      function buildCountry(ggsCountryCode:String, ggsLanguageCode:String, browserLanguagesCodes:Vector.<String>, geoIpCodes:Vector.<String>, flashLanguageCodes:Vector.<String>, timezoneStart:String, timezoneEnd:String, cdn:String, isDefault:Boolean) : AbstractGGSCountry;
   }
}
