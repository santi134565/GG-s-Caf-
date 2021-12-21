package com.goodgamestudios.language.countryMapper.performance
{
   public interface ICountryDetectorPerformanceAdapter
   {
       
      
      function storeGeoIPRequestTime(value:int) : void;
      
      function storeCountryDetectionFactor(value:int) : void;
   }
}
