package com.goodgamestudios.cafe.world.objects.cursor
{
   import com.goodgamestudios.isocore.VisualElement;
   import flash.utils.getDefinitionByName;
   
   public class StaticCursor extends VisualElement
   {
       
      
      public function StaticCursor()
      {
         super();
      }
      
      override protected function initVisualRep() : void
      {
         var _loc1_:Class = null;
         if(disp == null)
         {
            _loc1_ = getDefinitionByName(visClassName) as Class;
            disp = new _loc1_();
            disp.cacheAsBitmap = true;
         }
      }
   }
}
