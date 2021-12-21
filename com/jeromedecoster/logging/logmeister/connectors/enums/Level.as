package com.jeromedecoster.logging.logmeister.connectors.enums
{
   public class Level
   {
      
      public static const DEBUG:Level = new Level("debug",5);
      
      public static const INFO:Level = new Level("info",4);
      
      public static const WARN:Level = new Level("warn",3);
      
      public static const ERROR:Level = new Level("error",2);
      
      public static const FATAL:Level = new Level("fatal",1);
      
      public static const ALL:Level = new Level("all",6);
      
      public static const NONE:Level = new Level("none",0);
       
      
      private var _name:String;
      
      public var _id:uint;
      
      public function Level(name:String, id:uint)
      {
         super();
         _name = name;
         _id = id;
      }
      
      public static function getByName(name:String) : Level
      {
         if(name == "all")
         {
            return ALL;
         }
         if(name == "debug")
         {
            return DEBUG;
         }
         if(name == "error")
         {
            return ERROR;
         }
         if(name == "info")
         {
            return INFO;
         }
         if(name == "warn")
         {
            return WARN;
         }
         if(name == "fatal")
         {
            return FATAL;
         }
         return NONE;
      }
      
      public function toString() : String
      {
         return "[Level name=" + name + "]";
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}
