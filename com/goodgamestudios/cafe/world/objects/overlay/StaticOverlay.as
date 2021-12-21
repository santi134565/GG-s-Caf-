package com.goodgamestudios.cafe.world.objects.overlay
{
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.cafe.world.vo.overlay.StaticOverlayVO;
   import com.goodgamestudios.isocore.IIsoWorld;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class StaticOverlay extends VisualElement
   {
       
      
      protected var overlay:Sprite;
      
      protected var textField:TextField;
      
      public function StaticOverlay()
      {
         super();
      }
      
      override public function initialize(param1:VisualVO, param2:IIsoWorld) : void
      {
         super.initialize(param1,param2);
         isMutable = true;
         this.updateAllTextFields();
      }
      
      protected function updateTextField(param1:TextField) : void
      {
         CafeLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
      
      public final function updateAllTextFields() : void
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
      
      private function get staticOverlayVO() : StaticOverlayVO
      {
         return vo as StaticOverlayVO;
      }
      
      override protected function createVisualRep() : Boolean
      {
         var _loc1_:Class = getDefinitionByName("Static_Overlay") as Class;
         this.overlay = new _loc1_();
         if(!this.overlay)
         {
            return false;
         }
         this.textField = this.overlay.getChildByName("txt_info") as TextField;
         if(this.textField && this.staticOverlayVO.text)
         {
            this.textField.text = this.staticOverlayVO.text;
            this.textField.width = this.textField.textWidth + 5;
            this.textField.x = -(this.textField.width / 2);
         }
         addDispChild(this.overlay);
         cacheAsBitmap = false;
         disp.mouseEnabled = false;
         disp.mouseChildren = false;
         return true;
      }
   }
}
