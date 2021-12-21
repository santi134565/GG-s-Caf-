package com.goodgamestudios.loading
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import org.osflash.signals.Signal;
   
   public final class LoaderObject
   {
      
      public static const STATE_IDLE:int = 1;
      
      public static const STATE_LOADING_PROGRESS_INITIATED:int = 2;
      
      public static const STATE_LOADING_PROGRESS_STARTED:int = 3;
      
      public static const STATE_LOADING_PROGRESS_FINISHED:int = 4;
      
      private static const logger:ILogger = Log.getLogger("LoaderObject.as");
       
      
      private var _currentState:int;
      
      private var _loaderName:String;
      
      private var _loaderInstance:Object;
      
      private var _totalBytes:int;
      
      private var _loadedBytes:int;
      
      var loaderObjectFinished:Signal;
      
      var loadingProgressStarted:Signal;
      
      private var _request:URLRequest;
      
      private var _onCompleteCallback:Function;
      
      private var _loaderContext:LoaderContext;
      
      public function LoaderObject(param1:Object, param2:String, param3:URLRequest, param4:LoaderContext, param5:Function = null)
      {
         this.loaderObjectFinished = new Signal();
         this.loadingProgressStarted = new Signal();
         super();
         this._loaderInstance = param1;
         this._loaderName = param2;
         this._request = param3;
         this._loaderContext = param4;
         this._onCompleteCallback = param5;
         this._currentState = STATE_IDLE;
      }
      
      public function get currentState() : int
      {
         return this._currentState;
      }
      
      public function get loaderName() : String
      {
         return this._loaderName;
      }
      
      public function get loaderInstance() : Object
      {
         return this._loaderInstance;
      }
      
      public function get totalBytes() : int
      {
         if(this._currentState == STATE_LOADING_PROGRESS_STARTED || this._currentState == STATE_LOADING_PROGRESS_FINISHED)
         {
            return this._totalBytes;
         }
         return 0;
      }
      
      public function get loadedBytes() : int
      {
         if(this._currentState == STATE_LOADING_PROGRESS_STARTED || this._currentState == STATE_LOADING_PROGRESS_FINISHED)
         {
            return this._loadedBytes;
         }
         return 0;
      }
      
      public function dispose() : void
      {
         logger.warn("start disposing loader-object " + this._loaderName);
         this.loaderObjectFinished.removeAll();
         this.loadingProgressStarted.removeAll();
         this._onCompleteCallback = null;
      }
      
      function startLoadingObject() : void
      {
         if(this._loaderInstance is Loader)
         {
            Loader(this._loaderInstance).load(this._request,this._loaderContext);
         }
         else if(this._loaderInstance is URLLoader)
         {
            URLLoader(this._loaderInstance).load(this._request);
         }
         else if(this._loaderInstance is LoaderInfo)
         {
         }
      }
      
      function onLoadProgress(param1:ProgressEvent) : void
      {
         this._totalBytes = param1.bytesTotal;
         this._loadedBytes = param1.bytesLoaded;
         switch(this._currentState)
         {
            case STATE_IDLE:
               this._currentState = STATE_LOADING_PROGRESS_INITIATED;
               break;
            case STATE_LOADING_PROGRESS_INITIATED:
               this._currentState = STATE_LOADING_PROGRESS_STARTED;
               this.loadingProgressStarted.dispatch(this._loaderName);
         }
      }
      
      function handleLoaderSecurityError(param1:SecurityErrorEvent) : void
      {
         logger.fatal(param1.text);
      }
      
      function handleLoaderIOError(param1:IOErrorEvent) : void
      {
         logger.fatal(param1.text);
      }
      
      function onComplete(param1:Event) : void
      {
         logger.debug("loader: " + this._loaderName + " has finished");
         this._currentState = STATE_LOADING_PROGRESS_FINISHED;
         this.loadingProgressStarted.dispatch(this._loaderName);
         this.loaderObjectFinished.dispatch(this._loaderName);
         if(this._onCompleteCallback != null)
         {
            this._onCompleteCallback();
         }
      }
   }
}
