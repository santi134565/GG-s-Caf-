package com.goodgamestudios.common.environment
{
   public class AbstractLocalEnvironment extends AbstractEnvironment implements IEnvironment
   {
      
      public static const NAME:String = "LOCAL";
       
      
      public function AbstractLocalEnvironment()
      {
         super();
      }
      
      override public function get name() : String
      {
         return "LOCAL";
      }
      
      public function get serverUrl() : String
      {
         return "";
      }
   }
}
