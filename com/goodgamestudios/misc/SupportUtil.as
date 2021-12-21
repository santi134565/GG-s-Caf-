package com.goodgamestudios.misc
{
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class SupportUtil
   {
      
      public static const GGS_SUPPORT_URL:String = "http://support.goodgamestudios.com/";
      
      private static const LOGGER:ILogger = Log.getLogger("SupportUtil.as");
       
      
      public function SupportUtil()
      {
         super();
      }
      
      public static function navigateToSupport(param1:int, param2:int, param3:String, param4:int, param5:String, param6:String, param7:Number, param8:Number, param9:String, param10:String) : void
      {
         var urlRequest:URLRequest = null;
         var vars:URLVariables = null;
         var gameId:int = param1;
         var instanceId:int = param2;
         var versionText:String = param3;
         var networkId:int = param4;
         var gameTitle:String = param5;
         var userName:String = param6;
         var playerId:Number = param7;
         var userId:Number = param8;
         var language:String = param9;
         var referrer:String = param10;
         try
         {
            urlRequest = new URLRequest(GGS_SUPPORT_URL);
            vars = new URLVariables();
            vars["g"] = gameId;
            vars["n"] = networkId;
            vars["i"] = instanceId;
            vars["pid"] = playerId;
            vars["uid"] = userId;
            vars["lang"] = language;
            vars["ref"] = referrer;
            vars["uname"] = userName;
            vars["data"] = "Game-Version: " + versionText + "\n" + "Flash Player - Version:" + Capabilities.version + "\n" + "OS:" + Capabilities.os + "\n" + "Selected Language:" + language + "\n" + "Flashplayer Language:" + Capabilities.language;
            urlRequest.data = vars;
            urlRequest.method = URLRequestMethod.POST;
            navigateToURL(urlRequest,"goodgamestudios");
         }
         catch(e:Error)
         {
            LOGGER.fatal("cannot navigate to support form");
         }
      }
   }
}
