package com.goodgamestudios.basic
{
   import flash.utils.Dictionary;
   
   public interface IEnvironmentGlobals
   {
       
      
      function get gameId() : int;
      
      function get gameTitle() : String;
      
      function get gameDir() : String;
      
      function get subDomain() : String;
      
      function get domain() : String;
      
      function get versionNumberGame() : String;
      
      function get versionDateGame() : String;
      
      function get versionNumberLanguage() : String;
      
      function get refCounterUrl() : String;
      
      function get gameSwfUrl() : String;
      
      function get cacheBreakerUrl() : String;
      
      function get languageXMLUrl() : String;
      
      function get fontSWFUrl() : String;
      
      function get networkInfoUrl() : String;
      
      function get languagePropertiesUrl() : String;
      
      function get standardLanguage() : String;
      
      function get prefix() : String;
      
      function get smartfoxExt() : String;
      
      function get blueboxPort() : int;
      
      function get blueboxPollSpeed() : int;
      
      function get numOfItemLibs() : int;
      
      function get analyticsTrackingPath() : String;
      
      function get availableLanguages() : Array;
      
      function get cookieSaverUrl() : String;
      
      function get cookieName() : String;
      
      function getItemSwfUrl(param1:int) : String;
      
      function get accessKey() : String;
      
      function set accessKey(param1:String) : void;
      
      function get gender() : String;
      
      function set gender(param1:String) : void;
      
      function get displayName() : String;
      
      function set displayName(param1:String) : void;
      
      function get networkId() : int;
      
      function set networkId(param1:int) : void;
      
      function get connectIP() : String;
      
      function set connectIP(param1:String) : void;
      
      function get connectPort() : int;
      
      function set connectPort(param1:int) : void;
      
      function get smartfoxZone() : String;
      
      function set smartfoxZone(param1:String) : void;
      
      function set usePayment(param1:Boolean) : void;
      
      function get usePayment() : Boolean;
      
      function get testConnectIP() : String;
      
      function set testConnectIP(param1:String) : void;
      
      function get testConnectPort() : int;
      
      function set testConnectPort(param1:int) : void;
      
      function get testSmartfoxZone() : String;
      
      function set testSmartfoxZone(param1:String) : void;
      
      function get sfsServerList() : Array;
      
      function set sfsServerList(param1:Array) : void;
      
      function get instanceId() : int;
      
      function set instanceId(param1:int) : void;
      
      function get defaultInstanceId() : int;
      
      function set defaultInstanceId(param1:int) : void;
      
      function get hasInstances() : Boolean;
      
      function get currentInstance() : int;
      
      function get pln() : String;
      
      function set pln(param1:String) : void;
      
      function get sig() : String;
      
      function set sig(param1:String) : void;
      
      function get distributorId() : String;
      
      function set distributorId(param1:String) : void;
      
      function get referrer() : String;
      
      function set referrer(param1:String) : void;
      
      function get isTest() : Boolean;
      
      function set isTest(param1:Boolean) : void;
      
      function get isLocal() : Boolean;
      
      function set isLocal(param1:Boolean) : void;
      
      function get language() : String;
      
      function set language(param1:String) : void;
      
      function get langVersionDict() : Dictionary;
      
      function set langVersionDict(param1:Dictionary) : void;
      
      function get baseURL() : String;
      
      function set baseURL(param1:String) : void;
      
      function get hasNetworkBuddies() : Boolean;
      
      function set hasNetworkBuddies(param1:Boolean) : void;
      
      function get loginIsKeyBased() : Boolean;
      
      function set loginIsKeyBased(param1:Boolean) : void;
      
      function get useexternallinks() : Boolean;
      
      function set useexternallinks(param1:Boolean) : void;
      
      function get invitefriends() : Boolean;
      
      function set invitefriends(param1:Boolean) : void;
      
      function get maxUsernameLength() : int;
      
      function set maxUsernameLength(param1:int) : void;
      
      function get networknameString() : String;
      
      function set networknameString(param1:String) : void;
      
      function get allowedfullscreen() : Boolean;
      
      function set allowedfullscreen(param1:Boolean) : void;
      
      function get defaultLanguage() : String;
      
      function set defaultLanguage(param1:String) : void;
      
      function get enableFeedMessages() : Boolean;
      
      function set enableFeedMessages(param1:Boolean) : void;
      
      function get requestPayByJS() : Boolean;
      
      function set requestPayByJS(param1:Boolean) : void;
      
      function get earnCredits() : int;
      
      function set earnCredits(param1:int) : void;
      
      function get showVersion() : Boolean;
      
      function set showVersion(param1:Boolean) : void;
   }
}
