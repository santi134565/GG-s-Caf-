package com.goodgamestudios.cafe.world.info
{
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.isocore.VisualElement;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class BasicToolTip
   {
       
      
      public var disp:MovieClip;
      
      protected var parentVE:VisualElement;
      
      public function BasicToolTip(param1:VisualElement)
      {
         super();
         this.parentVE = param1;
      }
      
      protected function init(param1:String) : void
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         this.disp = new _loc2_();
         this.hide();
         this.updateAllTextFields();
      }
      
      protected function updateTextField(param1:TextField) : void
      {
         CafeLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
      
      public final function updateAllTextFields() : void
      {
         var _loc2_:TextField = null;
         var _loc1_:DisplayObjectContainer = this.disp as DisplayObjectContainer;
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
      
      public function show() : void
      {
         this.disp.visible = true;
         this.disp.x = this.parentVE.visualX;
         this.disp.y = this.parentVE.visualY;
      }
      
      public function hide() : void
      {
         this.disp.visible = false;
      }
      
      public function get isVisible() : Boolean
      {
         return this.disp.visible;
      }
   }
}
