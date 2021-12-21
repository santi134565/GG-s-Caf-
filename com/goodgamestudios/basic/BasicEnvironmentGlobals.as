package com.goodgamestudios.basic
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.vo.ServerVO;
   import com.goodgamestudios.constants.CommonGameStates;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.marketing.google.CampaignVars;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class BasicEnvironmentGlobals implements IEnvironmentGlobals
   {
      
      private static var _network:int;
      
      private static var _instance:int;
      
      private static var _forceInstanceConnect:Boolean = false;
      
      private static var _defaultInstance:int;
      
      private static var _distributorId:String;
      
      private static var _referrer:String;
      
      private static var _invitedBy:String;
      
      private static var _isTest:Boolean;
      
      private static var _isUsabilityTest:Boolean;
      
      private static var _isLocal:Boolean;
      
      private static var _language:String;
      
      private static var _flashVarlanguage:String;
      
      private static var _defaultLanguage:String;
      
      private static var _baseURL:String;
      
      private static var _accountId:String;
      
      private static var _accessKey:String;
      
      private static var _campainVars:CampaignVars;
      
      private static var _gender:String;
      
      private static var _displayName:String;
      
      private static var _langVersionDict:Dictionary;
      
      private static var _smartfoxZone:String;
      
      private static var _connectIP:String;
      
      private static var _connectPort:int;
      
      private static var _testSmartfoxZone:String;
      
      private static var _testConnectIP:String;
      
      private static var _testConnectPort:int;
      
      private static var _hasNetworkBuddies:Boolean;
      
      private static var _networknameString:String;
      
      private static var _enableFeedMessages:Boolean;
      
      private static var _enablelonelyCow:Boolean;
      
      private static var _requestPayByJS:Boolean;
      
      private static var _networkNewsByJS:Boolean;
      
      private static var _earnCredits:int;
      
      private static var _allowedfullscreen:Boolean;
      
      private static var _loginIsKeyBased:Boolean;
      
      private static var _useexternallinks:Boolean;
      
      private static var _invitefriends:Boolean;
      
      private static var _maxUsernameLength:int;
      
      private static var _usePayment:Boolean;
      
      private static var _isFirstVisit:Boolean;
      
      private static var _showVersion:Boolean;
      
      private static var _sfsServerList:Array;
      
      private static var _pln:String;
      
      private static var _sig:String;
      
      private static var _gameState:String;
      
      private static var _buildNumberServer:int;
      
      private static var _isLoggingActive:Boolean = true;
      
      private static var _showLoadingText:Boolean = false;
      
      private static var _clientInstanceHash:int;
      
      private static var _useZipXMLs:Boolean = true;
      
      private static var _useABTest:Boolean = false;
      
      private static var _cdnSubDomain:String = "media";
       
      
      public function BasicEnvironmentGlobals()
      {
         super();
      }
      
      public function initBaseUrl(param1:String) : void
      {
         this.baseURL = param1.slice(0,param1.lastIndexOf("/"));
      }
      
      public function get urlAgb_de() : String
      {
         return "http://www.goodgamestudios.com/de/agb-datenschutz/";
      }
      
      public function get urlAgb_otherlanguage() : String
      {
         return "http://www.goodgamestudios.com/terms-conditions/";
      }
      
      public function get gameId() : int
      {
         return -1;
      }
      
      public function get gameTitle() : String
      {
         return "Basic";
      }
      
      public function get gameDir() : String
      {
         return this.gameTitle.toLowerCase();
      }
      
      public function get standardLanguage() : String
      {
         return "de";
      }
      
      public function get availableLanguages() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         for each(_loc2_ in DictionaryUtil.getKeys(this.langVersionDict))
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get subDomain() : String
      {
         if(GoodgamePartners.usesCDN(this.networkId) == false)
         {
            return "files";
         }
         return _cdnSubDomain;
      }
      
      public function get domain() : String
      {
         return "localhost";
      }
      
      public function get itemLibName() : String
      {
         return this.gameTitle + "ItemLib";
      }
      
      public function get buildNumberGame() : String
      {
         return null;
      }
      
      public function get versionNumberGame() : String
      {
         return null;
      }
      
      public function get versionText() : String
      {
         return "V" + this.versionNumberGame + " B" + this.buildNumberGame + (this.buildNumberServer != 0 ? " S" + this.buildNumberServer : "");
      }
      
      public function get versionNumberItemsXML() : String
      {
         return null;
      }
      
      public function get versionNumberAchievementXML() : String
      {
         return null;
      }
      
      public function get versionNumberLevelXpXML() : String
      {
         return null;
      }
      
      public function get versionDateGame() : String
      {
         return null;
      }
      
      public function get numOfItemLibs() : int
      {
         return 1;
      }
      
      public function get versionNumberItemLib1() : String
      {
         return null;
      }
      
      public function get cookieName() : String
      {
         return "Goodgame" + this.gameTitle + "_" + this.networkId;
      }
      
      public function get cookieSaverUrl() : String
      {
         return "http://" + _cdnSubDomain + ".localhost/CookieSaver.swf";
      }
      
      public function get accountCookieUrl() : String
      {
         return "http://account.localhost/CookieSaver.swf";
      }
      
      public function get gameSwfUrl() : String
      {
         return this.baseURL + "/" + this.prefix + this.gameTitle + "Game_" + this.buildNumberGame + ".swf";
      }
      
      public function get refCounterUrl() : String
      {
         if(this.isUsabilityTest)
         {
            return "http://files." + this.domain + "/loader" + "-usability/" + "refcount.php";
         }
         if(this.isTest)
         {
            return "http://files." + this.domain + "/loader" + "-test/" + "refcount.php";
         }
         return "http://files." + this.domain + "/loader" + "/" + "refcount.php";
      }
      
      public function get cacheBreakerUrl() : String
      {
         if(this.isUsabilityTest)
         {
            return "http://" + this.subDomain + "." + this.domain + "/loader" + "-usability/" + this.gameDir + "/" + this.prefix + this.gameTitle + "CacheBreakerSwf.swf";
         }
         if(this.isTest)
         {
            return "http://" + this.subDomain + "." + this.domain + "/loader" + "-test/" + this.gameDir + "/" + this.prefix + this.gameTitle + "CacheBreakerSwf.swf";
         }
         return "http://" + this.subDomain + "." + this.domain + "/loader" + "/" + this.gameDir + "/" + this.prefix + this.gameTitle + "CacheBreakerSwf.swf";
      }
      
      public function get languageXMLUrl() : String
      {
         return this.baseURL + "/lang/" + this.gameTitle + "_" + this.language + "_v" + this.langVersionDict[this.language] + "." + this.zipSuffix;
      }
      
      public function get fontSWFUrl() : String
      {
         return this.baseURL + "/fonts/" + this.gameTitle + "Fonts_" + this.language + "_v" + this.langVersionDict[this.language] + ".swf";
      }
      
      public function get networkInfoUrl() : String
      {
         var _loc1_:Date = new Date();
         var _loc2_:* = this.baseURL + "/network/" + this.gameTitle + "Network_" + this.networkId + ".xml";
         if(!this.isLocal)
         {
            _loc2_ += "?cache=" + String(_loc1_.time);
         }
         return _loc2_;
      }
      
      public function get languagePropertiesUrl() : String
      {
         var _loc1_:Date = new Date();
         return this.baseURL + "/" + this.gameTitle + "LangVersion.properties?cache=" + String(_loc1_.time);
      }
      
      public function getItemSwfUrl(param1:int) : String
      {
         return this.baseURL + "/" + this.prefix + this.gameTitle + "ItemLib" + param1 + "_" + this["versionNumberItemLib" + param1] + ".swf";
      }
      
      public function get prefix() : String
      {
         return "";
      }
      
      public function get analyticsTrackingPath() : String
      {
         return "/goodgameBasic";
      }
      
      public function get gameTrackingURL() : String
      {
         return "http://files.goodgamestudios.com/loader/clienttracker.php";
      }
      
      public function get smartfoxExt() : String
      {
         return this.smartfoxZone;
      }
      
      public function get zipSuffix() : String
      {
         if(_useZipXMLs)
         {
            return "ggs";
         }
         return "xml";
      }
      
      public function get blueboxPort() : int
      {
         return 80;
      }
      
      public function get blueboxPollSpeed() : int
      {
         return 500;
      }
      
      public function get hasInstances() : Boolean
      {
         return _sfsServerList.length > 1;
      }
      
      public function get currentInstance() : int
      {
         var _loc1_:ServerVO = null;
         for each(_loc1_ in _sfsServerList)
         {
            if(_loc1_.ip == this.connectIP && _loc1_.extension == this.smartfoxExt)
            {
               return _loc1_.instanceId;
            }
         }
         return 0;
      }
      
      public function get forceAutoLoginWhenInstanceInCookie() : Boolean
      {
         return false;
      }
      
      public function get useZipXMLs() : Boolean
      {
         return _useZipXMLs;
      }
      
      public function set useZipXMLs(param1:Boolean) : void
      {
         _useZipXMLs = param1;
      }
      
      public function get clientInstanceHash() : int
      {
         return _clientInstanceHash;
      }
      
      public function set clientInstanceHash(param1:int) : void
      {
         _clientInstanceHash = param1;
      }
      
      public function get showVersion() : Boolean
      {
         return _showVersion;
      }
      
      public function set showVersion(param1:Boolean) : void
      {
         _showVersion = param1;
      }
      
      public function get buildNumberServer() : int
      {
         return _buildNumberServer;
      }
      
      public function set buildNumberServer(param1:int) : void
      {
         _buildNumberServer = param1;
      }
      
      public function get maxUsernameLength() : int
      {
         return _maxUsernameLength;
      }
      
      public function set maxUsernameLength(param1:int) : void
      {
         _maxUsernameLength = param1;
      }
      
      public function get useexternallinks() : Boolean
      {
         return _useexternallinks;
      }
      
      public function set useexternallinks(param1:Boolean) : void
      {
         _useexternallinks = param1;
      }
      
      public function get invitefriends() : Boolean
      {
         return _invitefriends;
      }
      
      public function set invitefriends(param1:Boolean) : void
      {
         _invitefriends = param1;
      }
      
      public function get loginIsKeyBased() : Boolean
      {
         return _loginIsKeyBased;
      }
      
      public function set loginIsKeyBased(param1:Boolean) : void
      {
         _loginIsKeyBased = param1;
      }
      
      public function get isFirstVisit() : Boolean
      {
         return _isFirstVisit;
      }
      
      public function set isFirstVisit(param1:Boolean) : void
      {
         _isFirstVisit = param1;
      }
      
      public function get enableFeedMessages() : Boolean
      {
         return _enableFeedMessages;
      }
      
      public function set enableFeedMessages(param1:Boolean) : void
      {
         _enableFeedMessages = param1;
      }
      
      public function get enableLonelyCow() : Boolean
      {
         return _enablelonelyCow;
      }
      
      public function set enableLonelyCow(param1:Boolean) : void
      {
         _enablelonelyCow = param1;
      }
      
      public function get requestPayByJS() : Boolean
      {
         return _requestPayByJS;
      }
      
      public function set requestPayByJS(param1:Boolean) : void
      {
         _requestPayByJS = param1;
      }
      
      public function get networkNewsByJS() : Boolean
      {
         return _networkNewsByJS;
      }
      
      public function set networkNewsByJS(param1:Boolean) : void
      {
         _networkNewsByJS = param1;
      }
      
      public function get earnCredits() : int
      {
         return _earnCredits;
      }
      
      public function set earnCredits(param1:int) : void
      {
         _earnCredits = param1;
      }
      
      public function get networkId() : int
      {
         return _network;
      }
      
      public function set networkId(param1:int) : void
      {
         _network = param1;
      }
      
      public function get instanceId() : int
      {
         return _instance;
      }
      
      public function set instanceId(param1:int) : void
      {
         _instance = param1;
      }
      
      public function get forceInstanceConnect() : Boolean
      {
         return _forceInstanceConnect;
      }
      
      public function set forceInstanceConnect(param1:Boolean) : void
      {
         _forceInstanceConnect = param1;
      }
      
      public function get defaultInstanceId() : int
      {
         return _defaultInstance;
      }
      
      public function set defaultInstanceId(param1:int) : void
      {
         _defaultInstance = param1;
      }
      
      public function get pln() : String
      {
         return _pln;
      }
      
      public function set pln(param1:String) : void
      {
         _pln = param1;
      }
      
      public function get sig() : String
      {
         return _sig;
      }
      
      public function set sig(param1:String) : void
      {
         _sig = param1;
      }
      
      public function get gameState() : String
      {
         return _gameState;
      }
      
      public function set gameState(param1:String) : void
      {
         if(_gameState != CommonGameStates.REGISTERED_AND_PLAYING && _gameState != CommonGameStates.NOT_FIRST_LOGIN)
         {
            _gameState = param1;
         }
      }
      
      public function get networknameString() : String
      {
         return _networknameString;
      }
      
      public function set networknameString(param1:String) : void
      {
         _networknameString = param1;
      }
      
      public function get defaultLanguage() : String
      {
         return _defaultLanguage;
      }
      
      public function set defaultLanguage(param1:String) : void
      {
         _defaultLanguage = param1;
      }
      
      public function get connectIP() : String
      {
         return _connectIP;
      }
      
      public function set connectIP(param1:String) : void
      {
         _connectIP = param1;
      }
      
      public function get connectPort() : int
      {
         return _connectPort;
      }
      
      public function set connectPort(param1:int) : void
      {
         _connectPort = param1;
      }
      
      public function get smartfoxZone() : String
      {
         return _smartfoxZone;
      }
      
      public function set smartfoxZone(param1:String) : void
      {
         _smartfoxZone = param1;
      }
      
      public function get testConnectIP() : String
      {
         return _testConnectIP;
      }
      
      public function set testConnectIP(param1:String) : void
      {
         _testConnectIP = param1;
      }
      
      public function get testConnectPort() : int
      {
         return _testConnectPort;
      }
      
      public function set testConnectPort(param1:int) : void
      {
         _testConnectPort = param1;
      }
      
      public function get testSmartfoxZone() : String
      {
         return _testSmartfoxZone;
      }
      
      public function set testSmartfoxZone(param1:String) : void
      {
         _testSmartfoxZone = param1;
      }
      
      public function get sfsServerList() : Array
      {
         return _sfsServerList;
      }
      
      public function set sfsServerList(param1:Array) : void
      {
         _sfsServerList = param1;
      }
      
      public function get hasNetworkBuddies() : Boolean
      {
         return _hasNetworkBuddies;
      }
      
      public function set hasNetworkBuddies(param1:Boolean) : void
      {
         _hasNetworkBuddies = param1;
      }
      
      public function get allowedfullscreen() : Boolean
      {
         return _allowedfullscreen;
      }
      
      public function set allowedfullscreen(param1:Boolean) : void
      {
         _allowedfullscreen = param1;
      }
      
      public function get referrer() : String
      {
         return _referrer;
      }
      
      public function set referrer(param1:String) : void
      {
         _referrer = param1;
      }
      
      public function get invitedBy() : String
      {
         return _invitedBy;
      }
      
      public function set invitedBy(param1:String) : void
      {
         _invitedBy = param1;
      }
      
      public function get accessKey() : String
      {
         return _accessKey;
      }
      
      public function set accessKey(param1:String) : void
      {
         _accessKey = param1;
      }
      
      public function get accountId() : String
      {
         return _accountId != null ? _accountId : "";
      }
      
      public function set accountId(param1:String) : void
      {
         _accountId = param1;
      }
      
      public function get campainVars() : CampaignVars
      {
         return _campainVars;
      }
      
      public function set campainVars(param1:CampaignVars) : void
      {
         _campainVars = param1;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function set gender(param1:String) : void
      {
         _gender = param1;
      }
      
      public function get displayName() : String
      {
         return _displayName;
      }
      
      public function set displayName(param1:String) : void
      {
         _displayName = param1;
      }
      
      public function get isTest() : Boolean
      {
         return _isTest;
      }
      
      public function set isTest(param1:Boolean) : void
      {
         _isTest = param1;
      }
      
      public function get isLocal() : Boolean
      {
         return _isLocal;
      }
      
      public function set isLocal(param1:Boolean) : void
      {
         _isLocal = param1;
      }
      
      public function get distributorId() : String
      {
         return _distributorId;
      }
      
      public function set distributorId(param1:String) : void
      {
         _distributorId = param1;
      }
      
      public function get language() : String
      {
         return _language;
      }
      
      public function set language(param1:String) : void
      {
         var value:String = param1;
         _language = value;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("setLanguage",_language);
            }
            catch(e:Error)
            {
               trace("Calling javascript function \'setLanguage\' failed!");
            }
         }
      }
      
      public function get flashVarLanguage() : String
      {
         return _flashVarlanguage;
      }
      
      public function set flashVarLanguage(param1:String) : void
      {
         _flashVarlanguage = param1;
      }
      
      public function get baseURL() : String
      {
         return _baseURL;
      }
      
      public function set baseURL(param1:String) : void
      {
         _baseURL = param1;
      }
      
      public function get langVersionDict() : Dictionary
      {
         return _langVersionDict;
      }
      
      public function set langVersionDict(param1:Dictionary) : void
      {
         _langVersionDict = param1;
      }
      
      public function set usePayment(param1:Boolean) : void
      {
         _usePayment = param1;
      }
      
      public function get usePayment() : Boolean
      {
         return _usePayment;
      }
      
      public function get isLoggingActive() : Boolean
      {
         return _isLoggingActive;
      }
      
      public function set isLoggingActive(param1:Boolean) : void
      {
         _isLoggingActive = param1;
      }
      
      public function get showLoadingText() : Boolean
      {
         return _showLoadingText;
      }
      
      public function set showLoadingText(param1:Boolean) : void
      {
         _showLoadingText = param1;
      }
      
      public function get useABTest() : Boolean
      {
         return _useABTest;
      }
      
      public function get abTestConfigURL() : String
      {
         return "http://" + _cdnSubDomain + "." + this.domain + "/abFlash/config/abTests_" + this.gameId + ".xml";
      }
      
      public function get cdnSubDomain() : String
      {
         return this.cdnSubDomain;
      }
      
      public function set cdnSubDomain(param1:String) : void
      {
         _cdnSubDomain = param1;
      }
      
      public function get isUsabilityTest() : Boolean
      {
         return _isUsabilityTest;
      }
      
      public function set isUsabilityTest(param1:Boolean) : void
      {
         _isUsabilityTest = param1;
      }
   }
}
