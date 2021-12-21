package com.goodgamestudios.promotion.common.language
{
   import com.goodgamestudios.common.environment.AbstractEnvironment;
   import com.goodgamestudios.common.environment.AbstractTestEnvironment;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.promotion.common.PromotionModel;
   import com.goodgamestudios.utils.DictionaryUtil;
   import com.goodgamestudios.utils.ZipUtil;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class PromotionLanguageModel extends AbstractPromotionLanguageModel
   {
      
      private static var _instance:AbstractPromotionLanguageModel;
       
      
      private var _languageVersions:Dictionary;
      
      private var _loader:Loader;
      
      private var _languageXML:XML;
      
      private var _urlLoader:URLLoader;
      
      public function PromotionLanguageModel()
      {
         super();
         _urlLoader = new URLLoader();
         _urlLoader.addEventListener("ioError",onLanguageURLLoaderIOError);
         _urlLoader.addEventListener("securityError",onLanguageURLLoaderSecurityError);
         _loader = new Loader();
         _loader.addEventListener("ioError",onLanguageURLLoaderIOError);
         _loader.addEventListener("securityError",onLanguageURLLoaderSecurityError);
      }
      
      public static function get instance() : AbstractPromotionLanguageModel
      {
         if(!_instance)
         {
            _instance = new PromotionLanguageModel();
         }
         return _instance;
      }
      
      override public function loadLanguage() : void
      {
         loadLanguagePropertyFile();
      }
      
      private function loadLanguagePropertyFile() : void
      {
         var _loc2_:String = PromotionModel.instance.environment.languageVersionsPropertyFileURL;
         trace("PromotionLanguageModel, loadLanguagePropertyFile() -> url: " + _loc2_);
         var _loc1_:URLRequest = new URLRequest(_loc2_);
         _urlLoader.addEventListener("complete",onLanguagePropertyFileLoadComplete);
         _urlLoader.load(_loc1_);
      }
      
      private function onLanguagePropertyFileLoadComplete(event:Event) : void
      {
         trace("PromotionLanguageModel, onLanguagePropertyFileLoadComplete()");
         _urlLoader.removeEventListener("complete",onLanguagePropertyFileLoadComplete);
         var _loc3_:String = URLLoader(event.currentTarget).data.toString();
         parseLanguageProperties(_loc3_);
         var _loc2_:String = _languageVersions[GGSCountryController.instance.currentCountry.ggsLanguageCode];
         PromotionModel.instance.initializeLanguageVersion(_languageVersions[GGSCountryController.instance.currentCountry.ggsLanguageCode]);
         loadLanguageZIP();
      }
      
      private function parseLanguageProperties(languageProperties:String) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         _languageVersions = new Dictionary();
         var _loc2_:* = languageProperties;
         var _loc4_:RegExp = /.*=([0-9]+)/ig;
         var _loc5_:Array = _loc2_.match(_loc4_);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc6_].toString().split("=");
            _languageVersions[_loc3_[0]] = _loc3_[1];
            _loc6_++;
         }
      }
      
      private function loadLanguageZIP() : void
      {
         var _loc2_:String = PromotionModel.instance.environment.languageZIPUrl;
         trace("PromotionLanguageModel, loadLanguageZIP() -> url: " + _loc2_);
         var _loc1_:URLRequest = new URLRequest(_loc2_);
         _urlLoader.addEventListener("complete",onLoadLanguageZIPComplete);
         _urlLoader.dataFormat = "binary";
         _urlLoader.load(_loc1_);
      }
      
      private function onLoadLanguageZIPComplete(event:Event) : void
      {
         trace("PromotionLanguageModel, onLoadLanguageZIPComplete()");
         _urlLoader.removeEventListener("complete",onLoadLanguageZIPComplete);
         var _loc2_:ByteArray = ZipUtil.tryUnzip(_urlLoader.data as ByteArray);
         var _loc3_:* = _loc2_ != null;
         if(_loc3_)
         {
         }
         _languageXML = XML(_loc2_);
         _languageDict = getLanguageDictByAllXMLChilds();
         loadFonts();
      }
      
      public function getLanguageDictByAllXMLChilds() : Dictionary
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:Dictionary = new Dictionary();
         for each(_loc2_ in _languageXML.*)
         {
            for each(_loc3_ in _loc2_.children())
            {
               insertXMLTextToDict(_loc1_,_loc3_);
            }
         }
         return _loc1_;
      }
      
      private function insertXMLTextToDict(dict:Dictionary, text:XML) : void
      {
         if(text.hasComplexContent())
         {
            for each(var _loc3_ in text.children())
            {
               insertXMLTextToDict(dict,_loc3_);
            }
         }
         else if(text.@id != "")
         {
            if(DictionaryUtil.containsKey(dict,String(text.@id)))
            {
               trace("PromotionLanguageModel, insertXMLTextToDict() ERROR");
            }
            else
            {
               dict[text.@id] = String(text.@name);
            }
         }
      }
      
      override public function loadFonts() : void
      {
         var _loc3_:String = PromotionModel.instance.environment.fontSWFUrl;
         trace("PromotionLanguageModel, loadFonts() -> " + _loc3_);
         var _loc1_:URLRequest = new URLRequest(_loc3_);
         var _loc2_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         if(Security.sandboxType == "remote")
         {
            _loc2_.securityDomain = SecurityDomain.currentDomain;
         }
         _loader.contentLoaderInfo.addEventListener("complete",onLoadFontsComplete);
         _loader.load(_loc1_,_loc2_);
      }
      
      private function onLoadFontsComplete(event:Event) : void
      {
         _loader.contentLoaderInfo.removeEventListener("complete",onLoadFontsComplete);
         _fontName = "Fonts_" + GGSCountryController.instance.currentCountry.ggsLanguageCode + "_PromoFont1";
         _urlLoader.removeEventListener("ioError",onLanguageURLLoaderIOError);
         _urlLoader.removeEventListener("securityError",onLanguageURLLoaderSecurityError);
         _loader.contentLoaderInfo.removeEventListener("complete",onLoadFontsComplete);
         _loader.removeEventListener("ioError",onLanguageURLLoaderIOError);
         _loader.removeEventListener("securityError",onLanguageURLLoaderSecurityError);
         onLoadLanguageComplete();
      }
      
      private function onLanguageURLLoaderSecurityError(event:SecurityErrorEvent) : void
      {
         trace("PromotionLanguageModel, onLanguageURLLoaderSecurityError() -> " + event.toString());
      }
      
      private function onLanguageURLLoaderIOError(event:IOErrorEvent) : void
      {
         trace("PromotionLanguageModel, onLanguageURLLoaderIOError() -> " + event.toString());
      }
      
      public function get languageXML() : XML
      {
         return _languageXML;
      }
      
      override public function getTextById(id:String, params:Object = null) : String
      {
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc7_:RegExp = /\\n/g;
         var _loc8_:RegExp = /&amp;/g;
         var _loc5_:Dictionary = _languageDict;
         if(DictionaryUtil.containsKey(_loc5_,id))
         {
            _loc3_ = _loc5_[id];
            for(var _loc4_ in params)
            {
               _loc6_ = "{" + _loc4_ + "}";
               while(_loc3_.indexOf(_loc6_) >= 0)
               {
                  _loc3_ = _loc3_.replace(_loc6_,params[_loc4_]);
               }
            }
            _loc9_ = PromotionModel.instance.environment.environment;
            _loc10_ = GGSCountryController.instance.currentCountry.ggsLanguageCode != "de" && _loc9_ is AbstractTestEnvironment ? "|" : "";
            _loc3_ = _loc3_.replace(_loc8_,"&");
            return _loc3_.replace(_loc7_,"\n") + _loc10_;
         }
         return "";
      }
   }
}
