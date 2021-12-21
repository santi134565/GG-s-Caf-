package com.goodgamestudios.tracking
{
   import com.goodgamestudios.utils.DictionaryUtil;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class TrackingCache
   {
      
      private static var trackingCache:TrackingCache;
       
      
      protected var gameId:int = 0;
      
      protected var referrer:String = "";
      
      protected var accountId:String = "";
      
      protected var networkId:int = 0;
      
      protected var distributorId:int = 0;
      
      protected var language:String = "";
      
      protected var _instanceId:int = 0;
      
      protected var _isInitialized:Boolean = false;
      
      protected var currentCache:Dictionary;
      
      public function TrackingCache()
      {
         super();
         this.currentCache = new Dictionary();
      }
      
      public static function getInstance() : TrackingCache
      {
         if(!trackingCache)
         {
            trackingCache = new TrackingCache();
         }
         return trackingCache;
      }
      
      public function init(param1:int, param2:int, param3:String, param4:String, param5:String) : void
      {
         this.gameId = param1;
         this.networkId = param2;
         this.referrer = param3;
         this.language = param4;
         this.accountId = param5;
         this.currentCache[ImpressionTrackingEvent.EVENT_ID] = new ImpressionTrackingEvent(param3);
         this.currentCache[ConnectionTrackingEvent.EVENT_ID] = new ConnectionTrackingEvent(param3);
         this.currentCache[FirstInstanceTrackingEvent.EVENT_ID] = new FirstInstanceTrackingEvent(param3);
         this._isInitialized = true;
      }
      
      public function registerEvent(param1:int, param2:Class) : BasicTrackingEvent
      {
         this.currentCache[param1] = new param2(this.referrer);
         return this.currentCache[param1] as BasicTrackingEvent;
      }
      
      public function getEvent(param1:int) : BasicTrackingEvent
      {
         return this.currentCache[param1];
      }
      
      public function sendEvent(param1:int) : void
      {
         var _loc4_:URLVariables = null;
         var _loc5_:URLLoader = null;
         if(!this.isInitialized || !this.currentCache || DictionaryUtil.getKeys(this.currentCache).length == 0)
         {
            return;
         }
         var _loc2_:URLRequest = new URLRequest(this.trackerURL);
         var _loc3_:BasicTrackingEvent = this.currentCache[param1] as BasicTrackingEvent;
         (_loc4_ = _loc3_.getVars()).eventId = param1;
         _loc4_.gameId = this.gameId;
         _loc4_.networkId = this.networkId;
         _loc4_.accountId = this.accountId;
         _loc4_.instanceId = this._instanceId;
         _loc4_.lang = this.language;
         _loc2_.data = _loc4_;
         _loc2_.method = URLRequestMethod.POST;
         (_loc5_ = new URLLoader()).addEventListener(IOErrorEvent.IO_ERROR,this.onCountIOError);
         _loc5_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onCountSecurityError);
         _loc5_.load(_loc2_);
      }
      
      public function get instanceId() : int
      {
         return this._instanceId;
      }
      
      public function set instanceId(param1:int) : void
      {
         this._instanceId = param1;
      }
      
      public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      private function onCountSecurityError(param1:SecurityErrorEvent) : void
      {
         throw new Error("SecurityError (" + param1.text + ") while calling tracking php (" + this.trackerURL + ")!");
      }
      
      private function onCountIOError(param1:IOErrorEvent) : void
      {
         throw new Error("IOError (" + param1.text + ") while calling tracking php (" + this.trackerURL + ")!");
      }
      
      protected function get trackerURL() : String
      {
         return "http://tracking.localhost/clienttracker.php";
      }
   }
}
