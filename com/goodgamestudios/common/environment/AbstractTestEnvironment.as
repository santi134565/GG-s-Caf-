package com.goodgamestudios.common.environment
{
   public class AbstractTestEnvironment extends AbstractEnvironment implements IEnvironment
   {
      
      public static const NAME:String = "TEST";
       
      
      public function AbstractTestEnvironment()
      {
         super();
      }
      
      override public function get name() : String
      {
         return "TEST";
      }
      
      public function get serverUrl() : String
      {
         return "http://filetest.ggs-hh.net";
      }
   }
}
