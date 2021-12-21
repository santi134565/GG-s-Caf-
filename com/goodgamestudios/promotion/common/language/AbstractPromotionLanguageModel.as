package com.goodgamestudios.promotion.common.language
{
   import flash.utils.Dictionary;
   
   public class AbstractPromotionLanguageModel
   {
       
      
      public var onLoadLanguageComplete:Function;
      
      protected var _languageDict:Dictionary;
      
      protected var _fontName:String;
      
      public function AbstractPromotionLanguageModel()
      {
         super();
      }
      
      public function loadLanguage() : void
      {
      }
      
      public function loadFonts() : void
      {
      }
      
      public function getTextById(id:String, params:Object = null) : String
      {
         return "";
      }
      
      public function get fontName() : String
      {
         return _fontName;
      }
   }
}
