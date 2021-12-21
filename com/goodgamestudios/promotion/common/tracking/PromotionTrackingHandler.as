package com.goodgamestudios.promotion.common.tracking
{
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class PromotionTrackingHandler
   {
      
      public static const EVENT_ID:int = 42;
      
      private static var _instance:PromotionTrackingHandler;
       
      
      private var originalGameId:int;
      
      private var networkId:int;
      
      private var referrer:String;
      
      private var language:String;
      
      private var promotedGameId:int;
      
      private var selectedGameId:int;
      
      private var _tracked:Boolean;
      
      private var accountId:String;
      
      public function PromotionTrackingHandler()
      {
         super();
      }
      
      public static function get instance() : PromotionTrackingHandler
      {
         if(!_instance)
         {
            _instance = new PromotionTrackingHandler();
         }
         return _instance;
      }
      
      public function init(orginalGameId:int, networkId:int, referrer:String, language:String, promotedGameId:int, selectedGameId:int, accountId:String) : void
      {
         this.originalGameId = orginalGameId;
         this.promotedGameId = promotedGameId;
         this.selectedGameId = selectedGameId;
         this.networkId = networkId;
         this.referrer = referrer;
         this.language = language;
         this.accountId = accountId;
      }
      
      public function track() : void
      {
         if(_tracked)
         {
            return;
         }
         _tracked = true;
         var _loc2_:String = trackerURL;
         var _loc1_:URLRequest = composeTrackingURLRequest(42,_loc2_);
         executeTrackingRequest(_loc1_);
      }
      
      private function composeTrackingURLRequest(eventId:int, url:String) : URLRequest
      {
         var _loc4_:URLRequest = new URLRequest(url);
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.eventId = eventId;
         _loc3_.gameId = originalGameId;
         _loc3_.networkId = networkId;
         _loc3_.lang = language;
         _loc3_.var_1 = accountId;
         _loc3_.var_2 = originalGameId;
         _loc3_.var_3 = promotedGameId;
         _loc3_.var_4 = selectedGameId;
         _loc4_.data = _loc3_;
         _loc4_.method = "POST";
         return _loc4_;
      }
      
      private function executeTrackingRequest(trackingRequest:URLRequest) : void
      {
         var _loc2_:* = null;
         if(!trackingRequest)
         {
            trace("PromotionTrackingHandler, executeTrackingRequest() -> trackingRequest is null.");
            return;
         }
         try
         {
            _loc2_ = new PromotionTrackingLoader(trackingRequest);
         }
         catch(e:Error)
         {
            trace("Fehler beim Erstellen des PromotionTrackingHandler");
         }
      }
      
      protected function get trackerURL() : String
      {
         return "http://f.tracking.goodgamestudios.com/clienttracker.php";
      }
      
      public function get tracked() : Boolean
      {
         return _tracked;
      }
   }
}
