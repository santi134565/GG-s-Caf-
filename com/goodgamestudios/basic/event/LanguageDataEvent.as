package com.goodgamestudios.basic.event
{
   import flash.events.Event;
   
   public class LanguageDataEvent extends Event
   {
      
      public static const XML_LOAD_COMPLETE:String = "xml_load_complete";
      
      public static const FONT_LOAD_COMPLETE:String = "font_load_complete";
      
      public static const SELECT_LANGUAGE_COMPLETE:String = "selectlanguage_complete";
       
      
      public var selectedLanguage:String;
      
      public function LanguageDataEvent(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false)
      {
         this.selectedLanguage = param2;
         super(param1,param3,param4);
      }
   }
}
