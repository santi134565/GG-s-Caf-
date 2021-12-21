package com.goodgamestudios.basic.model.components
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.BasicConstants;
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.error.LanguageError;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.utils.ZipUtil;
   import flash.events.EventDispatcher;
   import flash.net.URLLoaderDataFormat;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class BasicLanguageData extends EventDispatcher
   {
      
      public static const GAME_LANGUAGE_DICTIONARY:String = "gameLanguageDict";
       
      
      protected var gameLanguageDict:Dictionary;
      
      private var _languageXML:XML;
      
      private var envGlobalsClass:Class;
      
      public function BasicLanguageData(param1:Class)
      {
         super();
         if(param1)
         {
            this.envGlobalsClass = param1;
         }
         else
         {
            this.envGlobalsClass = BasicEnvironmentGlobals;
         }
      }
      
      public function checkSingleOrMultiText(param1:int, param2:String, param3:Array = null) : String
      {
         if(param1 == 1)
         {
            return this.getTextById(param2 + "_single",param3);
         }
         return this.getTextById(param2,param3);
      }
      
      public function getTextById(param1:String, param2:Array = null) : String
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc3_:RegExp = /\\n/g;
         var _loc4_:RegExp = /&amp;/g;
         var _loc5_:Dictionary = this.gameLanguageDict;
         if(DictionaryUtil.containsKey(_loc5_,param1))
         {
            _loc6_ = _loc5_[param1];
            if(param2)
            {
               _loc8_ = 0;
               while(_loc8_ < param2.length)
               {
                  _loc9_ = "{" + _loc8_ + "}";
                  while(_loc6_.indexOf(_loc9_) >= 0)
                  {
                     _loc6_ = _loc6_.replace(_loc9_,param2[_loc8_]);
                  }
                  _loc8_++;
               }
            }
            _loc7_ = this.env.language != "de" && (this.env.isTest || this.env.isLocal) ? "|" : "";
            return (_loc6_ = _loc6_.replace(_loc4_,"&")).replace(_loc3_,"\n") + _loc7_;
         }
         return "";
      }
      
      private function insertXMLTextToDict(param1:Dictionary, param2:XML) : void
      {
         var _loc3_:XML = null;
         if(param2.hasComplexContent())
         {
            for each(_loc3_ in param2.children())
            {
               this.insertXMLTextToDict(param1,_loc3_);
            }
         }
         else if(param2.@id != "")
         {
            if(DictionaryUtil.containsKey(param1,String(param2.@id)))
            {
               throw new LanguageError("ERROR! Double entry in Languagefile, please check the languageXML.");
            }
            param1[String(param2.@id)] = String(param2.@name);
         }
      }
      
      public function getLanguageDictByStructArray(param1:Array) : Dictionary
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc2_:Dictionary = new Dictionary();
         for each(_loc4_ in param1)
         {
            for each(_loc3_ in this.languageXML[_loc4_].children())
            {
               this.insertXMLTextToDict(_loc2_,_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getLanguageDictByAllXMLChilds() : Dictionary
      {
         var _loc2_:XML = null;
         var _loc3_:XML = null;
         var _loc1_:Dictionary = new Dictionary();
         for each(_loc3_ in this.languageXML.*)
         {
            for each(_loc2_ in _loc3_.children())
            {
               this.insertXMLTextToDict(_loc1_,_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function onXMLLoadComplete() : void
      {
         var _loc1_:ByteArray = ZipUtil.tryUnzip(BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.LANGUAGE_RES_LOADER) as ByteArray);
         this.env.useZipXMLs = _loc1_ != null;
         if(this.env.useZipXMLs)
         {
            this._languageXML = XML(_loc1_);
            this.gameLanguageDict = this.getLanguageDictByAllXMLChilds();
            dispatchEvent(new LanguageDataEvent(LanguageDataEvent.XML_LOAD_COMPLETE));
         }
         else
         {
            BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.LANGUAGE_RES_LOADER,this.env.languageXMLUrl,URLLoaderDataFormat.BINARY,this.onUncompressedXMLLoadComplete,true);
         }
      }
      
      private function onUncompressedXMLLoadComplete() : void
      {
         this._languageXML = XML(BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.LANGUAGE_RES_LOADER) as ByteArray);
         this.gameLanguageDict = this.getLanguageDictByAllXMLChilds();
         dispatchEvent(new LanguageDataEvent(LanguageDataEvent.XML_LOAD_COMPLETE));
      }
      
      public function loadLanguage(param1:String) : void
      {
         this.env.language = param1;
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.LANGUAGE_RES_LOADER,this.env.languageXMLUrl,URLLoaderDataFormat.BINARY,this.onXMLLoadComplete,true);
      }
      
      public function changeLanguage(param1:String) : void
      {
         if(this.env.language != param1)
         {
            this.loadLanguage(param1);
         }
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new this.envGlobalsClass();
      }
      
      protected function get languageXML() : XML
      {
         return this._languageXML;
      }
      
      protected function set languageXML(param1:XML) : void
      {
         this._languageXML = param1;
      }
   }
}
