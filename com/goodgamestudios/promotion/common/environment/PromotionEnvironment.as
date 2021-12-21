package com.goodgamestudios.promotion.common.environment
{
   import com.goodgamestudios.common.environment.AbstractEnvironment;
   import com.goodgamestudios.promotion.common.PromotionModel;
   
   public class PromotionEnvironment extends AbstractEnvironment
   {
       
      
      public var promotedGameId:int;
      
      public var languageCode:String;
      
      public var languageVersion:String;
      
      protected var zipSuffix:String = "ggs";
      
      public function PromotionEnvironment()
      {
         super();
      }
      
      public static function addCacheBreakerParameter(url:String) : String
      {
         return url + ("?ran=" + Math.random() * 1000);
      }
      
      override protected function createLocalEnvironment() : void
      {
         _environment = new PromotionEnvironment_LOCAL_SANDBOX();
      }
      
      override protected function createTestEnvironment() : void
      {
         _environment = new PromotionEnvironment_TEST();
      }
      
      override protected function createLiveEnvironment() : void
      {
         _environment = new PromotionEnvironment_LIVE();
      }
      
      public function getPromotionConfigVersionURL() : String
      {
         return promotionEnvironment.serverUrl + promotionEnvironment.configFolder + PromotionModel.instance.originalGameId + ".properties";
      }
      
      public function getPromotionConfigURL() : String
      {
         return promotionEnvironment.serverUrl + promotionEnvironment.configFolder + PromotionModel.instance.originalGameId + "_" + PromotionModel.instance.configVersion + ".ggs";
      }
      
      public function getPromotionURL() : String
      {
         return promotionEnvironment.serverUrl + promotionEnvironment.assetFolder + promotedGameId + "/assets/CrossPromotionAssetSwf.swf";
      }
      
      public function getOriginalGameLogoURL(gameId:int) : String
      {
         return promotionEnvironment.serverUrl + promotionEnvironment.assetFolder + promotedGameId + "/assets/Logo" + gameId + ".swf";
      }
      
      public function get languageZIPUrl() : String
      {
         return promotionEnvironment.serverUrl + promotionEnvironment.assetFolder + promotedGameId + "/lang/" + "cross-promotion" + "_" + languageCode + "_v" + languageVersion + "." + zipSuffix;
      }
      
      public function get languageVersionsPropertyFileURL() : String
      {
         return promotionEnvironment.serverUrl + promotionEnvironment.assetFolder + promotedGameId + "/langVersion.properties";
      }
      
      public function get fontSWFUrl() : String
      {
         return promotionEnvironment.serverUrl + promotionEnvironment.assetFolder + promotedGameId + "/fonts/Fonts_" + languageCode + "_v" + languageVersion + ".swf";
      }
      
      private function get promotionEnvironment() : IPromotionEnvironment
      {
         return _environment as IPromotionEnvironment;
      }
      
      override public function get name() : String
      {
         return "PromotionEnvironment: " + _environment.name;
      }
   }
}
