package com.goodgamestudios.cafe.version
{
   public class CafeGameVersion
   {
      
      public static const BUILD_NUMBER:int = 1603;
      
      public static const VERSION:String = "0.9";
      
      public static const DATE:String = "201110190912";
       
      
      public function CafeGameVersion()
      {
         super();
      }
      
      public static function get versionText() : String
      {
         return "V" + VERSION + " B" + BUILD_NUMBER;
      }
   }
}
