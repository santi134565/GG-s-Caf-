package com.goodgamestudios.abTesting
{
   import com.adobe.serialization.json.JSONDecoder;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Timer;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import org.osflash.signals.Signal;
   
   public class ABTest
   {
      
      private static const LOGGER:ILogger = Log.getLogger("ABTest.as");
      
      private static const TIMEOUT:uint = 2000;
      
      private static const TEST_ID:String = "t";
      
      private static const CASE_ID:String = "c";
      
      private static const CLIENT_ID:String = "ci";
      
      private static const CONTENT:String = "content";
      
      private static const ERROR_MSG:String = "errorMsg ";
      
      private static const IS_VALID:String = "v";
      
      private static const USER_ID:String = "p";
      
      private static const INSTANCE_ID:String = "i";
      
      private static const NETWORK_ID:String = "n";
      
      private static const GAME_ID:String = "g";
       
      
      public var testIsInitalized:Signal;
      
      public var dataRequestTimeoutError:Signal;
      
      private var timeoutTimer:Timer;
      
      private var cookie:SharedObject;
      
      private var loader:URLLoader;
      
      private var _hasError:Boolean;
      
      private var _isReady:Boolean = false;
      
      private var variables:URLVariables;
      
      public function ABTest(param1:int, param2:int, param3:int, param4:int, param5:int)
      {
         this.testIsInitalized = new Signal();
         this.dataRequestTimeoutError = new Signal();
         this.timeoutTimer = new Timer(TIMEOUT,1);
         super();
         this.cookie = SharedObject.getLocal("ABTest_" + param1 + "_" + param2);
         this.cookie.data[TEST_ID] = param1;
         this.cookie.data[GAME_ID] = param2;
         this.cookie.data[INSTANCE_ID] = param3;
         this.cookie.data[NETWORK_ID] = param4;
         this.cookie.data[USER_ID] = param5;
         this.requestDisplayEvent();
      }
      
      public function get hasError() : Boolean
      {
         return this._hasError;
      }
      
      public function get isReady() : Boolean
      {
         return this._isReady;
      }
      
      private function requestDisplayEvent() : void
      {
         this.timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.handleTimeoutTimerComplete);
         this.timeoutTimer.start();
         var _loc1_:URLRequest = new URLRequest("http://splitrun.goodgamestudios.com/request/display");
         _loc1_.method = URLRequestMethod.POST;
         this.variables = new URLVariables();
         this.variables[TEST_ID] = this.cookie.data[TEST_ID];
         this.variables[INSTANCE_ID] = this.cookie.data[INSTANCE_ID];
         this.variables[NETWORK_ID] = this.cookie.data[NETWORK_ID];
         this.variables[GAME_ID] = this.cookie.data[GAME_ID];
         this.variables[USER_ID] = this.cookie.data[USER_ID];
         if(this.cookie.data[CASE_ID] && this.cookie.data[CLIENT_ID])
         {
            this.variables[CASE_ID] = this.cookie.data[CASE_ID];
            this.variables[CLIENT_ID] = this.cookie.data[CLIENT_ID];
         }
         _loc1_.data = this.variables;
         this.loader = new URLLoader();
         this.loader.addEventListener(Event.COMPLETE,this.onDisplayEventComplete);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.loader.load(_loc1_);
      }
      
      private function disposeTimer() : void
      {
         this.timeoutTimer.stop();
         this.timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.handleTimeoutTimerComplete);
         this.timeoutTimer = null;
      }
      
      private function disposeLoader() : void
      {
         this.loader.removeEventListener(Event.COMPLETE,this.onDisplayEventComplete);
         this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.loader.close();
         this.loader = null;
      }
      
      private function onDisplayEventComplete(param1:Event) : void
      {
         this.disposeTimer();
         this.disposeLoader();
         this.parseData(String(URLLoader(param1.target).data));
      }
      
      protected function handleTimeoutTimerComplete(param1:TimerEvent) : void
      {
         this.disposeTimer();
         this.disposeLoader();
         this._hasError = true;
         this.cookie.data[ERROR_MSG] = "timeout for data request";
         this.dataRequestTimeoutError.dispatch();
      }
      
      private function parseData(param1:String) : void
      {
         var _loc2_:JSONDecoder = new JSONDecoder(param1);
         var _loc3_:Object = _loc2_.getValue();
         this.cookie.data[TEST_ID] = _loc3_[TEST_ID];
         this.cookie.data[CASE_ID] = _loc3_[CASE_ID];
         this.cookie.data[ERROR_MSG] = _loc3_[ERROR_MSG];
         this.cookie.data[CLIENT_ID] = _loc3_[CLIENT_ID];
         this.cookie.data[CONTENT] = _loc3_[CONTENT];
         this.cookie.data[IS_VALID] = _loc3_[IS_VALID];
         if(_loc3_[USER_ID])
         {
            this.cookie.data[USER_ID] = _loc3_[USER_ID];
         }
         if(_loc3_[INSTANCE_ID])
         {
            this.cookie.data[INSTANCE_ID] = _loc3_[INSTANCE_ID];
         }
         if(_loc3_[NETWORK_ID])
         {
            this.cookie.data[NETWORK_ID] = _loc3_[NETWORK_ID];
         }
         if(_loc3_[GAME_ID])
         {
            this.cookie.data[GAME_ID] = _loc3_[GAME_ID];
         }
         if(this.cookie.data[ERROR_MSG])
         {
            this._hasError = true;
         }
         else
         {
            this._hasError = false;
         }
         if(this.isValid)
         {
            if(!this._hasError)
            {
               this.testIsInitalized.dispatch();
               this._isReady = true;
               this.cookie.flush();
            }
            else
            {
               LOGGER.fatal(this.errorMessage);
            }
         }
         else
         {
            LOGGER.fatal("ab-test " + this.testID + " is not valid");
         }
      }
      
      private function onConversionEventComplete(param1:Event) : void
      {
         URLLoader(param1.target).removeEventListener(Event.COMPLETE,this.onConversionEventComplete);
         LOGGER.debug("conversion for testcase: " + this.testID + " is complete");
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         LOGGER.fatal("error while connecting to ab-testing interface");
      }
      
      public function sendConversion(param1:int) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         var _loc4_:URLLoader = null;
         if(this._isReady)
         {
            if(!this._hasError)
            {
               _loc2_ = new URLRequest("http://splitrun.goodgamestudios.com/request/track");
               _loc2_.method = URLRequestMethod.POST;
               _loc3_ = new URLVariables();
               _loc3_[TEST_ID] = this.cookie.data[TEST_ID];
               _loc3_[CASE_ID] = this.cookie.data[CASE_ID];
               _loc3_[CLIENT_ID] = this.cookie.data[CLIENT_ID];
               _loc3_[INSTANCE_ID] = this.cookie.data[INSTANCE_ID];
               _loc3_[NETWORK_ID] = this.cookie.data[NETWORK_ID];
               _loc3_[GAME_ID] = this.cookie.data[GAME_ID];
               _loc3_[USER_ID] = param1;
               _loc2_.data = _loc3_;
               (_loc4_ = new URLLoader()).addEventListener(Event.COMPLETE,this.onConversionEventComplete);
               _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
               _loc4_.load(_loc2_);
            }
            else
            {
               LOGGER.fatal(this.errorMessage);
            }
         }
         else
         {
            LOGGER.fatal("cannot send conversion. test is not ready");
         }
      }
      
      public function get testID() : int
      {
         return int(this.cookie.data[TEST_ID]);
      }
      
      public function get testCaseID() : int
      {
         return int(this.cookie.data[CASE_ID]);
      }
      
      public function get contentURL() : String
      {
         if(this.cookie.data[CONTENT])
         {
            return String(this.cookie.data[CONTENT]);
         }
         return null;
      }
      
      public function get errorMessage() : String
      {
         return String(this.cookie.data[ERROR_MSG]);
      }
      
      public function get isValid() : Boolean
      {
         if(this.cookie.data[IS_VALID] == true)
         {
            return true;
         }
         return false;
      }
   }
}
