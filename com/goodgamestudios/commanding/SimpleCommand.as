package com.goodgamestudios.commanding
{
   public class SimpleCommand implements ISimpleCommand
   {
       
      
      private var _executed:Boolean = false;
      
      private var _singleExecution:Boolean = false;
      
      private var _commandReceiver:Vector.<ICommandReceiver>;
      
      public function SimpleCommand(param1:Boolean = false)
      {
         this._commandReceiver = new Vector.<ICommandReceiver>();
         super();
         this._singleExecution = param1;
      }
      
      public function get executed() : Boolean
      {
         return this._executed;
      }
      
      public function set executed(param1:Boolean) : void
      {
         this._executed = param1;
      }
      
      public function get singleExecution() : Boolean
      {
         return this._singleExecution;
      }
      
      public function set singleExecution(param1:Boolean) : void
      {
         this._singleExecution = param1;
      }
      
      public function get commandReceiver() : Vector.<ICommandReceiver>
      {
         return this._commandReceiver;
      }
      
      public function execute(param1:Object = null) : void
      {
      }
      
      public function addReceiver(param1:ICommandReceiver) : void
      {
         this._commandReceiver.push(param1);
      }
      
      public function removeReceiver(param1:ICommandReceiver) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._commandReceiver.length)
         {
            if(this._commandReceiver[_loc2_] == param1)
            {
               this._commandReceiver.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      public function removeAllReceiver() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._commandReceiver.length)
         {
            this._commandReceiver[_loc1_] = null;
            _loc1_++;
         }
      }
   }
}
