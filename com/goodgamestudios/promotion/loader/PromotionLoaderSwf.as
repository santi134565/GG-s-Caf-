package com.goodgamestudios.promotion.loader
{
   import com.goodgamestudios.ageGate.common.AgeGateController;
   import com.goodgamestudios.common.ProxyClientBehaviorTool;
   import com.goodgamestudios.common.VersionView;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.CountryDetectionVO;
   import com.goodgamestudios.language.countryMapper.CountryDetector;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.promotion.common.PromotionBrowserUtil;
   import com.goodgamestudios.promotion.common.PromotionModel;
   import com.goodgamestudios.promotion.common.PromotionOriginalGameModel;
   import com.goodgamestudios.promotion.common.PromotionOriginalGameVO;
   import com.goodgamestudios.promotion.common.PromotionSimplePreloadAnim;
   import com.goodgamestudios.promotion.common.PromotionUrlSecretInfoTextfield;
   import com.goodgamestudios.promotion.common.language.PromotionLanguageModel;
   import com.goodgamestudios.promotion.common.tracking.PromotionTrackingHandler;
   import com.goodgamestudios.promotion.loader.version.PromotionVersion;
   import com.goodgamestudios.promotion.pages.common.IPromotionContentPage;
   import com.goodgamestudios.promotion.pages.common.PromotionPageEvent;
   import com.goodgamestudios.promotion.pages.common.PromotionVO;
   import com.goodgamestudios.utils.TimezoneUtil;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   
   public class PromotionLoaderSwf extends Sprite
   {
      
      public static const VERSION:String = "$Id: PromotionLoaderSwf.as 11171 2014-04-08 12:59:28Z nzamuruev $";
       
      
      private var loadingAnim:PromotionSimplePreloadAnim;
      
      private var cacheBreakerURL:String;
      
      private var promoAssetLoader:Loader;
      
      private var _scaleFactor:Number = 1;
      
      private var _countryDetector:CountryDetector;
      
      private var _ageGateController:AgeGateController;
      
      private var _promotionUrlSecretInfoTextfield:PromotionUrlSecretInfoTextfield;
      
      private const CACHE_BREAKER_FILE_TYPE:String = ".swf";
      
      private const CACHE_BREAKER_ORIGINAL_POSTFIX:String = "_original";
      
      public function PromotionLoaderSwf()
      {
         super();
         Security.allowDomain("*");
         trace("PromotionLoaderSwf, version:  $Id: PromotionLoaderSwf.as 11171 2014-04-08 12:59:28Z nzamuruev $");
         this.addEventListener("addedToStage",handleAddedToStage);
      }
      
      private function handleAddedToStage(event:Event) : void
      {
         this.removeEventListener("addedToStage",handleAddedToStage);
         VersionView.addVersionToContextMenu(this,PromotionVersion.versionText);
         stage.scaleMode = "noScale";
         stage.align = "TL";
         loadingAnim = new PromotionSimplePreloadAnim();
         addChild(loadingAnim);
         initPromotionModel();
      }
      
      private function initPromotionModel() : void
      {
         PromotionOriginalGameModel.instance.init();
         PromotionModel.instance.loadAccountCookieComplete = onLoadAccountCookieComplete;
         PromotionModel.instance.loadOriginalGame = onLoadOriginalGame;
         PromotionModel.instance.initialize(this);
      }
      
      private function onLoadAccountCookieComplete() : void
      {
         loadCountryXML();
      }
      
      private function loadCountryXML() : void
      {
         _countryDetector = new CountryDetector();
         _countryDetector.countriesLoaded.add(onCountryConfigLoaded);
         _countryDetector.loadCountryXML("http://files-ak.goodgamestudios.com/games-config/country.xml");
      }
      
      private function onCountryConfigLoaded() : void
      {
         _countryDetector.countriesLoaded.remove(onCountryConfigLoaded);
         PromotionModel.instance.initializeSupportedCountries();
         loadPromotionConfigXML();
      }
      
      private function loadPromotionConfigXML() : void
      {
         PromotionModel.instance.loadPromotionConfigComplete = onLoadPromotionConfigComplete;
         PromotionModel.instance.loadPromotionConfig();
      }
      
      private function onLoadPromotionConfigComplete() : void
      {
         detectLanguageAndCountry();
      }
      
      private function detectLanguageAndCountry() : void
      {
         var _loc2_:String = "";
         if(stage.loaderInfo.parameters["country"])
         {
            _loc2_ = String(stage.loaderInfo.parameters["country"]);
         }
         var _loc1_:CountryDetectionVO = new CountryDetectionVO(PromotionBrowserUtil.getBrowserLanguage(),Capabilities.language,TimezoneUtil.getUTCTimezoneWithoutDST(),"",_loc2_);
         _countryDetector.detectionCompleted.add(onCountryDetectionComplete);
         _countryDetector.detectCountry(_loc1_);
      }
      
      private function onCountryDetectionComplete(abstractCountry:AbstractGGSCountry) : void
      {
         GGSCountryController.instance.currentCountry = abstractCountry;
         _countryDetector.detectionCompleted.remove(onCountryDetectionComplete);
         PromotionModel.instance.initializeCountry();
         trace("PromotionLoadeSwf, COUNTRY: " + GGSCountryController.instance.currentCountry);
         if(GGSCountryController.instance.currentCountry.ggsCountryCode == "US" && [5,7,10,2].indexOf(5) != -1)
         {
            PromotionModel.instance.promotionIsActive = false;
         }
         checkCrossPromo();
      }
      
      private function checkCrossPromo() : void
      {
         if(PromotionModel.instance.promotionIsActive)
         {
            loadLanguage();
         }
         else
         {
            checkAgeGate();
         }
      }
      
      private function loadLanguage() : void
      {
         PromotionLanguageModel.instance.onLoadLanguageComplete = handleLoadLanguageComplete;
         PromotionLanguageModel.instance.loadLanguage();
      }
      
      private function handleLoadLanguageComplete() : void
      {
         loadPromotionAssetSWF();
      }
      
      private function loadPromotionAssetSWF() : void
      {
         var _loc3_:String = PromotionModel.instance.environment.getPromotionURL();
         var _loc2_:URLRequest = new URLRequest(_loc3_);
         promoAssetLoader = new Loader();
         promoAssetLoader.contentLoaderInfo.addEventListener("complete",onPromotionAssetComplete);
         promoAssetLoader.contentLoaderInfo.addEventListener("ioError",onPromotionAssetIOError);
         promoAssetLoader.contentLoaderInfo.addEventListener("securityError",onPromotionAssetSecurityError);
         var _loc1_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         if(Security.sandboxType == "remote")
         {
            _loc1_.securityDomain = SecurityDomain.currentDomain;
         }
         promoAssetLoader.load(_loc2_,_loc1_);
      }
      
      private function checkAgeGate() : void
      {
         _ageGateController = new AgeGateController();
         _ageGateController.ageGateAsseLoadComplete = onAgeGateAsseLoadComplete;
         _ageGateController.init(this,loadOriginalCacheBreaker);
      }
      
      private function onAgeGateAsseLoadComplete() : void
      {
         if(this.contains(loadingAnim))
         {
            removeChild(loadingAnim);
         }
         if(promoAssetLoader && this.contains(promoAssetLoader))
         {
            removeChild(promoAssetLoader);
         }
      }
      
      private function onResize(event:Event) : void
      {
         fitPromotionPage();
         centerPromotionPage();
      }
      
      private function fitPromotionPage() : void
      {
         _scaleFactor = ProxyClientBehaviorTool.getScaleFactor(stage.stageWidth,stage.stageHeight);
         promoAssetLoader.scaleX = _scaleFactor;
         promoAssetLoader.scaleY = _scaleFactor;
      }
      
      private function centerPromotionPage() : void
      {
         promoAssetLoader.x = (stage.stageWidth - 800 * _scaleFactor) * 0.5;
      }
      
      public function onLoadOriginalGame() : void
      {
         checkAgeGate();
      }
      
      private function onPlayOriginalGame(event:PromotionPageEvent) : void
      {
         promoAssetLoader.contentLoaderInfo.sharedEvents.removeEventListener("playOriginalGame",onPlayOriginalGame);
         executePromotionTrackingEvent(PromotionModel.instance.originalGameId);
         checkAgeGate();
      }
      
      private function onPlayPromotedGame(event:PromotionPageEvent) : void
      {
         executePromotionTrackingEvent(PromotionModel.instance.promotedGameId);
         loadPromotedGame();
      }
      
      private function onPromotionAssetComplete(event:Event) : void
      {
         removeChild(loadingAnim);
         promoAssetLoader.addEventListener("addedToStage",onAddedToStageLoader);
         addChild(promoAssetLoader);
         _promotionUrlSecretInfoTextfield = new PromotionUrlSecretInfoTextfield();
         addChild(_promotionUrlSecretInfoTextfield);
      }
      
      private function onAddedToStageLoader(event:Event) : void
      {
         var _loc3_:* = null;
         promoAssetLoader.removeEventListener("addedToStage",onAddedToStageLoader);
         stage.addEventListener("resize",onResize);
         fitPromotionPage();
         centerPromotionPage();
         var _loc2_:IPromotionContentPage = promoAssetLoader.contentLoaderInfo.content as IPromotionContentPage;
         if(PromotionModel.instance.promotionIsActive)
         {
            _loc3_ = new PromotionVO();
            _loc3_.originalGameId = PromotionModel.instance.originalGameId;
            _loc3_.originalGameLogoURL = PromotionModel.instance.environment.getOriginalGameLogoURL(PromotionModel.instance.originalGameId);
            _loc3_.languageModel = PromotionLanguageModel.instance;
            _loc3_.originalGameModel = PromotionOriginalGameModel.instance;
            _loc2_.initPromotion(_loc3_);
            promoAssetLoader.contentLoaderInfo.sharedEvents.addEventListener("playPromotedGame",onPlayPromotedGame,false,0,true);
            promoAssetLoader.contentLoaderInfo.sharedEvents.addEventListener("playOriginalGame",onPlayOriginalGame,false,0,true);
         }
      }
      
      private function executePromotionTrackingEvent(selectedGameId:int) : void
      {
         var _loc2_:PromotionModel = PromotionModel.instance;
         var _loc3_:PromotionTrackingHandler = PromotionTrackingHandler.instance;
         if(_loc3_.tracked)
         {
            return;
         }
         _loc3_.init(_loc2_.originalGameId,_loc2_.networkId,_loc2_.referrerURL,Capabilities.language,_loc2_.promotedGameId,selectedGameId,_loc2_.accountId);
         _loc3_.track();
      }
      
      private function onPromotionAssetSecurityError(event:SecurityErrorEvent) : void
      {
         throw new Error(event.text);
      }
      
      private function onPromotionAssetIOError(event:IOErrorEvent) : void
      {
         throw new Error(event.text);
      }
      
      private function loadPromotedGame() : void
      {
         requestGameURL(PromotionModel.instance.promotedGameURL);
      }
      
      private function requestGameURL(url:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(url);
         navigateToURL(_loc2_,"_blank");
      }
      
      private function removeProxyClientChilds() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.numChildren)
         {
            this.removeChildAt(_loc1_);
            _loc1_++;
         }
      }
      
      private function loadOriginalCacheBreaker() : void
      {
         if(stage.loaderInfo.parameters["jumpjupiter"] == "1")
         {
            if(this.contains(loadingAnim))
            {
               removeChild(loadingAnim);
            }
            ExternalInterface.call("onAgeGateValidationDone");
            return;
         }
         removeProxyClientChilds();
         resolveCachbreakerURL(PromotionModel.instance.originalGameId);
         trace("loadOriginalCacheBreaker: " + cacheBreakerURL);
         try
         {
            if(this.loaderInfo.loader)
            {
               loadCacheBreaker();
            }
         }
         catch(e:Error)
         {
            this.loaderInfo.addEventListener("complete",onSelfLoaderAvailable);
         }
      }
      
      private function onSelfLoaderAvailable(event:Event) : void
      {
         loadCacheBreaker();
      }
      
      private function loadCacheBreaker() : void
      {
         var _loc3_:* = null;
         if(stage)
         {
            stage.removeEventListener("resize",onResize);
         }
         var _loc2_:URLRequest = new URLRequest(cacheBreakerURL);
         attachExistingFlashvars(_loc2_);
         var _loc1_:LoaderContext = new LoaderContext(false,new ApplicationDomain());
         this.loaderInfo.loader.load(_loc2_,_loc1_);
      }
      
      private function attachExistingFlashvars(request:URLRequest) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(this.loaderInfo.parameters)
         {
            _loc3_ = this.loaderInfo.parameters;
            _loc2_ = new URLVariables();
            for(var _loc4_ in _loc3_)
            {
               _loc2_[_loc4_] = _loc3_[_loc4_];
            }
            request.data = _loc2_;
         }
      }
      
      private function resolveCachbreakerURL(gameID:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc7_:String = "content";
         var _loc6_:String = "goodgamestudios.com";
         var _loc4_:String = "loader";
         var _loc5_:PromotionOriginalGameVO;
         if(_loc5_ = PromotionOriginalGameModel.instance.getOriginalGameVOById(gameID))
         {
            if(_loc5_.id == 2)
            {
               cacheBreakerURL = "http://www.jumpjupiter.com/game/" + _loc5_.gameCacheBreaker + "_original" + ".swf";
               return;
            }
            _loc7_ = !!_loc5_.subdomain ? _loc5_.subdomain : _loc7_;
            _loc3_ = _loc5_.gameFolder;
            _loc2_ = _loc5_.gameCacheBreaker;
         }
         else
         {
            _loc7_ = "data";
            _loc3_ = "castle";
            _loc2_ = "CastleCacheBreakerSwf";
         }
         cacheBreakerURL = "http://" + _loc7_ + "." + _loc6_ + "/" + _loc4_ + "/" + _loc3_ + "/" + _loc2_ + "_original" + ".swf";
      }
   }
}
