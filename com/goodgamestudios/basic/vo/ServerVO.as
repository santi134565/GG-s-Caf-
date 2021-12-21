package com.goodgamestudios.basic.vo
{
   public class ServerVO
   {
       
      
      public var ip:String;
      
      public var port:int;
      
      public var extension:String;
      
      public var defaultLanguage:String;
      
      public var instanceId:int;
      
      public var serverName:String;
      
      public function ServerVO(param1:String, param2:int, param3:String, param4:int = 0, param5:String = "default", param6:String = "")
      {
         super();
         this.ip = param1;
         this.port = param2;
         this.extension = param3;
         this.instanceId = param4;
         this.defaultLanguage = param5;
         this.serverName = param6;
      }
   }
}
