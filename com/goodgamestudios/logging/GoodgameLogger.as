package com.goodgamestudios.logging
{
   import com.soenkerohde.logging.SOSLoggingTarget;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public final class GoodgameLogger extends SOSLoggingTarget
   {
      
      private static const logger:ILogger = Log.getLogger("GoodgameLogger");
       
      
      public function GoodgameLogger(param1:Boolean = false, param2:Boolean = true)
      {
         super();
         var _loc3_:SOSLoggingTarget = new SOSLoggingTarget();
         _loc3_.includeDate = param1;
         _loc3_.includeTime = param2;
         Log.addTarget(_loc3_);
         logger.debug("logger is working");
      }
   }
}
