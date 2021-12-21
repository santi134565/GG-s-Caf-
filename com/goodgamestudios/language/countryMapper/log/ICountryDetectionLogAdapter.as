package com.goodgamestudios.language.countryMapper.log
{
   public interface ICountryDetectionLogAdapter
   {
       
      
      function debug(... rest) : void;
      
      function info(... rest) : void;
      
      function warn(... rest) : void;
      
      function error(... rest) : void;
      
      function logExternalSecurityError(text:String, countryXMLUrl:String) : void;
      
      function logIOError(text:String, countryXmlUrl:String) : void;
   }
}
