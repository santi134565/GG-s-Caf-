package com.goodgamestudios.basic
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class EnviromentGlobalsHandler
   {
      
      private static const LOGGER:ILogger = Log.getLogger("EnviromentGlobalsHandler.as");
      
      private static var _globals:IEnvironmentGlobals;
       
      
      public function EnviromentGlobalsHandler()
      {
         super();
      }
      
      public static function get globals() : IEnvironmentGlobals
      {
         if(!_globals)
         {
            LOGGER.fatal("this singleton is not initalized!");
            return null;
         }
         return _globals;
      }
      
      public static function init(param1:Class) : void
      {
         if(!_globals)
         {
            _globals = new param1();
         }
         else
         {
            LOGGER.fatal("this singleton is already initalized");
         }
      }
   }
}
