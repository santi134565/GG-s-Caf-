package com.goodgamestudios.cafe.view
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class CafeToolTipManager extends BasicToolTipManager
   {
       
      
      public function CafeToolTipManager(param1:Sprite)
      {
         super(param1);
         _maxWidth = 225;
      }
      
      override public function show(param1:String, param2:DisplayObject = null) : void
      {
         if(param1 == "")
         {
            return;
         }
         super.show(param1,param2);
      }
      
      override protected function get languageFontmanager() : BasicLanguageFontManager
      {
         return CafeLanguageFontManager.getInstance();
      }
   }
}
