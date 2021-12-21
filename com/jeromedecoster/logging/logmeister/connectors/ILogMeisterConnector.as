package com.jeromedecoster.logging.logmeister.connectors
{
   public interface ILogMeisterConnector
   {
       
      
      function init() : void;
      
      function sendDebug(... rest) : void;
      
      function sendInfo(... rest) : void;
      
      function sendWarn(... rest) : void;
      
      function sendError(... rest) : void;
      
      function sendFatal(... rest) : void;
      
      function get format() : String;
      
      function set format(value:String) : void;
   }
}
