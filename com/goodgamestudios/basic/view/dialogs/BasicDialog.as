package com.goodgamestudios.basic.view.dialogs
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class BasicDialog extends FlashUIComponent
   {
      
      public static const NAME:String = "BasicDialog";
       
      
      protected var bg:Sprite;
      
      protected var dispBounds:Rectangle;
      
      protected var showBackground:Boolean = true;
      
      protected var backgroundAlpha:Number = 0.3;
      
      public function BasicDialog(param1:Sprite)
      {
         this.dispBounds = param1.getBounds(null);
         super(param1);
      }
      
      private function onBGAddedToStage(param1:Event) : void
      {
         this.bg.removeEventListener(Event.ADDED_TO_STAGE,this.onBGAddedToStage);
         this.bg.width = this.bg.stage.stageWidth;
         this.bg.height = this.bg.stage.stageHeight;
         this.bg.x = -disp.x;
         this.bg.y = -disp.y;
      }
      
      override protected function init() : void
      {
         this.bg = new Sprite();
         if(this.showBackground)
         {
            this.bg.graphics.beginFill(0,this.backgroundAlpha);
         }
         else
         {
            this.bg.graphics.beginFill(0,0);
         }
         this.bg.graphics.drawRect(0,0,1,1);
         this.bg.graphics.endFill();
         this.bg.addEventListener(Event.ADDED_TO_STAGE,this.onBGAddedToStage);
         (disp as Sprite).addChildAt(this.bg,0);
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
      
      override protected function onResize(param1:Event) : void
      {
         super.onResize(param1);
         if(!this.bg || !this.bg.stage)
         {
            return;
         }
         this.bg.width = this.bg.stage.stageWidth / disp.scaleX;
         this.bg.height = this.bg.stage.stageHeight / disp.scaleY;
         this.bg.x = -disp.x / disp.scaleX;
         this.bg.y = -disp.y / disp.scaleY;
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Number = NaN;
         if(disp && disp.stage)
         {
            _loc1_ = 1;
            if(disp.stage.stageWidth < this.dispBounds.width)
            {
               _loc1_ = disp.stage.stageWidth / this.dispBounds.width;
            }
            if(disp.stage.stageHeight < this.dispBounds.height * _loc1_)
            {
               _loc1_ = disp.stage.stageHeight / this.dispBounds.height;
            }
            disp.x = -(this.dispBounds.left * _loc1_) - this.dispBounds.width * _loc1_ / 2 + disp.stage.stageWidth / 2;
            disp.y = -(this.dispBounds.top * _loc1_) - this.dispBounds.height * _loc1_ / 2 + disp.stage.stageHeight / 2;
            disp.scaleX = disp.scaleY = _loc1_;
         }
      }
      
      override public function hide() : void
      {
         super.hide();
         BasicDialogHandler.getInstance().onHideCurrentDialog();
         if(!this.isUnique && disp.parent)
         {
            this.bg.removeEventListener(Event.ADDED_TO_STAGE,this.onBGAddedToStage);
            this.destroy();
            disp.parent.removeChild(disp);
         }
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
      
      public function checkWaitingAnimState(param1:String) : void
      {
      }
      
      public function get isUnique() : Boolean
      {
         return true;
      }
      
      protected function get basicController() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
   }
}
