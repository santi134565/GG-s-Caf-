package com.goodgamestudios.basic
{
   import com.goodgamestudios.constants.GoodgamePartners;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   
   public class BasicLoaderSwf extends Sprite
   {
       
      
      private var loader:Loader;
      
      public function BasicLoaderSwf()
      {
         this.loader = new Loader();
         super();
         Security.allowDomain("*");
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      protected function get distributorId() : int
      {
         return 0;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.env.isTest = this.loaderInfo.url.indexOf("/games-test/") != -1;
         this.env.isLocal = this.loaderInfo.url.indexOf("file:") == 0;
         this.env.networkId = !!stage.loaderInfo.parameters.network ? int(int(stage.loaderInfo.parameters.network)) : int(GoodgamePartners.NETWORK_GENERAL);
         var _loc2_:URLRequest = new URLRequest(this.env.cacheBreakerUrl);
         var _loc3_:URLVariables = new URLVariables();
         var _loc4_:Date = new Date();
         _loc3_["cache"] = !!this.env.isTest ? String(_loc4_.time) : String(Math.floor(_loc4_.time / 30000));
         _loc3_["distributorId"] = this.distributorId;
         _loc3_["vD"] = this.env.versionDateGame;
         _loc2_.data = _loc3_;
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         var _loc5_:LoaderContext = new LoaderContext(false,new ApplicationDomain());
         addChild(this.loader);
         this.loader.load(_loc2_,_loc5_);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         throw new Error("SecurityError (" + param1.text + ") while loading " + (param1.target as LoaderInfo).url);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         throw new Error("IOError (" + param1.text + ") while loading " + (param1.target as LoaderInfo).url);
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
   }
}
