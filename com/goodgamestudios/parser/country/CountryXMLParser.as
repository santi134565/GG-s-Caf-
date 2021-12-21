package com.goodgamestudios.parser.country
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import mx.utils.StringUtil;
   
   public class CountryXMLParser
   {
       
      
      private var _builder:ICountryXMLBuilder;
      
      public function CountryXMLParser(builder:ICountryXMLBuilder)
      {
         super();
         _builder = builder;
      }
      
      public function parseCountries(countryXML:XML) : Vector.<AbstractGGSCountry>
      {
         var _loc2_:Vector.<AbstractGGSCountry> = new Vector.<AbstractGGSCountry>();
         for each(var _loc3_ in countryXML.children())
         {
            _loc2_.push(parseCountry(_loc3_));
         }
         return _loc2_;
      }
      
      private function parseCountry(countryDefinition:XML) : AbstractGGSCountry
      {
         return _builder.buildCountry(countryDefinition.country,countryDefinition.lang,parseLanguageCodeList(countryDefinition.browserCodes),parseLanguageCodeList(countryDefinition.geoIpCodes),parseLanguageCodeList(countryDefinition.flashCode),countryDefinition.timezoneStart,countryDefinition.timezoneEnd,countryDefinition.np,countryDefinition.attribute("default") == "1");
      }
      
      private function parseLanguageCodeList(codes:String) : Vector.<String>
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc6_:Vector.<String> = new Vector.<String>();
         if(codes != "")
         {
            _loc4_ = /\[/;
            _loc2_ = /\]/;
            codes = codes.replace(_loc4_,"");
            codes = codes.replace(_loc2_,"");
            _loc3_ = codes.split(",");
            for each(var _loc5_ in _loc3_)
            {
               _loc6_.push(StringUtil.trim(_loc5_));
            }
         }
         return _loc6_;
      }
   }
}
