package com.goodgamestudios.language.countryMapper.log
{
   public class MockCountryDetectionAdapter implements ICountryDetectionLogAdapter
   {
       
      
      public function MockCountryDetectionAdapter()
      {
         super();
      }
      
      public function debug(... rest) : void
      {
      }
      
      public function info(... rest) : void
      {
      }
      
      public function warn(... rest) : void
      {
      }
      
      public function error(... rest) : void
      {
      }
      
      public function logExternalSecurityError(text:String, countryXMLUrl:String) : void
      {
      }
      
      public function logIOError(text:String, countryXmlUrl:String) : void
      {
      }
   }
}
