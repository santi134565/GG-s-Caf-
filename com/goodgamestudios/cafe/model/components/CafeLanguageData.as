package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.components.BasicLanguageData;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   
   public class CafeLanguageData extends BasicLanguageData
   {
       
      
      private const CATEGORY_ALERTS:String = "alerts";
      
      private const CATEGORY_COMMONS:String = "commons";
      
      private const CATEGORY_COOKSTEP:String = "cookstep";
      
      private const CATEGORY_DIALOGS:String = "dialogs";
      
      private const CATEGORY_ERROR_CODES:String = "error_codes";
      
      private const CATEGORY_INGAME_TOOLTIPS:String = "ingame_tooltips";
      
      private const CATEGORY_INGREDIENTS:String = "ingredients";
      
      private const CATEGORY_PANELS:String = "panels";
      
      private const CATEGORY_PREPARESTEP:String = "preparestep";
      
      private const CATEGORY_PREPARESTEP_FANCY:String = "preparestep_fancy";
      
      private const CATEGORY_ACHIEVEMENTS:String = "achievement";
      
      private const CATEGORY_RECIPE:String = "recipe";
      
      private const CATEGORY_STD_BUTTONS:String = "std_buttons";
      
      private const CATEGORY_TOOLTIPS:String = "tooltips";
      
      private const CATEGORY_FEATURE:String = "feature";
      
      private const CATEGORY_LOGGEDINMSG:String = "loggedin_msg";
      
      private const CATEGORY_TUTORIAL:String = "tutorial";
      
      private const CATEGORY_COOPMISSION:String = "coopmission";
      
      private const CATEGORY_FEEDS:String = "feeds";
      
      private const CATEGORY_FASTFOOD:String = "recipes_fastfood";
      
      private const CATEGORY_GENERIC:String = "generic_flash";
      
      private const GAME_CATEGORIES:Array = [this.CATEGORY_GENERIC,this.CATEGORY_COOPMISSION,this.CATEGORY_LOGGEDINMSG,this.CATEGORY_FASTFOOD,this.CATEGORY_FEATURE,this.CATEGORY_ACHIEVEMENTS,this.CATEGORY_ALERTS,this.CATEGORY_COMMONS,this.CATEGORY_DIALOGS,this.CATEGORY_ERROR_CODES,this.CATEGORY_INGREDIENTS,this.CATEGORY_PANELS,this.CATEGORY_RECIPE,this.CATEGORY_STD_BUTTONS,this.CATEGORY_TOOLTIPS,this.CATEGORY_TUTORIAL,this.CATEGORY_COOKSTEP,this.CATEGORY_INGAME_TOOLTIPS,this.CATEGORY_PREPARESTEP,this.CATEGORY_PREPARESTEP_FANCY,this.CATEGORY_FEEDS];
      
      public function CafeLanguageData(param1:Class)
      {
         super(param1);
      }
      
      override protected function set languageXML(param1:XML) : void
      {
         super.languageXML = param1;
         gameLanguageDict = getLanguageDictByStructArray(this.GAME_CATEGORIES);
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
