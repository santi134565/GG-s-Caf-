package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.panels.BasicPanel;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafePanelEvent;
   import com.goodgamestudios.cafe.event.CafeTutorialEvent;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class CafePanel extends BasicPanel
   {
       
      
      public function CafePanel(param1:DisplayObject)
      {
         super(param1);
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.controller.addEventListener(CafeTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         disp.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         disp.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.controller.removeEventListener(CafeTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
      }
      
      override protected function updateTextField(param1:TextField) : void
      {
         CafeLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
      
      protected function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         this.controller.dispatchEvent(new CafePanelEvent(CafePanelEvent.MOUSE_ON_PANEL));
         super.onMouseOver(param1);
         if(param1.target.hasOwnProperty(BasicToolTipManager.TOOLTIP_LABEL))
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
               this.layoutManager.customCursor.isEnabled = false;
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
               this.layoutManager.customCursor.isEnabled = true;
            }
         }
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton)
         {
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_BUTTON);
         }
      }
      
      protected function onTutorialEvent(param1:CafeTutorialEvent) : void
      {
         if(CafeTutorialController.getInstance().isActive)
         {
            lockPanel();
         }
         else
         {
            unLockPanel();
         }
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get tutorialController() : CafeTutorialController
      {
         return CafeTutorialController.getInstance();
      }
   }
}
