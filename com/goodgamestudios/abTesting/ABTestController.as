package com.goodgamestudios.abTesting
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class ABTestController
   {
      
      private static const LOGGER:ILogger = Log.getLogger("GoodgameABTestController.as");
      
      private static var _instance:ABTestController;
       
      
      private var _instance:ABTestController;
      
      private var enabledTests:Vector.<ABTest>;
      
      public function ABTestController()
      {
         this.enabledTests = new Vector.<ABTest>();
         super();
         if(this._instance)
         {
            throw new Error("this is a singleton. cannot instanciate more than once");
         }
      }
      
      public static function get instance() : ABTestController
      {
         if(!_instance)
         {
            _instance = new ABTestController();
         }
         return _instance;
      }
      
      public function initialize(param1:XML, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc7_:XML = null;
         var _loc8_:int = 0;
         var _loc6_:XMLList = param1.children();
         for each(_loc7_ in _loc6_)
         {
            _loc8_ = int(_loc7_.attribute("id"));
            this.enabledTests.push(new ABTest(_loc8_,param2,param3,param4,param5));
         }
      }
      
      public function getTest(param1:uint) : ABTest
      {
         var _loc2_:int = this.enabledTests.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.enabledTests[_loc3_].testID == param1)
            {
               return this.enabledTests[_loc3_];
            }
            _loc3_++;
         }
         LOGGER.fatal("no test with id " + param1 + " available");
         return null;
      }
      
      public function trackConversion(param1:int, param2:int) : void
      {
         var _loc3_:int = this.enabledTests.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.enabledTests[_loc4_].testID == param1)
            {
               if(this.enabledTests[_loc4_].isValid)
               {
                  this.enabledTests[_loc4_].sendConversion(param2);
               }
               else
               {
                  LOGGER.warn("ab-test with id: " + param1 + " is not valid");
               }
            }
            _loc4_++;
         }
      }
   }
}
