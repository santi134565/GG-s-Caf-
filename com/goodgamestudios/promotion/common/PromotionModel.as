package com.goodgamestudios.promotion.common
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.promotion.common.environment.PromotionEnvironment;
   import com.goodgamestudios.promotion.common.partner.PromotionPartnerMapper;
   import com.goodgamestudios.promotion.common.partner.PromotionPartnerVO;
   import com.goodgamestudios.utils.ZipUtil;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class PromotionModel
   {
      
      public static const VERSION:String = "$Id: PromotionModel.as 10949 2014-03-24 16:06:18Z agoncharov $";
      
      public static const NAME:String = "PromotionModel";
      
      public static const GAME_ID:int = 5;
      
      private static var _instance:PromotionModel;
       
      
      private var _xmlData:XML;
      
      private var _networkId:int;
      
      private var _configVersion:String;
      
      private var _originalGameId:int;
      
      private var _promotedGameId:int;
      
      private var _promotedGameURL:String;
      
      private var _originalGameCacheBreakerURL:String;
      
      private var _swf:Sprite;
      
      private var _referrerURL:String;
      
      private var _referrerSwfURL:String;
      
      private var _referrerLoaderURL:String;
      
      public var loadAccountCookieComplete:Function;
      
      public var loadPromotionConfigComplete:Function;
      
      public var loadOriginalGame:Function;
      
      private var _accountCookie:PromotionAccountCookie;
      
      private var _accountId:String;
      
      private var _userAge:String;
      
      private var _urlVariables:PromotionURLVariables;
      
      private var _urlLoader:URLLoader;
      
      private var _listOfSupportedCountryCodes:Vector.<String>;
      
      private var _promotionIsActive:Boolean = true;
      
      private var _loadPromotionConfigCompleteFired:Boolean;
      
      private var _environment:PromotionEnvironment;
      
      public function PromotionModel()
      {
         _listOfSupportedCountryCodes = new <String>["CZ","DK","DE","GR","GB","US","ES","FI","FR","HU","IT","NL","NO","BR","PT","PL","RU","SE","BG","RO","SK","TR","LT","AU","JP","KR","AR","CL","CO","IN","MX","VE"];
         super();
      }
      
      public static function get instance() : PromotionModel
      {
         if(!_instance)
         {
            _instance = new PromotionModel();
         }
         return _instance;
      }
      
      public function initialize(swf:Sprite) : void
      {
         _swf = swf;
         _referrerURL = PromotionBrowserUtil.retrieveReferrer(_swf.root.loaderInfo.loaderURL);
         _referrerSwfURL = _swf.root.loaderInfo.url;
         _referrerLoaderURL = _swf.root.loaderInfo.loaderURL;
         setGameId();
         initEnvironment();
         setNetworkId();
         _urlVariables = new PromotionURLVariables();
         _urlVariables.init();
         loadAccountCookieSwf();
         trace("### PROMOTION DEBUG INFO ###");
         trace("originalGameId: " + _originalGameId);
         trace("referrerURL: " + _referrerURL);
         trace("referrerSwfURL: " + _referrerSwfURL);
         trace("referrerLoaderURL: " + _referrerLoaderURL);
         trace("############################");
      }
      
      private function loadAccountCookieSwf() : void
      {
         var _loc1_:Loader = new Loader();
         var _loc2_:URLRequest = new URLRequest("http://account.goodgamestudios.com/CookieSaver.swf");
         var _loc3_:LoaderContext = new LoaderContext();
         _loc3_.applicationDomain = ApplicationDomain.currentDomain;
         _loc1_.contentLoaderInfo.addEventListener("ioError",onLoadAccountCookieError);
         _loc1_.contentLoaderInfo.addEventListener("securityError",onLoadAccountCookieError);
         _loc1_.contentLoaderInfo.addEventListener("complete",onAccountCookieComplete);
         _loc1_.load(_loc2_,_loc3_);
      }
      
      private function onLoadAccountCookieError(e:Event) : void
      {
         var _loc2_:* = null;
         switch(getQualifiedClassName(e))
         {
            case "flash.events::IOErrorEvent":
               _loc2_ = e.type + ": " + (e as IOErrorEvent).text;
               break;
            case "flash.events::SecurityErrorEvent":
               _loc2_ = e.type + ": " + (e as SecurityErrorEvent).text;
               break;
            default:
               _loc2_ = e.type;
         }
         trace(_loc2_);
         loadAccountCookieComplete();
      }
      
      protected function onAccountCookieComplete(event:Event) : void
      {
         event.target.removeEventListener("complete",onAccountCookieComplete);
         storeAccountCookie(event.target as LoaderInfo);
         loadAccountCookieComplete();
      }
      
      private function storeAccountCookie(accountCookieLoaderInfo:LoaderInfo) : void
      {
         try
         {
            _accountCookie = new PromotionAccountCookie((accountCookieLoaderInfo.content as Object).getSharedObject("GGSAccount"));
            _accountId = _accountCookie.accountId;
            _userAge = _accountCookie.ageGateData;
         }
         catch(e:Error)
         {
            trace("PromotionModel: Reading account cookie failed: " + e.message);
         }
      }
      
      private function initEnvironment() : void
      {
         _environment = new PromotionEnvironment();
         _environment.init();
      }
      
      public function initializeCountry() : void
      {
         _environment.languageCode = GGSCountryController.instance.currentCountry.ggsLanguageCode;
      }
      
      public function initializeLanguageVersion(version:String) : void
      {
         _environment.languageVersion = version;
      }
      
      private function setNetworkId() : void
      {
         if(_swf.stage.loaderInfo.parameters["network"])
         {
            _networkId = int(_swf.parent.parent.loaderInfo.parameters["network"]);
         }
         else
         {
            _networkId = 1;
         }
      }
      
      private function setGameId() : void
      {
         var _loc1_:String = _swf.stage.loaderInfo.parameters["originalGameId"];
         if(_loc1_)
         {
            _originalGameId = int(_loc1_);
            return;
         }
         _originalGameId = 5;
      }
      
      public function loadPromotionConfig() : void
      {
         _urlLoader = new URLLoader();
         _urlLoader.addEventListener("complete",onPromotionConfigVersionComplete);
         _urlLoader.addEventListener("ioError",onIOError);
         _urlLoader.addEventListener("securityError",onSecurityError);
         _urlLoader.dataFormat = "text";
         _urlLoader.load(new URLRequest(_environment.getPromotionConfigVersionURL()));
      }
      
      private function onPromotionConfigVersionComplete(event:Event) : void
      {
         _configVersion = _urlLoader.data as String;
         _urlLoader.removeEventListener("complete",onPromotionConfigVersionComplete);
         _urlLoader.addEventListener("complete",onPromotionConfigComplete);
         _urlLoader.dataFormat = "binary";
         _urlLoader.load(new URLRequest(_environment.getPromotionConfigURL()));
      }
      
      private function onPromotionConfigComplete(event:Event) : void
      {
         _urlLoader.removeEventListener("complete",onPromotionConfigComplete);
         _urlLoader.removeEventListener("ioError",onIOError);
         _urlLoader.removeEventListener("securityError",onSecurityError);
         var _loc2_:ByteArray = ZipUtil.tryUnzip(_urlLoader.data as ByteArray);
         var _loc3_:XML = XML(_loc2_);
         parseConfigXML(_loc3_);
      }
      
      private function onIOError(event:IOErrorEvent) : void
      {
         throw new Error(event.text);
      }
      
      private function onSecurityError(event:SecurityErrorEvent) : void
      {
         throw new Error(event.text);
      }
      
      private function detectPartner() : void
      {
         var _loc1_:String = _referrerURL;
         if(_urlVariables && _urlVariables.partnerDomain && _urlVariables.partnerDomain != "")
         {
            _loc1_ = _urlVariables.partnerDomain;
         }
         if(PromotionPartnerMapper.instance.detectPartnerIsBlackListed(_loc1_))
         {
            trace("Partner is blacklisted! Load original game");
            promotionIsActive = false;
            executeLoadPromotionConfigCompleteCallback();
            return;
         }
         var _loc2_:PromotionPartnerVO = PromotionPartnerMapper.instance.detectPartnerFromReferrerURL(_loc1_);
         trace("### PROMOTION DEBUG INFO ###");
         trace("currentWhitePartner: " + _loc2_);
         trace("############################");
         if(_loc2_)
         {
            trace("White partner found! -> " + _loc2_.toString());
            setPromotedGameURL();
            trace("_promotedGameURL -> " + _promotedGameURL);
         }
         else
         {
            trace("NO white partner found!");
            if(_xmlData)
            {
               _promotedGameURL = _xmlData.promoted.promotedGameUrlDefault;
            }
         }
         executeLoadPromotionConfigCompleteCallback();
      }
      
      private function executeLoadPromotionConfigCompleteCallback() : void
      {
         if(!_loadPromotionConfigCompleteFired)
         {
            _loadPromotionConfigCompleteFired = true;
            loadPromotionConfigComplete();
            loadPromotionConfigComplete = null;
         }
      }
      
      private function parseConfigXML(configXML:Object) : void
      {
         try
         {
            _xmlData = XML(configXML);
         }
         catch(e:Error)
         {
            promotionIsActive = false;
            executeLoadPromotionConfigCompleteCallback();
            return;
         }
         _promotedGameId = int(_xmlData.child("promoted").attribute("id"));
         _environment.promotedGameId = _promotedGameId;
         PromotionPartnerMapper.instance.init(_xmlData);
         promotionIsActive = Boolean(int(_xmlData.attribute("active")));
         detectPartner();
      }
      
      public function initializeSupportedCountries() : void
      {
         var _loc2_:Vector.<AbstractGGSCountry> = new Vector.<AbstractGGSCountry>();
         for each(var _loc1_ in _listOfSupportedCountryCodes)
         {
            _loc2_.push(GGSCountryController.instance.getAvailableCountryByCountryCode(_loc1_));
         }
         GGSCountryController.instance.initActiveCountries(_loc2_);
      }
      
      private function setPromotedGameURL() : void
      {
         var _loc1_:PromotionPartnerVO = PromotionPartnerMapper.instance.currentPartner;
         if(!_loc1_)
         {
            _promotedGameURL = _xmlData.promoted.promotedGameUrlDefault;
            return;
         }
         if(_loc1_.promotedGameURL && _loc1_.promotedGameURL != "")
         {
            _promotedGameURL = _loc1_.promotedGameURL;
         }
         else
         {
            _promotedGameURL = _xmlData.promoted.promotedGameUrlDefault;
         }
      }
      
      public function get originalGameId() : int
      {
         return _originalGameId;
      }
      
      public function get promotedGameId() : int
      {
         return _promotedGameId;
      }
      
      public function get promotionIsActive() : Boolean
      {
         return _promotionIsActive;
      }
      
      public function set promotionIsActive(value:Boolean) : void
      {
         if(_promotionIsActive)
         {
            _promotionIsActive = value;
         }
      }
      
      public function get originalGameCacheBreakerURL() : String
      {
         return _originalGameCacheBreakerURL;
      }
      
      public function get promotedGameURL() : String
      {
         return _promotedGameURL;
      }
      
      public function get networkId() : int
      {
         return _networkId;
      }
      
      public function set originalGameCacheBreakerURL(value:String) : void
      {
         _originalGameCacheBreakerURL = value;
      }
      
      public function get referrerURL() : String
      {
         return _referrerURL;
      }
      
      public function get referrerSwfURL() : String
      {
         return _referrerSwfURL;
      }
      
      public function get referrerLoaderURL() : String
      {
         return _referrerLoaderURL;
      }
      
      public function set referrerURL(value:String) : void
      {
         _referrerURL = value;
      }
      
      public function get accountId() : String
      {
         return _accountId;
      }
      
      public function get userAge() : String
      {
         return _userAge;
      }
      
      public function set userAge(value:String) : void
      {
         _accountCookie.ageGateData = value;
      }
      
      public function set accountCookie(value:PromotionAccountCookie) : void
      {
         _accountCookie = value;
      }
      
      public function set accountId(value:String) : void
      {
         _accountId = value;
      }
      
      public function get environment() : PromotionEnvironment
      {
         return _environment;
      }
      
      public function get swf() : Sprite
      {
         return _swf;
      }
      
      public function get configVersion() : String
      {
         return _configVersion;
      }
      
      public function set configVersion(value:String) : void
      {
         _configVersion = value;
      }
   }
}
