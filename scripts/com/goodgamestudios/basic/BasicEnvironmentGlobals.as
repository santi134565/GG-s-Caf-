package com.goodgamestudios.basic
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.vo.ServerVO;
   import com.goodgamestudios.constants.GoodgamePartners;
   import flash.utils.Dictionary;
   
   public class BasicEnvironmentGlobals implements IEnvironmentGlobals
   {
      
      private static var _network:int;
      
      private static var _instance:int;
      
      private static var _defaultInstance:int;
      
      private static var _distributorId:String;
      
      private static var _referrer:String;
      
      private static var _isTest:Boolean;
      
      private static var _isLocal:Boolean;
      
      private static var _language:String;
      
      private static var _defaultLanguage:String;
      
      private static var _baseURL:String;
      
      private static var _accessKey:String;
      
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
      
      private static var _requestPayByJS:Boolean;
      
      private static var _earnCredits:int;
      
      private static var _allowedfullscreen:Boolean;
      
      private static var _loginIsKeyBased:Boolean;
      
      private static var _useexternallinks:Boolean;
      
      private static var _invitefriends:Boolean;
      
      private static var _maxUsernameLength:int;
      
      private static var _usePayment:Boolean;
      
      private static var _showVersion:Boolean;
      
      private static var _sfsServerList:Array;
      
      private static var _pln:String;
      
      private static var _sig:String;
       
      
      public function BasicEnvironmentGlobals()
      {
         super();
      }
      
      public function get gameId() : int
      {
         return 5;
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
            _loc1_.push(_loc2_.replace("-","_"));
         }
         return _loc1_;
      }
      
      public function get subDomain() : String
      {
         return !!GoodgamePartners.usesCDN(this.networkId) ? "cdn" : "files";
      }
      
      public function get domain() : String
      {
         return "localhost";
      }
      
      public function get itemLibName() : String
      {
         return this.gameTitle + "ItemLib";
      }
      
      public function get versionNumberGame() : String
      {
         return null;
      }
      
      public function get versionNumberLanguage() : String
      {
         return null;
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
         return "http://cdn.goodgamestudios.com/CookieSaver.swf";
      }
      
      public function get gameSwfUrl() : String
      {
         return this.baseURL + "/" + this.prefix + this.gameTitle + "Game_" + this.versionNumberGame + ".swf";
      }
      
      public function get refCounterUrl() : String
      {
         return "http://files." + this.domain + "/loader" + (!!this.isTest ? "-test/" : "/") + "refcount.php";
      }
      
      public function get cacheBreakerUrl() : String
      {
         return "http://" + this.subDomain + "." + this.domain + "/loader" + (!!this.isTest ? "-test/" : "/") + this.gameDir + "/" + this.prefix + this.gameTitle + "CacheBreakerSwf.swf";
      }
      
      public function get languageXMLUrl() : String
      {
         return this.baseURL + "/lang/" + this.gameTitle + "_" + this.language + "_v" + this.langVersionDict[this.language] + ".xml";
      }
      
      public function get fontSWFUrl() : String
      {
         return this.baseURL + "/fonts/" + this.gameTitle + "Fonts_" + this.language + "_v" + this.langVersionDict[this.language] + ".swf";
      }
      
      public function get networkInfoUrl() : String
      {
         var _loc1_:Date = new Date();
         return this.baseURL + "/network/" + this.gameTitle + "Network_" + this.networkId + ".xml?" + String(_loc1_.time);
      }
      
      public function get languagePropertiesUrl() : String
      {
         var _loc1_:Date = new Date();
         return this.baseURL + "/" + this.gameTitle + "LangVersion.properties?" + String(_loc1_.time);
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
      
      public function get showVersion() : Boolean
      {
         return _showVersion;
      }
      
      public function set showVersion(param1:Boolean) : void
      {
         _showVersion = param1;
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
      
      public function get enableFeedMessages() : Boolean
      {
         return _enableFeedMessages;
      }
      
      public function set enableFeedMessages(param1:Boolean) : void
      {
         _enableFeedMessages = param1;
      }
      
      public function get requestPayByJS() : Boolean
      {
         return _requestPayByJS;
      }
      
      public function set requestPayByJS(param1:Boolean) : void
      {
         _requestPayByJS = param1;
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
      
      public function get accessKey() : String
      {
         return _accessKey;
      }
      
      public function set accessKey(param1:String) : void
      {
         _accessKey = param1;
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
         _language = param1;
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
   }
}
