package com.goodgamestudios.ageGate.common
{
   import com.goodgamestudios.ageGate.common.environment.AgeGateEnvironment;
   import com.goodgamestudios.ageGate.view.IAgeGatePage;
   import com.goodgamestudios.common.ProxyClientBehaviorTool;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.promotion.common.PromotionModel;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   
   public class AgeGateController
   {
       
      
      private var _mainSwf:Sprite;
      
      private var _ageValidated:Function;
      
      public var ageGateAsseLoadComplete:Function;
      
      private var _ageGateLoader:Loader;
      
      private var _ageGatePage:IAgeGatePage;
      
      private var _scaleFactor:Number = 1;
      
      private var _environment:AgeGateEnvironment;
      
      public function AgeGateController()
      {
         super();
      }
      
      public function init(mainSwf:Sprite, ageValidatedCallback:Function) : void
      {
         _mainSwf = mainSwf;
         _ageValidated = ageValidatedCallback;
         if(ageGateCheckNeeded)
         {
            loadAgeGateAsset();
         }
         else
         {
            _ageValidated();
         }
      }
      
      private function loadAgeGateAsset() : void
      {
         _environment = new AgeGateEnvironment();
         _environment.init();
         var _loc3_:String = _environment.ageGateAssetURL;
         var _loc2_:URLRequest = new URLRequest(_loc3_);
         _ageGateLoader = new Loader();
         _ageGateLoader.contentLoaderInfo.addEventListener("complete",onAgeGateAssetComplete);
         _ageGateLoader.contentLoaderInfo.addEventListener("ioError",onAgeGateAssetIOError);
         _ageGateLoader.contentLoaderInfo.addEventListener("securityError",onAgeGateSecurityError);
         var _loc1_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         if(Security.sandboxType == "remote")
         {
            _loc1_.securityDomain = SecurityDomain.currentDomain;
         }
         _ageGateLoader.load(_loc2_,_loc1_);
      }
      
      private function onAgeGateSecurityError(event:SecurityErrorEvent) : void
      {
         throw new Error(event.text);
      }
      
      private function onAgeGateAssetIOError(event:IOErrorEvent) : void
      {
         throw new Error(event.text);
      }
      
      private function onAgeGateAssetComplete(event:Event) : void
      {
         _ageGateLoader.addEventListener("addedToStage",onAddedToStageLoader);
         _mainSwf.stage.addEventListener("resize",onResize);
         ageGateAsseLoadComplete();
         _mainSwf.addChild(_ageGateLoader);
      }
      
      private function onResize(event:Event) : void
      {
         fitAgeGatePage();
         centerAgeGatePage();
      }
      
      private function onAddedToStageLoader(event:Event) : void
      {
         _ageGateLoader.removeEventListener("addedToStage",onAddedToStageLoader);
         _ageGatePage = _ageGateLoader.contentLoaderInfo.content as IAgeGatePage;
         fitAgeGatePage();
         centerAgeGatePage();
         _ageGatePage.initPage();
         _ageGatePage.verificationIsFinished.add(onVerificationFinished);
      }
      
      private function fitAgeGatePage() : void
      {
         _scaleFactor = ProxyClientBehaviorTool.getScaleFactor(_mainSwf.stage.stageWidth,_mainSwf.stage.stageHeight);
         _ageGateLoader.scaleX = _scaleFactor;
         _ageGateLoader.scaleY = _scaleFactor;
      }
      
      private function centerAgeGatePage() : void
      {
         _ageGateLoader.x = (_mainSwf.stage.stageWidth - 800 * _scaleFactor) * 0.5;
      }
      
      private function onVerificationFinished() : void
      {
         _mainSwf.stage.removeEventListener("resize",onResize);
         _ageGateLoader.contentLoaderInfo.removeEventListener("complete",onAgeGateAssetComplete);
         _ageGateLoader.contentLoaderInfo.removeEventListener("ioError",onAgeGateAssetIOError);
         _ageGateLoader.contentLoaderInfo.removeEventListener("securityError",onAgeGateSecurityError);
         _mainSwf.removeChild(_ageGateLoader);
         _ageGateLoader = null;
         _mainSwf = null;
         _ageGatePage.dispose();
         _ageGatePage = null;
         _ageValidated();
         _ageValidated = null;
      }
      
      private function get ageGateCheckNeeded() : Boolean
      {
         return ageGateCheckNeededByCountry && !isAgeVerified;
      }
      
      private function get ageGateCheckNeededByCountry() : Boolean
      {
         return GGSCountryController.instance.currentCountry.ggsCountryCode == "US";
      }
      
      private function get isAgeVerified() : Boolean
      {
         return !!PromotionModel.instance.userAge ? true : false;
      }
   }
}
