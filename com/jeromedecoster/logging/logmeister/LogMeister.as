package com.jeromedecoster.logging.logmeister
{
   import com.jeromedecoster.logging.logmeister.connectors.ILogMeisterConnector;
   import com.jeromedecoster.logging.logmeister.connectors.enums.Level;
   import flash.utils.getQualifiedClassName;
   
   public class LogMeister
   {
      
      public static const VERSION:String = "version 1.8.1";
      
      private static var enableDebug:Boolean;
      
      private static var enableInfo:Boolean;
      
      private static var enableWarn:Boolean;
      
      private static var enableError:Boolean;
      
      private static var enableFatal:Boolean;
      
      private static var loggers:Array = [];
       
      
      public function LogMeister()
      {
         super();
      }
      
      private static function forEach(iterable:Object, iterator:Function) : Object
      {
         for each(var _loc3_ in iterable)
         {
            iterator(_loc3_);
         }
         return iterable;
      }
      
      public static function setLevel(level:Level, enable:Boolean) : void
      {
         switch(level)
         {
            case Level.ALL:
               enableDebug = enableError = enableInfo = enableWarn = enableFatal = enable;
               break;
            case Level.DEBUG:
               enableDebug = enable;
               break;
            case Level.ERROR:
               enableError = enable;
               break;
            case Level.INFO:
               enableInfo = enable;
               break;
            case Level.WARN:
               enableWarn = enable;
               break;
            case Level.FATAL:
               enableFatal = enable;
         }
      }
      
      public static function setLevelThreshold(level:Level) : void
      {
         if(level._id > 0)
         {
            enableFatal = true;
         }
         if(level._id > 1)
         {
            enableError = true;
         }
         if(level._id > 2)
         {
            enableWarn = true;
         }
         if(level._id > 3)
         {
            enableInfo = true;
         }
         if(level._id > 4)
         {
            enableDebug = true;
         }
      }
      
      public static function addLogger(logger:ILogMeisterConnector) : void
      {
         for each(var _loc2_ in loggers)
         {
            if(getQualifiedClassName(_loc2_) == getQualifiedClassName(logger))
            {
               return;
            }
         }
         logger.init();
         loggers[loggers.length] = logger;
      }
      
      public static function restart() : void
      {
         for each(var _loc1_ in loggers)
         {
            _loc1_.init();
         }
      }
      
      public static function clearLoggers() : void
      {
         loggers = [];
      }
      
      NSLogMeister static function debug(... rest) : void
      {
         var _loc2_:* = null;
         if(!enableDebug)
         {
            return;
         }
         for each(_loc2_ in loggers)
         {
            _loc2_.sendDebug.apply(null,rest);
         }
      }
      
      NSLogMeister static function info(... rest) : void
      {
         var _loc2_:* = null;
         if(!enableInfo)
         {
            return;
         }
         for each(_loc2_ in loggers)
         {
            _loc2_.sendInfo.apply(null,rest);
         }
      }
      
      NSLogMeister static function warn(... rest) : void
      {
         var _loc2_:* = null;
         if(!enableWarn)
         {
            return;
         }
         for each(_loc2_ in loggers)
         {
            _loc2_.sendWarn.apply(null,rest);
         }
      }
      
      NSLogMeister static function error(... rest) : void
      {
         var _loc2_:* = null;
         if(!enableError)
         {
            return;
         }
         for each(_loc2_ in loggers)
         {
            _loc2_.sendError.apply(null,rest);
         }
      }
      
      NSLogMeister static function fatal(... rest) : void
      {
         var _loc2_:* = null;
         if(!enableFatal)
         {
            return;
         }
         for each(_loc2_ in loggers)
         {
            _loc2_.sendFatal.apply(null,rest);
         }
      }
   }
}
