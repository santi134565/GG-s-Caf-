package com.goodgamestudios.marketing.google
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class CampaignUtils
   {
       
      
      public function CampaignUtils()
      {
         super();
      }
      
      public static function sendRegisterEvent(param1:int, param2:int) : void
      {
         var _loc3_:String = "";
         _loc3_ = "http://pixel.goodgamestudios.com/reg/" + param1 + "/" + param2;
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         var _loc5_:URLLoader;
         (_loc5_ = new URLLoader(_loc4_)).addEventListener(Event.COMPLETE,onComplete);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _loc5_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         _loc5_.load(_loc4_);
      }
      
      public static function sendImpressionEvent(param1:int, param2:int) : void
      {
         var _loc3_:String = "";
         _loc3_ = "http://pixel.goodgamestudios.com/view/" + param1 + "/" + param2;
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         var _loc5_:URLLoader;
         (_loc5_ = new URLLoader(_loc4_)).addEventListener(Event.COMPLETE,onComplete);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _loc5_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         _loc5_.load(_loc4_);
      }
      
      private static function onComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         sendConversion(_loc2_.data.toString());
      }
      
      private static function sendConversion(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:Loader = new Loader();
         _loc3_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _loc3_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         var _loc4_:LoaderContext = new LoaderContext(false,new ApplicationDomain());
         _loc3_.load(_loc2_,_loc4_);
      }
      
      private static function onSecurityError(param1:SecurityErrorEvent) : void
      {
         trace("SecurityError (" + param1.text + ") while loading " + (param1.target as LoaderInfo).url);
      }
      
      private static function onIOError(param1:IOErrorEvent) : void
      {
         trace("IOError (" + param1.text + ") while loading " + (param1.target as LoaderInfo).url);
      }
   }
}
