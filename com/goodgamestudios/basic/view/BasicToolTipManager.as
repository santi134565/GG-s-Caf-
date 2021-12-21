package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.event.BasicToolTipEvent;
   import com.goodgamestudios.math.MathBase;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class BasicToolTipManager
   {
      
      public static const TOOLTIP_LABEL:String = "toolTipText";
      
      public static const TOOLTIP_VO:String = "toolTipVO";
       
      
      protected const TEXT_BORDER:int = 30;
      
      protected var ARROW_HEIGHT:int = 8;
      
      protected var ARROW_OFFSET:int = 5;
      
      protected const TIP_SPACE:int = 5;
      
      protected const MIN_WIDTH:int = 60;
      
      protected const MAX_WIDTH:int = 200;
      
      protected var textFieldHeightAdditive:int = 5;
      
      protected var backGroundHeightAdditive:int = 0;
      
      protected var _standardTextFieldY:int;
      
      protected var _target:DisplayObject;
      
      protected var _tooltipLayer:Sprite;
      
      protected var _disp:Sprite;
      
      protected var _tooltipBody:MovieClip;
      
      protected var _tooltipArrow:MovieClip;
      
      protected var _background:Sprite;
      
      protected var _textField:TextField;
      
      protected var _maxWidth:int = 200;
      
      protected var toolTipHeight:Number;
      
      public function BasicToolTipManager(param1:Sprite)
      {
         super();
         this._tooltipLayer = param1;
         this._tooltipLayer.mouseChildren = false;
         this._tooltipLayer.mouseEnabled = false;
         this._disp = new Sprite();
         this._tooltipLayer.addEventListener(BasicToolTipEvent.TOOLTIP_HIDE,this.onHide);
         this._tooltipBody = new Tooltip_Body();
         this._tooltipArrow = new Tooltip_Arrow();
         this._disp.mouseChildren = false;
         this._disp.mouseEnabled = false;
         this._disp.addChild(this._tooltipArrow);
         this._disp.addChild(this._tooltipBody);
         this._tooltipLayer.addChild(this._disp);
         this._textField = this._tooltipBody.txt_label;
         this._standardTextFieldY = this._textField.y;
         this._background = this._tooltipBody.background;
         this.updateTextField();
         this.hide();
         this.toolTipHeight = this._disp.getBounds(this._disp).height;
      }
      
      public function destroy() : void
      {
         this._tooltipLayer.removeEventListener(BasicToolTipEvent.TOOLTIP_HIDE,this.onHide);
      }
      
      private function updateTextField() : void
      {
         this._textField.y = this._standardTextFieldY;
         this.languageFontmanager.changeFontByLanguage(this._textField);
      }
      
      protected function get languageFontmanager() : BasicLanguageFontManager
      {
         return BasicLanguageFontManager.getInstance();
      }
      
      private function onHide(param1:BasicToolTipEvent) : void
      {
         this.hide();
      }
      
      public function show(param1:String, param2:DisplayObject = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.updatePosition();
         this._target = param2;
         var _loc3_:Rectangle = this._target.getBounds(null);
         if(this._textField && this._background)
         {
            if(this._textField.multiline)
            {
               this._textField.width = this._maxWidth;
            }
            this._textField.text = param1;
            if(this._textField.multiline && this._textField.textWidth < this._maxWidth)
            {
               this._textField.width = this._textField.textWidth + 5;
            }
            this._textField.height = this._textField.textHeight + this.textFieldHeightAdditive;
            this._textField.width = this._textField.textWidth + 5;
            this._textField.x = -(this._textField.width / 2);
            this._textField.y = -this._textField.height;
            this._background.width = Math.max(this.MIN_WIDTH,this._textField.width + this.TEXT_BORDER);
            if(this._textField.multiline)
            {
               this._background.height = this._textField.height + this.backGroundHeightAdditive;
            }
            this.toolTipHeight = this._background.height;
         }
         var _loc4_:Rectangle;
         var _loc5_:int = (_loc4_ = this._disp.getBounds(this._disp)).width / 2;
         var _loc6_:Point;
         var _loc7_:int = (_loc6_ = this._target.parent.localToGlobal(new Point(this._target.x,this._target.y))).x;
         var _loc8_:int = _loc6_.y;
         this._tooltipArrow.scaleY = 1;
         if(_loc7_ + _loc5_ > this._disp.stage.stageWidth)
         {
            this._disp.x = this._disp.stage.stageWidth - _loc5_ - this.TIP_SPACE;
            this._tooltipArrow.x = MathBase.min(int(this._background.width / 2 - 10),int(this._disp.globalToLocal(new Point(_loc6_.x,0)).x));
         }
         else if(_loc7_ - _loc5_ < 0)
         {
            this._disp.x = _loc5_ + this.TIP_SPACE;
            this._tooltipArrow.x = this._disp.globalToLocal(new Point(_loc6_.x,0)).x;
         }
         else
         {
            this._disp.x = _loc7_;
            this._tooltipArrow.x = 0;
         }
         if(_loc8_ + (_loc3_.top - this.toolTipHeight - this.ARROW_OFFSET - this.ARROW_HEIGHT) * this._disp.scaleY < 0)
         {
            _loc8_ = this.flipHorizontalToolTip(this.toolTipHeight,_loc3_,_loc6_);
         }
         else
         {
            _loc8_ += (_loc3_.top - this.ARROW_HEIGHT - this.ARROW_OFFSET) * this._disp.scaleY;
            this._tooltipArrow.y = 0;
         }
         this._disp.y = _loc8_;
         this._disp.visible = true;
         this._target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      protected function flipHorizontalToolTip(param1:int, param2:Rectangle, param3:Point) : int
      {
         this._tooltipArrow.scaleY = -1;
         this._tooltipArrow.y = -this.toolTipHeight;
         return param3.y + (param2.bottom + param1 + this.ARROW_OFFSET + this.ARROW_HEIGHT) * this._disp.scaleY;
      }
      
      public function updatePosition() : void
      {
      }
      
      public function hideAdvancedTooltip() : void
      {
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         this.hide();
      }
      
      public function get disp() : Sprite
      {
         return this._disp;
      }
      
      public function hide() : void
      {
         this._disp.visible = false;
         if(this._target)
         {
            this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }
   }
}
