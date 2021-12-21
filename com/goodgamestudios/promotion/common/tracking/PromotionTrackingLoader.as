package com.goodgamestudios.promotion.common.tracking
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public final class PromotionTrackingLoader
   {
       
      
      private var reqLoader:URLLoader;
      
      private var request:URLRequest;
      
      public function PromotionTrackingLoader(req:URLRequest)
      {
         super();
         request = req;
         reqLoader = new URLLoader();
         reqLoader.addEventListener("ioError",onIOError);
         reqLoader.addEventListener("securityError",onCountSecurityError);
         reqLoader.addEventListener("complete",handleTrackingComplete);
         reqLoader.addEventListener("httpStatus",onHTTPStatus);
         reqLoader.load(request);
      }
      
      private function onCountSecurityError(event:SecurityErrorEvent) : void
      {
         dispose();
      }
      
      private function onIOError(event:IOErrorEvent) : void
      {
         dispose();
      }
      
      private function onHTTPStatus(event:HTTPStatusEvent) : void
      {
         var _loc2_:int = event.status / 100;
         if(_loc2_ != 2 && _loc2_ != 3)
         {
            dispose();
         }
      }
      
      private function handleTrackingComplete(event:Event) : void
      {
         dispose();
      }
      
      private function dispose() : void
      {
         reqLoader.removeEventListener("ioError",onIOError);
         reqLoader.removeEventListener("securityError",onCountSecurityError);
         reqLoader.removeEventListener("complete",handleTrackingComplete);
         reqLoader.removeEventListener("httpStatus",onHTTPStatus);
      }
   }
}
