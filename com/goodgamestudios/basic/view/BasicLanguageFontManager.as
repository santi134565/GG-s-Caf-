package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class BasicLanguageFontManager
   {
      
      private static var languageFontManager:BasicLanguageFontManager;
       
      
      public var specialFontLanguageArray:Array;
      
      public function BasicLanguageFontManager()
      {
         this.specialFontLanguageArray = ["ko","ja","zh_CN","zh_TW","ru","ar","el"];
         super();
      }
      
      public static function getInstance() : BasicLanguageFontManager
      {
         if(!languageFontManager)
         {
            languageFontManager = new BasicLanguageFontManager();
         }
         return languageFontManager;
      }
      
      public function changeFontByLanguage(param1:TextField) : void
      {
      }
      
      public function initFontSwf() : void
      {
         if(this.useDefaultFont)
         {
            this.onLanguageFontReady();
         }
         else
         {
            this.loadFontSWF(this.env.fontSWFUrl);
         }
      }
      
      public function get useDefaultFont() : Boolean
      {
         return this.specialFontLanguageArray.indexOf(this.env.language) < 0;
      }
      
      protected function loadFontSWF(param1:String) : void
      {
         var _loc2_:Loader = new Loader();
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onErrorEvent);
         _loc2_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onErrorEvent);
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontSWFLoadComplete);
         _loc2_.load(_loc3_,_loc4_);
      }
      
      private function onErrorEvent(param1:Event) : void
      {
         throw new Error(param1.type);
      }
      
      protected function onFontSWFLoadComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onErrorEvent);
         _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onErrorEvent);
         _loc2_.removeEventListener(Event.COMPLETE,this.onFontSWFLoadComplete);
         var _loc3_:Class = getDefinitionByName(this.env.gameTitle + "Fonts_" + this.env.language + "_" + this.env.gameTitle + "Font1_" + this.env.language) as Class;
         Font.registerFont(_loc3_);
         this.onLanguageFontReady();
      }
      
      protected function onLanguageFontReady() : void
      {
         BasicController.getInstance().dispatchEvent(new LanguageDataEvent(LanguageDataEvent.FONT_LOAD_COMPLETE));
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
   }
}
