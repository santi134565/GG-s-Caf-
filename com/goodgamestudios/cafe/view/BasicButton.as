package com.goodgamestudios.cafe.view
{
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public dynamic class BasicButton extends MovieClip
   {
       
      
      protected var colorMatrix:ColorMatrix;
      
      protected var glowfilter:GlowFilter;
      
      protected var background:Sprite;
      
      protected var textField:TextField;
      
      private var _minWidth:int = 100;
      
      public var textXOffset:int = 0;
      
      private var initScale:Number;
      
      public function BasicButton()
      {
         this.glowfilter = new GlowFilter(16777215,0.8,16,16,4);
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveToStage);
      }
      
      private function onRemoveToStage(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveToStage);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      protected function init() : void
      {
         useHandCursor = true;
         buttonMode = true;
         mouseChildren = false;
         tabEnabled = false;
         this.enableButton = enabled;
         this.initScale = this.scaleX;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      public function set minWidth(param1:int) : void
      {
         this._minWidth = param1;
         if(this.textField)
         {
            this.label = this.textField.text;
         }
      }
      
      public function set label(param1:String) : void
      {
         this.textField = this.txt_label;
         this.background = this.mc_background;
         if(this.textField)
         {
            this.textField.text = param1;
            this.textField.width = this.textField.textWidth + 5;
            this.textField.x = -(this.textField.width / 2) + this.textXOffset;
            if(this.background)
            {
               this.background.width = Math.max(this._minWidth,this.textField.width + this.textXOffset + 30);
               this.background.x = -(this.background.width / 2);
               if(this.getChildByName("mc_symbol"))
               {
                  this.mc_symbol.x = -(this.background.width / 2);
               }
            }
         }
      }
      
      public function set enableButton(param1:Boolean) : void
      {
         enabled = param1;
         if(this.colorMatrix == null)
         {
            this.colorMatrix = new ColorMatrix();
            this.colorMatrix.desaturate();
         }
         filters = !!param1 ? null : [this.colorMatrix.filter];
      }
      
      public function selected() : void
      {
         if(enabled)
         {
            filters = [this.glowfilter];
         }
      }
      
      public function deselected() : void
      {
         if(enabled)
         {
            filters = null;
         }
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         if(enabled)
         {
            this.scaleX = this.scaleY = this.initScale;
         }
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         if(enabled)
         {
            this.scaleX = this.scaleY = this.initScale * 1.05;
         }
      }
   }
}
