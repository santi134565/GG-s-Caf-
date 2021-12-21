package com.goodgamestudios.cafe.world.objects.background
{
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.isocore.IsoBackground;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class StaticBackground extends IsoBackground
   {
       
      
      private var _isClickable:Boolean;
      
      protected var glowfilter:GlowFilter;
      
      public function StaticBackground()
      {
         this.glowfilter = new GlowFilter(16777215,0.8,16,16,4);
         super();
         this.isClickable = false;
      }
      
      override protected function initVisualRep() : void
      {
         var _loc1_:Class = null;
         if(disp == null)
         {
            _loc1_ = getDefinitionByName(visClassName) as Class;
            disp = new _loc1_();
         }
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
      }
      
      public function updateToolTipTextFields() : void
      {
         var _loc2_:TextField = null;
         var _loc1_:DisplayObjectContainer = disp as DisplayObjectContainer;
         for each(_loc2_ in this.findTextFields(_loc1_))
         {
            this.updateTextField(_loc2_);
         }
      }
      
      private function findTextFields(param1:DisplayObjectContainer) : Array
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
      
      protected function updateTextField(param1:TextField) : void
      {
         CafeLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
      
      protected function resetInteractiveItem(param1:MovieClip) : void
      {
         param1.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         param1 = null;
      }
      
      protected function initInteractiveItem(param1:MovieClip) : void
      {
         param1.mouseChildren = false;
         param1.useHandCursor = true;
         param1.buttonMode = true;
         param1.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         world.mouse.isOnObject = true;
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OVER,[this]));
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         world.mouse.isOnObject = false;
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OUT,[this]));
      }
      
      public function set isClickable(param1:Boolean) : void
      {
         this._isClickable = param1;
      }
      
      public function get isClickable() : Boolean
      {
         return this._isClickable;
      }
   }
}
