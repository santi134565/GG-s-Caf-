package com.goodgamestudios.promotion.loader.version
{
   public class PromotionVersion
   {
      
      public static const SVN_LAST_CHANGED_REVISION:String = "$LastChangedRevision: 10212 $";
      
      public static const BUILD_NUMBER:int = 38;
      
      public static const VERSION:String = "0.1";
      
      public static const DATE:String = "201404081318";
       
      
      public function PromotionVersion()
      {
         super();
      }
      
      public static function get versionText() : String
      {
         return "V0.1 B38";
      }
   }
}
