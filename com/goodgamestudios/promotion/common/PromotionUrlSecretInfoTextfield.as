package com.goodgamestudios.promotion.common
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   
   public class PromotionUrlSecretInfoTextfield extends Sprite
   {
      
      private static const U_CHAR_CODE:int = 85;
      
      private static const R_CHAR_CODE:int = 82;
      
      private static const L_CHAR_CODE:int = 76;
       
      
      private var _pressedKeys:Object;
      
      private var _urlInfoTextfield:TextField;
      
      public function PromotionUrlSecretInfoTextfield()
      {
         super();
         addEventListener("addedToStage",onAddedToStageHandler);
      }
      
      private function onAddedToStageHandler(event:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStageHandler);
         addEventListener("removedFromStage",onRemovedFromStage);
         _urlInfoTextfield = new TextField();
         _pressedKeys = {};
         stage.addEventListener("keyDown",onKeyDownHandler);
         stage.addEventListener("keyUp",onKeyUpHandler);
      }
      
      private function onKeyDownHandler(event:KeyboardEvent) : void
      {
         if(event.keyCode == 85 || event.keyCode == 82 || event.keyCode == 76)
         {
            _pressedKeys[event.keyCode] = true;
         }
         checkPressedKeys();
      }
      
      private function onKeyUpHandler(event:KeyboardEvent) : void
      {
         if(event.keyCode == 85 || event.keyCode == 82 || event.keyCode == 76)
         {
            _pressedKeys[event.keyCode] = false;
         }
      }
      
      private function checkPressedKeys() : void
      {
         if(_pressedKeys[85] && _pressedKeys[82] && _pressedKeys[76])
         {
            _urlInfoTextfield.text = "url: " + PromotionModel.instance.referrerURL;
            addChild(_urlInfoTextfield);
         }
         else if(this.contains(_urlInfoTextfield))
         {
            this.removeChild(_urlInfoTextfield);
         }
      }
      
      private function onRemovedFromStage(event:Event) : void
      {
         stage.removeEventListener("keyDown",onKeyDownHandler);
         stage.removeEventListener("keyUp",onKeyUpHandler);
         if(this.contains(_urlInfoTextfield))
         {
            removeChild(_urlInfoTextfield);
         }
         if(_pressedKeys)
         {
            _pressedKeys = null;
         }
         if(_urlInfoTextfield)
         {
            _urlInfoTextfield = null;
         }
      }
   }
}
