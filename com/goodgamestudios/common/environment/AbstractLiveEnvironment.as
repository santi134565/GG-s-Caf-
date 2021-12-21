package com.goodgamestudios.common.environment
{
   public class AbstractLiveEnvironment extends AbstractEnvironment implements IEnvironment
   {
      
      public static const NAME:String = "LIVE";
       
      
      public function AbstractLiveEnvironment()
      {
         super();
      }
      
      override public function get name() : String
      {
         return "LIVE";
      }
      
      public function get serverUrl() : String
      {
         return "http://data.goodgamestudios.com";
      }
   }
}
