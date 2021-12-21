package com.goodgamestudios.cafe.view
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.view.BasicChoiceLanguageComponent;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import flash.display.MovieClip;
   
   public class CafeChoiceLanguageComponent extends BasicChoiceLanguageComponent
   {
       
      
      public function CafeChoiceLanguageComponent(param1:MovieClip)
      {
         super(param1);
      }
      
      override protected function selectChild(param1:MovieClip) : void
      {
         if(param1 is BasicButton)
         {
            (param1 as BasicButton).selected();
         }
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
