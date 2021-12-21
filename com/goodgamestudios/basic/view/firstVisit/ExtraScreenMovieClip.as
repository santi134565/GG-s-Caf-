package com.goodgamestudios.basic.view.firstVisit
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ExtraScreenMovieClip extends MovieClip
   {
       
      
      public var disp:MovieClip;
      
      protected var cursor:BasicCustomCursor;
      
      public function ExtraScreenMovieClip(param1:MovieClip, param2:BasicCustomCursor)
      {
         super();
         this.disp = param1;
         this.cursor = param2;
         param1.addEventListener(MouseEvent.CLICK,this.onClick);
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onCursorOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onCursorOut);
         param1.addEventListener(Event.ADDED_TO_STAGE,this.onDispAddedToStage);
         param1.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveDisp);
      }
      
      protected function onDispAddedToStage(param1:Event) : void
      {
         this.disp.removeEventListener(Event.ADDED_TO_STAGE,this.onDispAddedToStage);
         this.disp.stage.addEventListener(Event.RESIZE,this.updatePosition);
         this.updatePos();
      }
      
      protected function onRemoveDisp(param1:Event) : void
      {
         this.disp.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.disp.removeEventListener(MouseEvent.MOUSE_OVER,this.onCursorOver);
         this.disp.removeEventListener(MouseEvent.MOUSE_OUT,this.onCursorOut);
         this.disp.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveDisp);
         this.disp.stage.removeEventListener(Event.RESIZE,this.updatePosition);
         this.cursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         MovieClipHelper.clearMovieClip(this.disp);
         this.disp = null;
      }
      
      public function init() : void
      {
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
      }
      
      protected function onCursorOver(param1:MouseEvent) : void
      {
      }
      
      protected function onCursorOut(param1:MouseEvent) : void
      {
      }
      
      protected function updatePosition(param1:Event) : void
      {
         this.updatePos();
      }
      
      protected function updatePos() : void
      {
         if(this.disp && this.disp.stage)
         {
            if(this.disp.stage.stageHeight / 600 < this.disp.stage.stageWidth / 800)
            {
               this.disp.scaleX = this.disp.scaleY = this.disp.stage.stageHeight / 600;
            }
            else
            {
               this.disp.scaleX = this.disp.scaleY = this.disp.stage.stageWidth / 800;
            }
            this.disp.x = (this.disp.stage.stageWidth - 800 * this.disp.scaleX) / 2;
         }
      }
   }
}
