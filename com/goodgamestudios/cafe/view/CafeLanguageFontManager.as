package com.goodgamestudios.cafe.view
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class CafeLanguageFontManager extends BasicLanguageFontManager
   {
      
      private static var languageFontManager:CafeLanguageFontManager;
       
      
      public function CafeLanguageFontManager()
      {
         super();
      }
      
      public static function getInstance() : CafeLanguageFontManager
      {
         if(!languageFontManager)
         {
            languageFontManager = new CafeLanguageFontManager();
         }
         return languageFontManager;
      }
      
      override public function changeFontByLanguage(param1:TextField) : void
      {
         var _loc2_:TextFormat = null;
         var _loc3_:* = false;
         if(!useDefaultFont)
         {
            _loc2_ = param1.defaultTextFormat;
            _loc3_ = _loc2_.font.indexOf(this.env.gameTitle + "Font1_") < 0;
            if(_loc2_.font != this.env.gameTitle + "Font1_" + this.env.language)
            {
               _loc2_.font = this.env.gameTitle + "Font1_" + this.env.language;
               param1.defaultTextFormat = _loc2_;
               param1.setTextFormat(_loc2_);
               if(_loc3_)
               {
                  param1.y -= 2;
               }
               param1.embedFonts = true;
            }
         }
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
