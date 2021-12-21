package com.goodgamestudios.basic.view.panels
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class BasicPanel extends FlashUIComponent
   {
       
      
      private var _isLocked:Boolean = false;
      
      public function BasicPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.basicController.addEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.onFontsLoaded);
         super.init();
      }
      
      override public function destroy() : void
      {
         this.basicController.removeEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.onFontsLoaded);
         super.destroy();
      }
      
      protected function onFontsLoaded(param1:LanguageDataEvent) : void
      {
         updateAllTextFields();
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
         this.onCursorOver(param1);
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
         this.onCursorOut(param1);
      }
      
      protected function onCursorOver(param1:MouseEvent) : void
      {
      }
      
      protected function onCursorOut(param1:MouseEvent) : void
      {
      }
      
      public function lockPanel() : void
      {
         this._isLocked = true;
      }
      
      public function unLockPanel() : void
      {
         this._isLocked = false;
      }
      
      protected function get isLocked() : Boolean
      {
         return this._isLocked;
      }
      
      public function checkWaitingAnimState(param1:String) : void
      {
      }
      
      protected function get basicController() : BasicController
      {
         return BasicController.getInstance();
      }
   }
}
