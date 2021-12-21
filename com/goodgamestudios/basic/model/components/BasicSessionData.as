package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.BasicConstants;
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.utils.DictionaryUtil;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class BasicSessionData extends EventDispatcher
   {
       
      
      protected var _currentEvents:Array;
      
      protected var _loggedinTimer:Timer;
      
      protected var _loggedinTime:Number;
      
      protected var _loggedinTimeMsgId:int;
      
      protected var _sessionTimerDict:Dictionary;
      
      public function BasicSessionData()
      {
         this._currentEvents = [0];
         super();
      }
      
      public function get currentEvents() : Array
      {
         return this._currentEvents;
      }
      
      public function set currentEvents(param1:Array) : void
      {
         this._currentEvents = param1;
      }
      
      public function isEventActive(param1:String) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in this._currentEvents)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function initLoggedinTime(param1:Number, param2:Number = 60000) : void
      {
         this._loggedinTime = param1;
         this._loggedinTimeMsgId = this._loggedinTime * 60000 / param2;
         this.resetLoggedinTimer();
         this._loggedinTimer = new Timer(param2,1);
         this._loggedinTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onLoggedinMessageTimerComplete);
         this._loggedinTimer.start();
      }
      
      public function resetLoggedinTimer() : void
      {
         if(this._loggedinTimer)
         {
            this._loggedinTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onLoggedinMessageTimerComplete);
         }
      }
      
      protected function onLoggedinMessageTimerComplete(param1:TimerEvent) : void
      {
         this._loggedinTimer.reset();
         this._loggedinTime += BasicConstants.LOGGEDIN_MESSAGE_TIME_INTERVAL;
         ++this._loggedinTimeMsgId;
         var _loc2_:String = BasicModel.languageData.getTextById("alert_logintimemsg_title_" + this._loggedinTimeMsgId);
         var _loc3_:String = BasicModel.languageData.getTextById("alert_logintimemsg_copy_" + this._loggedinTimeMsgId);
         if(_loc2_.length > 0 && _loc3_.length > 0)
         {
            dispatchEvent(new BasicUserEvent(BasicUserEvent.LOGGEDIN_TIME_INTERVAL,[_loc2_,_loc3_]));
         }
         this._loggedinTimer.start();
      }
      
      public function initSessionTime(param1:Number, param2:String) : void
      {
         if(this._sessionTimerDict == null)
         {
            this._sessionTimerDict = new Dictionary();
         }
         var _loc3_:Timer = new Timer(param1,1);
         _loc3_.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSessionTimerComplete);
         this._sessionTimerDict[param2] = _loc3_;
         _loc3_.start();
      }
      
      public function resetSessionTimer() : void
      {
         var _loc1_:Timer = null;
         if(this._sessionTimerDict)
         {
            for each(_loc1_ in this._sessionTimerDict)
            {
               _loc1_.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onSessionTimerComplete);
            }
         }
      }
      
      public function isSessionTimerById(param1:String, param2:Timer) : Boolean
      {
         if(DictionaryUtil.containsKey(this._sessionTimerDict,param1))
         {
            if(this._sessionTimerDict[param1] == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function onSessionTimerComplete(param1:TimerEvent) : void
      {
         param1.target.reset();
      }
   }
}
