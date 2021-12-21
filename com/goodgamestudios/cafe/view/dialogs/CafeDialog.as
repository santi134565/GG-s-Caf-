package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.dialogs.BasicDialog;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class CafeDialog extends BasicDialog
   {
       
      
      public function CafeDialog(param1:Sprite)
      {
         super(param1);
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         disp.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         disp.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      protected function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
      
      override protected function updateTextField(param1:TextField) : void
      {
         CafeLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton)
         {
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_BUTTON);
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
         basicController.dispatchEvent(new CafeDialogEvent(CafeDialogEvent.MOUSE_ON_DIALOG));
         if(param1.target.hasOwnProperty(BasicToolTipManager.TOOLTIP_LABEL) && param1.target.toolTipText)
         {
            this.layoutManager.tooltipManager.show(param1.target.toolTipText,param1.target as DisplayObject);
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         if(param1.target.hasOwnProperty(BasicToolTipManager.TOOLTIP_LABEL))
         {
            this.layoutManager.tooltipManager.hide();
         }
      }
      
      override protected function onCursorOver(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton)
         {
            if((param1.target as BasicButton).enabled)
            {
               this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            }
         }
         if(param1.target is TextField)
         {
            if((param1.target as TextField).type == TextFieldType.INPUT)
            {
               this.layoutManager.customCursor.hideCustomCursor();
            }
         }
      }
      
      override protected function onCursorOut(param1:MouseEvent) : void
      {
         this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         if(param1.target is TextField)
         {
            if((param1.target as TextField).type == TextFieldType.INPUT)
            {
               this.layoutManager.customCursor.showCustomCursor();
            }
         }
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      protected function get tutorialController() : CafeTutorialController
      {
         return CafeTutorialController.getInstance();
      }
   }
}
