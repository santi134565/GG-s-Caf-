package com.goodgamestudios.loading
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import org.osflash.signals.Signal;
   
   public final class GoodgameLoader
   {
      
      private static const logger:ILogger = Log.getLogger("GoodgameLoader.as");
       
      
      private var _loaderID:String;
      
      private var _isLoading:Boolean = false;
      
      private var _isComplete:Boolean = false;
      
      private var _loadingQueueFirstTimeFinished:Signal;
      
      private var _loadingQueueFinished:Signal;
      
      private var _loadingQueueElementFinished:Signal;
      
      private var _loadingQueueElementStarted:Signal;
      
      private var _loaderMap:Dictionary;
      
      private var _queue:Vector.<LoaderObject>;
      
      private var _waitTimer:Timer;
      
      private var _loadingStartTime:int;
      
      private var callCount:uint = 0;
      
      public function GoodgameLoader(param1:String, param2:uint = 0)
      {
         this._loadingQueueFirstTimeFinished = new Signal();
         this._loadingQueueFinished = new Signal();
         this._loadingQueueElementFinished = new Signal();
         this._loadingQueueElementStarted = new Signal();
         this._loaderMap = new Dictionary();
         this._queue = new Vector.<LoaderObject>();
         super();
         this._loaderID = param1;
         if(param2 != 0)
         {
            this._waitTimer = new Timer(param2,1);
            this._waitTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.handleWaitTimerComplete);
         }
      }
      
      public function get loaderID() : String
      {
         return this._loaderID;
      }
      
      public function get isLoading() : Boolean
      {
         return this._isLoading;
      }
      
      public function get isComplete() : Boolean
      {
         return this._isComplete;
      }
      
      public function get loadingQueueFirstTimeFinished() : Signal
      {
         return this._loadingQueueFirstTimeFinished;
      }
      
      public function get loadingQueueFinished() : Signal
      {
         return this._loadingQueueFinished;
      }
      
      public function get loadingQueueElementFinished() : Signal
      {
         return this._loadingQueueElementFinished;
      }
      
      public function get loadingQueueElementStarted() : Signal
      {
         return this._loadingQueueElementStarted;
      }
      
      private function handleWaitTimerComplete(param1:TimerEvent) : void
      {
         logger.warn("wait timer for loading queue " + this._loaderID + " " + "finished, will check queue for new downloads");
         var _loc2_:Boolean = this.startLoading();
         if(!this._isLoading)
         {
            if(!_loc2_)
            {
               this._waitTimer.reset();
               this._isComplete = true;
               this._loadingQueueFinished.dispatch(this.loaderID);
               if(this.callCount == 0)
               {
                  logger.debug("GoodgameLoader with id: " + this.loaderID + " has finished for the first time");
                  this._loadingQueueFirstTimeFinished.dispatch(this.loaderID);
               }
               else
               {
                  logger.debug("GoodgameLoader with id: " + this.loaderID + " has finished");
               }
               ++this.callCount;
            }
            else
            {
               logger.debug("GoodgameLoader with id: " + this.loaderID + " has no new elemts to load...aborting handler for wait-timer");
            }
         }
         else
         {
            logger.debug("GoodgameLoader with id: " + this.loaderID + " is actually downloading...aborting handler for wait-timer");
         }
      }
      
      public function addSWFLoader(param1:String, param2:String = "", param3:URLRequest = null, param4:LoaderContext = null, param5:Function = null, param6:Boolean = false) : void
      {
         var _loc7_:Loader = null;
         var _loc8_:LoaderObject = null;
         var _loc9_:LoaderObject = null;
         var _loc10_:Loader = null;
         if(!this._loaderMap[param1] || param6 == true)
         {
            if(this._loaderMap[param1] && param6 == true)
            {
               (_loc10_ = (_loc9_ = this._loaderMap[param1]).loaderInstance as Loader).contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,_loc9_.handleLoaderIOError);
               _loc10_.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc9_.handleLoaderSecurityError);
               _loc10_.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,_loc9_.onLoadProgress);
               _loc10_.contentLoaderInfo.removeEventListener(Event.COMPLETE,_loc9_.onComplete);
               _loc9_.dispose();
            }
            if(param2 == null || param2 == "")
            {
               if(param3 == null)
               {
                  logger.fatal("no url or request was set in SWF-Loader: " + param1);
                  return;
               }
            }
            else
            {
               param3 = new URLRequest(param2);
            }
            if(!param4)
            {
               (param4 = new LoaderContext()).applicationDomain = ApplicationDomain.currentDomain;
            }
            _loc7_ = new Loader();
            (_loc8_ = new LoaderObject(_loc7_,param1,param3,param4,param5)).loaderObjectFinished.add(this.queueElementHasFinished);
            _loc8_.loadingProgressStarted.add(this.queueElementNowLoading);
            _loc7_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,_loc8_.handleLoaderIOError);
            _loc7_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc8_.handleLoaderSecurityError);
            _loc7_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,_loc8_.onLoadProgress);
            _loc7_.contentLoaderInfo.addEventListener(Event.COMPLETE,_loc8_.onComplete);
            this._loaderMap[param1] = _loc8_;
            this._queue.push(_loc8_);
            this.startLoading();
            logger.debug("SWFLoader added: " + param1);
         }
         else
         {
            logger.fatal("loader with name: " + param1 + " already existing");
         }
      }
      
      public function addXMLLoader(param1:String, param2:String, param3:String, param4:Function = null, param5:Boolean = false) : void
      {
         var _loc6_:URLRequest = null;
         var _loc7_:URLLoader = null;
         var _loc8_:LoaderObject = null;
         var _loc9_:LoaderObject = null;
         var _loc10_:URLLoader = null;
         if(!this._loaderMap[param1] || param5 == true)
         {
            if(this._loaderMap[param1] && param5 == true)
            {
               (_loc10_ = (_loc9_ = this._loaderMap[param1]).loaderInstance as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR,_loc9_.handleLoaderIOError);
               _loc10_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc9_.handleLoaderSecurityError);
               _loc10_.removeEventListener(ProgressEvent.PROGRESS,_loc9_.onLoadProgress);
               _loc10_.removeEventListener(Event.COMPLETE,_loc9_.onComplete);
               _loc9_.dispose();
            }
            _loc6_ = new URLRequest(param2);
            (_loc7_ = new URLLoader()).dataFormat = param3;
            (_loc8_ = new LoaderObject(_loc7_,param1,_loc6_,null,param4)).loaderObjectFinished.add(this.queueElementHasFinished);
            _loc8_.loadingProgressStarted.add(this.queueElementNowLoading);
            _loc7_.addEventListener(IOErrorEvent.IO_ERROR,_loc8_.handleLoaderIOError);
            _loc7_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc8_.handleLoaderSecurityError);
            _loc7_.addEventListener(ProgressEvent.PROGRESS,_loc8_.onLoadProgress);
            _loc7_.addEventListener(Event.COMPLETE,_loc8_.onComplete);
            this._loaderMap[param1] = _loc8_;
            this._queue.push(_loc8_);
            this.startLoading();
            logger.debug("XMLLoader added: " + param1);
         }
         else
         {
            logger.fatal("loader with name: " + param1 + " already existing");
         }
      }
      
      public function addLoaderInfoObject(param1:String, param2:LoaderInfo, param3:Function = null) : void
      {
         var _loc4_:LoaderObject = null;
         if(!this._loaderMap[param1])
         {
            (_loc4_ = new LoaderObject(param2,param1,null,null,param3)).loaderObjectFinished.add(this.queueElementHasFinished);
            _loc4_.loadingProgressStarted.add(this.queueElementNowLoading);
            param2.addEventListener(ProgressEvent.PROGRESS,_loc4_.onLoadProgress);
            param2.addEventListener(Event.COMPLETE,_loc4_.onComplete);
            this._loaderMap[param1] = _loc4_;
            this._queue.push(_loc4_);
            this.startLoading();
            logger.debug("LoaderInfo-Object added: " + param1);
         }
         else
         {
            logger.fatal("LoaderInfo-Object with name: " + param1 + " already existing");
         }
      }
      
      public function getLoaderData(param1:String) : Object
      {
         var _loc3_:URLLoader = null;
         var _loc4_:Loader = null;
         var _loc2_:LoaderObject = this._loaderMap[param1];
         if(_loc2_)
         {
            if(_loc2_.currentState == LoaderObject.STATE_LOADING_PROGRESS_FINISHED)
            {
               if(_loc2_.loaderInstance is URLLoader)
               {
                  _loc3_ = _loc2_.loaderInstance as URLLoader;
                  return _loc3_.data;
               }
               if(_loc2_.loaderInstance is Loader)
               {
                  return (_loc4_ = _loc2_.loaderInstance as Loader).contentLoaderInfo.content;
               }
               logger.fatal("unknown error");
               return null;
            }
            logger.fatal("requested loader: " + param1 + " has not finished loading");
            return null;
         }
         logger.fatal("requested loader: " + param1 + " not found");
         return null;
      }
      
      public function getLoaderObject(param1:String) : LoaderObject
      {
         var _loc2_:LoaderObject = this._loaderMap[param1];
         if(_loc2_)
         {
            return _loc2_;
         }
         logger.fatal("requested loader: " + param1 + " not found");
         return null;
      }
      
      public function hasSubloaderFinished(param1:String) : Boolean
      {
         var _loc2_:LoaderObject = this._loaderMap[param1];
         if(_loc2_)
         {
            if(_loc2_.currentState == LoaderObject.STATE_LOADING_PROGRESS_FINISHED)
            {
               return true;
            }
            return false;
         }
         logger.fatal("requested loader: " + param1 + " not found");
         return false;
      }
      
      public function getCompleteProgress() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:LoaderObject = null;
         for each(_loc3_ in this._loaderMap)
         {
            _loc1_ += _loc3_.totalBytes;
            _loc2_ += _loc3_.loadedBytes;
         }
         return _loc2_ / _loc1_;
      }
      
      public function getProgressOfSubloader(param1:String) : Number
      {
         var _loc2_:LoaderObject = this._loaderMap[param1];
         if(_loc2_)
         {
            return _loc2_.loadedBytes / _loc2_.totalBytes;
         }
         logger.fatal("requested loader: " + param1 + " not found");
         return -1;
      }
      
      public function getProgressOfActualSubloader() : Number
      {
         var _loc1_:LoaderObject = null;
         if(this._queue.length > 0)
         {
            _loc1_ = this._queue[0];
            if(_loc1_)
            {
               if(_loc1_.loadedBytes != 0 || _loc1_.totalBytes != 0)
               {
                  return _loc1_.loadedBytes / _loc1_.totalBytes;
               }
               return 0;
            }
            logger.fatal("no subloader loading at the moment");
            return -1;
         }
         return 0;
      }
      
      public function calculateDataRate() : String
      {
         var _loc3_:LoaderObject = null;
         var _loc1_:Number = (getTimer() - this._loadingStartTime) / 1000;
         var _loc2_:Number = 0;
         for each(_loc3_ in this._loaderMap)
         {
            _loc2_ += _loc3_.loadedBytes / 1024;
         }
         return (_loc2_ / _loc1_).toFixed(0);
      }
      
      public function hasSubloader(param1:String) : Boolean
      {
         if(this._loaderMap[param1])
         {
            return true;
         }
         return false;
      }
      
      public function get elementsInQueue() : uint
      {
         return this._queue.length;
      }
      
      public function get elementsAlreadyLoaded() : uint
      {
         var _loc2_:LoaderObject = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this._loaderMap)
         {
            _loc1_++;
         }
         return _loc1_ - this._queue.length;
      }
      
      private function startLoading() : Boolean
      {
         if(!this._isLoading)
         {
            if(this._queue.length > 0)
            {
               if(this.elementsAlreadyLoaded == 0)
               {
                  this._loadingStartTime = getTimer();
               }
               this._queue[0].startLoadingObject();
               return this._isLoading = true;
            }
            return false;
         }
         return false;
      }
      
      private function queueElementNowLoading(param1:String) : void
      {
         this._loadingQueueElementStarted.dispatch(this._loaderID,param1);
      }
      
      private function queueElementHasFinished(param1:String) : void
      {
         var _loc2_:LoaderObject = this._queue.shift();
         var _loc3_:EventDispatcher = EventDispatcher(_loc2_.loaderInstance);
         _loc3_.removeEventListener(IOErrorEvent.IO_ERROR,_loc2_.handleLoaderIOError);
         _loc3_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc2_.handleLoaderSecurityError);
         _loc3_.removeEventListener(ProgressEvent.PROGRESS,_loc2_.onLoadProgress);
         _loc3_.removeEventListener(Event.COMPLETE,_loc2_.onComplete);
         this._loadingQueueElementFinished.dispatch(this._loaderID,param1);
         this._isLoading = false;
         if(this._queue.length > 0)
         {
            this._queue[0].startLoadingObject();
         }
         else if(this._waitTimer)
         {
            this._waitTimer.start();
            logger.warn("wait timer for loading queue " + this._loaderID + " " + "started");
         }
         else
         {
            if(this.callCount == 0)
            {
               logger.debug("GoodgameLoader with id: " + this.loaderID + " has finished for the first time");
               this._loadingQueueFirstTimeFinished.dispatch(this.loaderID);
            }
            else
            {
               logger.debug("GoodgameLoader with id: " + this.loaderID + " has finished");
            }
            ++this.callCount;
         }
      }
   }
}
