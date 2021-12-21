package com.goodgamestudios.commanding
{
   import flash.utils.Dictionary;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class CommandController
   {
      
      private static const LOGGER:ILogger = Log.getLogger("CommandController.as");
      
      private static var _instance:CommandController;
       
      
      private var commandMap:Dictionary;
      
      public function CommandController()
      {
         this.commandMap = new Dictionary();
         super();
         if(_instance)
         {
            throw new Error("this is a singleton. cannot instanciate more than once");
         }
      }
      
      public static function get instance() : CommandController
      {
         if(!_instance)
         {
            _instance = new CommandController();
         }
         return _instance;
      }
      
      public function registerCommand(param1:String, param2:Class, param3:ICommandReceiver = null, param4:Boolean = false) : void
      {
         var _loc5_:ISimpleCommand;
         if(_loc5_ = this.commandMap[param1])
         {
            _loc5_.removeAllReceiver();
         }
         _loc5_ = new param2();
         this.commandMap[param1] = _loc5_;
         _loc5_.singleExecution = param4;
         if(param3)
         {
            _loc5_.addReceiver(param3);
         }
      }
      
      public function addReceiverToCommand(param1:ICommandReceiver, param2:String) : void
      {
         var _loc3_:ISimpleCommand = this.commandMap[param2];
         if(_loc3_)
         {
            _loc3_.addReceiver(param1);
         }
         else
         {
            LOGGER.fatal("cannot add commandreceiver to non existing command");
         }
      }
      
      public function removeReceiverFromCommand(param1:ICommandReceiver, param2:String) : void
      {
         var _loc3_:ISimpleCommand = this.commandMap[param2];
         if(_loc3_)
         {
            _loc3_.removeReceiver(param1);
         }
         else
         {
            LOGGER.fatal("cannot remove commandreceiver from non existing command");
         }
      }
      
      public function executeCommand(param1:String, param2:Object = null) : void
      {
         var _loc3_:ISimpleCommand = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this.commandMap[param1])
         {
            _loc3_ = this.commandMap[param1];
            if(_loc3_.executed && _loc3_.singleExecution)
            {
               LOGGER.warn(param1 + " was already executed");
            }
            else
            {
               _loc3_.execute(param2);
               _loc4_ = _loc3_.commandReceiver.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc3_.commandReceiver[_loc5_].handleCommand(param1,param2);
                  _loc5_++;
               }
               _loc3_.executed = true;
            }
         }
         else
         {
            LOGGER.fatal(param1 + " has no instance in commandmap");
         }
      }
      
      public function getExecFunctionFromCommand(param1:String) : Function
      {
         var _loc2_:ISimpleCommand = null;
         var _loc3_:* = null;
         for(_loc3_ in this.commandMap)
         {
            if(param1 == _loc3_)
            {
               if(this.commandMap[_loc3_])
               {
                  _loc2_ = this.commandMap[_loc3_];
                  return _loc2_.execute;
               }
               LOGGER.fatal(param1 + "has no instance in commandmap");
               return null;
            }
         }
         LOGGER.fatal(param1 + "unknown error while retrieving execute function from command");
         return null;
      }
   }
}
