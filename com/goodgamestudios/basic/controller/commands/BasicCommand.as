package com.goodgamestudios.basic.controller.commands
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   
   public class BasicCommand
   {
       
      
      public function BasicCommand()
      {
         super();
      }
      
      public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:* = param1;
         switch(0)
         {
         }
         return true;
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
      
      protected function get nomoneyId() : String
      {
         return "error_nomoney_copy";
      }
      
      protected function get cmdId() : String
      {
         return "";
      }
   }
}
