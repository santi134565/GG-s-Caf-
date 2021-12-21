package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class BasicCustomCursor
   {
      
      public static const CURSOR_ARROW:int = 1;
      
      public static const CURSOR_CLICK:int = 2;
      
      public static const CURSOR_DRAG:int = 3;
      
      public static const CURSOR_HAND:int = 4;
       
      
      private var _disp:MovieClip;
      
      private var _isEnabled:Boolean = false;
      
      private var _hidePermanent:Boolean = false;
      
      private var _additionalCursorGfx:Sprite;
      
      public function BasicCustomCursor(param1:MovieClip)
      {
         super();
         this._disp = param1;
         this._additionalCursorGfx = new Sprite();
         this._additionalCursorGfx.mouseChildren = false;
         this._additionalCursorGfx.mouseEnabled = false;
         this._disp.addChild(this._additionalCursorGfx);
      }
      
      public function init() : void
      {
         Mouse.hide();
         this._disp.mouseEnabled = false;
         this._disp.mouseChildren = false;
         this._disp.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._isEnabled = true;
      }
      
      public function onAddedToStage(param1:Event) : void
      {
         this._disp.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._disp.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.updateMouse);
         this._disp.stage.addEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler);
         this.setCursorType(CURSOR_ARROW);
      }
      
      public function hideForPerformance() : void
      {
         if(this._disp)
         {
            this._disp.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.updateMouse);
            this._disp.stage.removeEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler);
            this._disp.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseReturnHandler);
            this._disp.visible = false;
            this.isEnabled = false;
            this._hidePermanent = true;
         }
         Mouse.show();
      }
      
      public function setCursorType(param1:int) : void
      {
         if(this._disp)
         {
            MovieClipHelper.clearMovieClip(this.additionalCursorGfx);
            this._disp.gotoAndStop(param1);
         }
      }
      
      private function updateMouse(param1:MouseEvent) : void
      {
         if(!this._isEnabled)
         {
            return;
         }
         if(this._disp.stage)
         {
            this._disp.x = this._disp.stage.mouseX;
            this._disp.y = this._disp.stage.mouseY;
            param1.updateAfterEvent();
         }
      }
      
      private function mouseLeaveHandler(param1:Event) : void
      {
         this.hideCustomCursor();
         Mouse.show();
         if(this._disp.stage)
         {
            this._disp.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseReturnHandler,false,0,true);
         }
      }
      
      private function mouseReturnHandler(param1:MouseEvent) : void
      {
         this.showCustomCursor();
         Mouse.hide();
         if(this._disp.stage)
         {
            this._disp.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseReturnHandler);
         }
      }
      
      public function hideCustomCursor() : void
      {
         if(this._disp)
         {
            this._disp.visible = false;
         }
      }
      
      public function showCustomCursor() : void
      {
         if(this._disp && !this._hidePermanent)
         {
            this._disp.visible = true;
         }
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         if(this._hidePermanent)
         {
            return;
         }
         this._isEnabled = param1;
         if(this._isEnabled)
         {
            Mouse.hide();
            this.showCustomCursor();
         }
         else
         {
            Mouse.show();
            this.hideCustomCursor();
         }
      }
      
      public function get isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      public function get disp() : MovieClip
      {
         return this._disp;
      }
      
      public function get additionalCursorGfx() : Sprite
      {
         return this._additionalCursorGfx;
      }
   }
}
