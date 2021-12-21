package com.goodgamestudios.basic.view
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class FlashUIComponent
   {
      
      public static const NAME:String = "FlashUIComponent";
       
      
      private var _disp:DisplayObject;
      
      protected var properties:BasicProperties;
      
      protected var isInitialized:Boolean = false;
      
      public function FlashUIComponent(param1:DisplayObject)
      {
         super();
         this._disp = param1;
         this._disp.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         if(!this.isInitialized)
         {
            this.init();
            this.isInitialized = true;
         }
         this.applyProperties();
         this.updatePosition();
         this._disp.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._disp.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this._disp.stage.addEventListener(Event.RESIZE,this.onResize);
         this._disp.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this._disp.addEventListener(MouseEvent.CLICK,this.onClick);
         this._disp.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this._disp.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._disp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this._disp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      protected function updateTextField(param1:TextField) : void
      {
      }
      
      public function updateAllTextFields(param1:DisplayObjectContainer = null) : void
      {
         var _loc3_:TextField = null;
         var _loc2_:DisplayObjectContainer = !!param1 ? param1 : this.disp as DisplayObjectContainer;
         for each(_loc3_ in this.findTextFields(_loc2_))
         {
            this.updateTextField(_loc3_);
         }
      }
      
      protected function findTextFields(param1:DisplayObjectContainer) : Array
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:Array = null;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            if((_loc4_ = param1.getChildAt(_loc3_)) is TextField)
            {
               _loc2_.push(_loc4_);
            }
            else if(_loc4_ is DisplayObjectContainer)
            {
               _loc5_ = this.findTextFields(_loc4_ as DisplayObjectContainer);
               _loc2_ = _loc2_.concat(_loc5_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
      }
      
      protected function onKeyUp(param1:KeyboardEvent) : void
      {
      }
      
      protected function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public final function reset() : void
      {
         this.destroy();
         this.init();
         this.applyProperties();
      }
      
      protected function init() : void
      {
         this.updateAllTextFields();
      }
      
      public final function setProperties(param1:BasicProperties) : void
      {
         this.properties = param1;
         if(this.isInitialized)
         {
            this.applyProperties();
         }
      }
      
      protected function applyProperties() : void
      {
      }
      
      protected function onResize(param1:Event) : void
      {
         this.updatePosition();
      }
      
      public function show() : void
      {
         if(this._disp)
         {
            if(this._disp.stage)
            {
               this._disp.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
               this._disp.stage.addEventListener(Event.RESIZE,this.onResize);
            }
            this._disp.visible = true;
            this.onResize(null);
         }
      }
      
      protected function update() : void
      {
      }
      
      public function hide() : void
      {
         if(this._disp && this._disp.stage)
         {
            this._disp.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            this._disp.stage.removeEventListener(Event.RESIZE,this.onResize);
            this._disp.visible = false;
         }
      }
      
      public function isVisible() : Boolean
      {
         return this._disp.visible;
      }
      
      public function toggleVisibility() : void
      {
         if(this.isVisible())
         {
            this.hide();
         }
         else
         {
            this.show();
         }
      }
      
      public function updatePosition() : void
      {
      }
      
      public final function get disp() : DisplayObject
      {
         return this._disp;
      }
      
      public function destroy() : void
      {
         if(this._disp == null)
         {
            return;
         }
         this._disp.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         if(this.disp.hasEventListener(MouseEvent.CLICK))
         {
            this._disp.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         this._disp.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this._disp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._disp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this._disp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         if(this._disp.stage == null)
         {
            return;
         }
         this._disp.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this._disp.stage.removeEventListener(Event.RESIZE,this.onResize);
      }
   }
}
