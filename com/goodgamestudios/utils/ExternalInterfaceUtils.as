package com.goodgamestudios.utils
{
   import flash.events.Event;
   import flash.external.ExternalInterface;
   
   public class ExternalInterfaceUtils
   {
       
      
      public function ExternalInterfaceUtils()
      {
         super();
      }
      
      public static function addWindowEventCallback(param1:String, param2:Function) : void
      {
         var windowEvent:String = param1;
         var callbackFunction:Function = param2;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback("informFlash",callbackFunction);
               ExternalInterface.call("function(){ window." + windowEvent + " = function () { " + "var result = document.getElementsByName(\'" + ExternalInterface.objectID + "\')[0].informFlash();" + "return result;" + " } } ()");
            }
            catch(e:Error)
            {
               trace("Adding javascript close callback failed!");
            }
         }
      }
      
      public static function addLanguageCallback(param1:Function) : void
      {
         var languageCallbackFunction:Function = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback("getLanguage",languageCallbackFunction);
            }
            catch(e:Error)
            {
               trace("Adding javascript close callback failed!");
            }
         }
      }
      
      public static function getUrlVariables() : Object
      {
         var result:Object = null;
         var key:String = null;
         if(ExternalInterface.available)
         {
            try
            {
               result = ExternalInterface.call("function(){ var map = {};" + "var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {" + "\tmap[key] = value;" + "});" + "return map;" + "}");
            }
            catch(e:Error)
            {
               trace("Getting url variables from javascript failed!");
            }
         }
         for(key in result)
         {
            result[key] = decodeURI(result[key]);
         }
         return result;
      }
      
      public static function loadJsLibrary(param1:String) : void
      {
         var url:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("function(){ var body = document.body;" + "var script = document.createElement(\'script\');" + "var src = document.createAttribute(\'src\');" + "src.nodeValue = \'" + url + "\';" + "var type = document.createAttribute(\'type\');" + "type.nodeValue = \'text/javascript\';" + "var language = document.createAttribute(\'language\');" + "language.nodeValue = \'javascript\';" + "script.setAttributeNode(src);" + "script.setAttributeNode(type);" + "script.setAttributeNode(language);" + "body.appendChild(script);" + "}");
            }
            catch(e:Error)
            {
               trace("Loading javascript library (" + url + ") failed!");
            }
         }
      }
      
      public static function addDivElement(param1:String) : void
      {
         var id:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("function(){ var body = document.body;" + "var div = document.createElement(\'div\');" + "var id = document.createAttribute(\'id\');" + "id.nodeValue = \'" + id + "\';" + "div.setAttributeNode(id);" + "body.appendChild(div);" + "}");
            }
            catch(e:Error)
            {
               trace("Adding div element (" + id + ") failed!");
            }
         }
      }
      
      public static function addJsVars(param1:Object) : void
      {
         var functionString:String = null;
         var key:String = null;
         var vars:Object = param1;
         if(ExternalInterface.available)
         {
            try
            {
               functionString = "function(){";
               for(key in vars)
               {
                  functionString += "window." + key + " = " + (vars[key] is String ? "\'" + vars[key] + "\';" : vars[key] + ";");
               }
               functionString += "}";
               ExternalInterface.call(functionString);
            }
            catch(e:Error)
            {
               trace("Adding javascript vars failed! Error: " + e.message);
            }
         }
      }
      
      public static function reloadPage(param1:Event = null) : void
      {
         var e:Event = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("location.reload");
            }
            catch(e:Error)
            {
               trace("Reloading page failed!");
            }
         }
      }
   }
}
