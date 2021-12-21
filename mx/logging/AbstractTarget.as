package mx.logging
{
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   import mx.logging.errors.InvalidFilterError;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.utils.UIDUtil;
   
   use namespace mx_internal;
   
   public class AbstractTarget implements ILoggingTarget, IMXMLObject
   {
      
      mx_internal static const VERSION:String = "4.0.0.14159";
       
      
      private var _loggerCount:uint = 0;
      
      private var resourceManager:IResourceManager;
      
      private var _filters:Array;
      
      private var _id:String;
      
      private var _level:int = 0;
      
      public function AbstractTarget()
      {
         this.resourceManager = ResourceManager.getInstance();
         this._filters = ["*"];
         super();
         this._id = UIDUtil.createUID();
      }
      
      public function get filters() : Array
      {
         return this._filters;
      }
      
      public function set filters(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         if(param1 && param1.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc2_ = param1[_loc5_];
               if(Log.hasIllegalCharacters(_loc2_))
               {
                  _loc4_ = this.resourceManager.getString("logging","charsInvalid",[_loc2_]);
                  throw new InvalidFilterError(_loc4_);
               }
               _loc3_ = _loc2_.indexOf("*");
               if(_loc3_ >= 0 && _loc3_ != _loc2_.length - 1)
               {
                  _loc4_ = this.resourceManager.getString("logging","charPlacement",[_loc2_]);
                  throw new InvalidFilterError(_loc4_);
               }
               _loc5_++;
            }
         }
         else
         {
            param1 = ["*"];
         }
         if(this._loggerCount > 0)
         {
            Log.removeTarget(this);
            this._filters = param1;
            Log.addTarget(this);
         }
         else
         {
            this._filters = param1;
         }
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         Log.removeTarget(this);
         this._level = param1;
         Log.addTarget(this);
      }
      
      public function addLogger(param1:ILogger) : void
      {
         if(param1)
         {
            ++this._loggerCount;
            param1.addEventListener(LogEvent.LOG,this.logHandler);
         }
      }
      
      public function removeLogger(param1:ILogger) : void
      {
         if(param1)
         {
            --this._loggerCount;
            param1.removeEventListener(LogEvent.LOG,this.logHandler);
         }
      }
      
      public function initialized(param1:Object, param2:String) : void
      {
         this._id = param2;
         Log.addTarget(this);
      }
      
      public function logEvent(param1:LogEvent) : void
      {
      }
      
      private function logHandler(param1:LogEvent) : void
      {
         if(param1.level >= this.level)
         {
            this.logEvent(param1);
         }
      }
   }
}
