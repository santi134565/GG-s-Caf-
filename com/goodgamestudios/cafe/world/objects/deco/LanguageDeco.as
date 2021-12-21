package com.goodgamestudios.cafe.world.objects.deco
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   
   public class LanguageDeco extends BasicDeco
   {
       
      
      public function LanguageDeco()
      {
         super();
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         var _loc1_:String = this.env.language;
         if(objectdisp.hasOwnProperty("specificForLanguage"))
         {
            objectdisp["specificForLanguage"].gotoAndStop(this.env.language);
         }
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
