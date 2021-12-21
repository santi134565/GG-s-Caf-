package com.soenkerohde.logging
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.XMLSocket;
   import mx.core.mx_internal;
   import mx.logging.ILogger;
   import mx.logging.LogEvent;
   import mx.logging.LogEventLevel;
   import mx.logging.targets.LineFormattedTarget;
   
   use namespace mx_internal;
   
   public class SOSLoggingTarget extends LineFormattedTarget
   {
       
      
      private var socket:XMLSocket;
      
      private var history:Array;
      
      public var server:String = "localhost";
      
      public function SOSLoggingTarget()
      {
         super();
         this.socket = new XMLSocket();
         this.history = new Array();
         includeCategory = true;
         includeTime = true;
         includeLevel = true;
      }
      
      override public function logEvent(param1:LogEvent) : void
      {
         var _loc3_:Date = null;
         var _loc2_:Object = {"message":param1.message};
         if(includeDate || includeTime)
         {
            _loc3_ = new Date();
            if(includeDate)
            {
               _loc2_.date = Number(_loc3_.getMonth() + 1).toString() + "/" + _loc3_.getDate().toString() + "/" + _loc3_.getFullYear();
            }
            if(includeTime)
            {
               _loc2_.time = this.padTime(_loc3_.getHours()) + ":" + this.padTime(_loc3_.getMinutes()) + ":" + this.padTime(_loc3_.getSeconds()) + "." + this.padTime(_loc3_.getMilliseconds(),true);
            }
         }
         if(includeLevel)
         {
            _loc2_.level = param1.level;
         }
         _loc2_.category = !!includeCategory ? ILogger(param1.target).category : "";
         if(this.socket.connected)
         {
            this.send(_loc2_);
         }
         else
         {
            if(!this.socket.hasEventListener("connect"))
            {
               this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
               this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
               this.socket.addEventListener(Event.CONNECT,this.onConnect);
            }
            this.socket.connect(this.server,4444);
            this.history.push(_loc2_);
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         trace("XMLSocket IOError");
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         trace("XMLSocket SecurityError");
      }
      
      private function onConnect(param1:Event) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.history)
         {
            this.send(_loc2_);
         }
      }
      
      private function send(param1:Object) : void
      {
         var _loc7_:String = null;
         var _loc2_:String = param1.message;
         var _loc3_:Array = _loc2_.split("\n");
         var _loc4_:String = _loc3_.length == 1 ? "showMessage" : "showFoldMessage";
         var _loc5_:String = this.getTypeByLogLevel(param1.level);
         var _loc6_:XML = new XML("<" + _loc4_ + " key=\"" + ({_loc5_}) + "\"/>");
         if(_loc3_.length > 1)
         {
            _loc6_.title = _loc3_[0];
            _loc6_.message = _loc2_.substr(_loc2_.indexOf("\n") + 1,_loc2_.length);
            if(param1.date == null)
            {
               _loc6_.data = param1.data;
            }
            if(param1.time == null)
            {
               _loc6_.time = param1.time;
            }
            if(param1.category == null)
            {
               _loc6_.category = param1.category;
            }
         }
         else
         {
            _loc7_ = "";
            if(param1.date != null)
            {
               _loc7_ += param1.date + fieldSeparator;
            }
            if(param1.time != null)
            {
               _loc7_ += param1.time + fieldSeparator;
            }
            if(param1.category != null)
            {
               _loc7_ += param1.category + fieldSeparator;
            }
            _loc6_.appendChild(_loc7_ + _loc2_);
         }
         this.socket.send("!SOS" + _loc6_.toXMLString() + "\n");
      }
      
      private function getTypeByLogLevel(param1:int) : String
      {
         switch(param1)
         {
            case LogEventLevel.DEBUG:
               return "DEBUG";
            case LogEventLevel.INFO:
               return "INFO";
            case LogEventLevel.WARN:
               return "WARN";
            case LogEventLevel.ERROR:
               return "ERROR";
            case LogEventLevel.FATAL:
               return "FATAL";
            default:
               return "INFO";
         }
      }
      
      private function padTime(param1:Number, param2:Boolean = false) : String
      {
         if(param2)
         {
            if(param1 < 10)
            {
               return "00" + param1.toString();
            }
            if(param1 < 100)
            {
               return "0" + param1.toString();
            }
            return param1.toString();
         }
         return param1 > 9 ? param1.toString() : "0" + param1.toString();
      }
      
      override mx_internal function internalLog(param1:String) : void
      {
      }
   }
}
