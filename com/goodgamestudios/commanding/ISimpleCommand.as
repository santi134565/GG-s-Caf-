package com.goodgamestudios.commanding
{
   public interface ISimpleCommand
   {
       
      
      function execute(param1:Object = null) : void;
      
      function set executed(param1:Boolean) : void;
      
      function get executed() : Boolean;
      
      function get singleExecution() : Boolean;
      
      function set singleExecution(param1:Boolean) : void;
      
      function addReceiver(param1:ICommandReceiver) : void;
      
      function removeReceiver(param1:ICommandReceiver) : void;
      
      function removeAllReceiver() : void;
      
      function get commandReceiver() : Vector.<ICommandReceiver>;
   }
}
