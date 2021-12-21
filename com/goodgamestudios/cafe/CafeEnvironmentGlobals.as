package com.goodgamestudios.cafe
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.cafe.version.CafeAchievementXMLVersion;
   import com.goodgamestudios.cafe.version.CafeGameVersion;
   import com.goodgamestudios.cafe.version.CafeItemLib1Version;
   import com.goodgamestudios.cafe.version.CafeItemLib2Version;
   import com.goodgamestudios.cafe.version.CafeItemLib3Version;
   import com.goodgamestudios.cafe.version.CafeItemsXMLVersion;
   import com.goodgamestudios.cafe.version.CafeLevelXpXMLVersion;
   import com.goodgamestudios.constants.GoodgamePartners;
   
   public class CafeEnvironmentGlobals extends BasicEnvironmentGlobals implements IEnvironmentGlobals
   {
       
      
      public function CafeEnvironmentGlobals()
      {
         super();
      }
      
      public function get achievementXMLUrl() : String
      {
         return baseURL + "/config/" + this.gameTitle + "Achievement_v" + this.versionNumberAchievementXML + "." + zipSuffix;
      }
      
      public function get itemXMLUrl() : String
      {
         return baseURL + "/config/" + this.gameTitle + "Items_v" + this.versionNumberItemsXML + "." + zipSuffix;
      }
      
      public function get levelxpXMLUrl() : String
      {
         return baseURL + "/config/" + this.gameTitle + "LevelXp_v" + this.versionNumberLevelXpXML + "." + zipSuffix;
      }
      
      override public function get availableLanguages() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         for each(_loc2_ in DictionaryUtil.getKeys(langVersionDict))
         {
            if(_loc2_ != "ar")
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      override public function get standardLanguage() : String
      {
         return "en";
      }
      
      override public function get subDomain() : String
      {
         return !!GoodgamePartners.usesCDN(networkId) ? "content" : "files";
      }
      
      override public function get gameId() : int
      {
         return 5;
      }
      
      override public function get gameTitle() : String
      {
         return "Cafe";
      }
      
      override public function get buildNumberGame() : String
      {
         return CafeGameVersion.BUILD_NUMBER.toString();
      }
      
      override public function get versionNumberGame() : String
      {
         return CafeGameVersion.VERSION.toString();
      }
      
      override public function get versionDateGame() : String
      {
         return CafeGameVersion.DATE;
      }
      
      override public function get versionNumberItemLib1() : String
      {
         return CafeItemLib1Version.BUILD_NUMBER.toString();
      }
      
      public function get versionNumberItemLib2() : String
      {
         return CafeItemLib2Version.BUILD_NUMBER.toString();
      }
      
      public function get versionNumberItemLib3() : String
      {
         return CafeItemLib3Version.BUILD_NUMBER.toString();
      }
      
      override public function get numOfItemLibs() : int
      {
         return 3;
      }
      
      override public function get versionNumberItemsXML() : String
      {
         return CafeItemsXMLVersion.BUILD_NUMBER.toString();
      }
      
      override public function get versionNumberAchievementXML() : String
      {
         return CafeAchievementXMLVersion.BUILD_NUMBER.toString();
      }
      
      override public function get versionNumberLevelXpXML() : String
      {
         return CafeLevelXpXMLVersion.BUILD_NUMBER.toString();
      }
      
      override public function get analyticsTrackingPath() : String
      {
         return "/goodgameCafe";
      }
      
      override public function get isLoggingActive() : Boolean
      {
         return true;
      }
   }
}
