package com.goodgamestudios.cafe.version
{
   public class CafeGameVersion
   {
      
      public static const BUILD_NUMBER:int = 1200;
      
      public static const VERSION:String = "0.8";
      
      public static const DATE:String = "201012081030";
       
      
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
