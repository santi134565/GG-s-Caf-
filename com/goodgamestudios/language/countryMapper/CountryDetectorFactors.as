package com.goodgamestudios.language.countryMapper
{
   public class CountryDetectorFactors
   {
      
      public static const FACTOR_BY_INSTANCE:int = 1;
      
      public static const FACTOR_BY_FLASH_COOKIE:int = 2;
      
      public static const FACTOR_BY_FLASH_VARS:int = 3;
      
      public static const FACTOR_BY_BROWSER_LANGUAGE:int = 4;
      
      public static const FACTOR_BY_FLASHRUNTIME_LANGUAGE:int = 5;
      
      public static const FACTOR_BY_GEOIP:int = 6;
      
      public static const FACTOR_BY_FALLBACK:int = 7;
      
      public static const SUB_FACTOR_BY_TIMEZONE:int = 1;
       
      
      public function CountryDetectorFactors()
      {
         super();
      }
   }
}
