package com.goodgamestudios.cafe.world.info
{
   import com.goodgamestudios.isocore.VisualElement;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class StoveIngredientTip extends BasicToolTip
   {
      
      private static const MC_NAME:String = "InfoIngredientTip";
       
      
      private var ingredientMC:Sprite;
      
      public function StoveIngredientTip(param1:VisualElement)
      {
         super(param1);
         init(MC_NAME);
      }
      
      public function showIngredient(param1:String) : void
      {
         while(disp.itemHolder.numChildren > 0)
         {
            disp.itemHolder.removeChildAt(0);
         }
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         this.ingredientMC = new _loc2_();
         var _loc3_:Rectangle = this.ingredientMC.getBounds(null);
         this.ingredientMC.x = -(_loc3_.width / 2 + _loc3_.left);
         this.ingredientMC.y = -(_loc3_.height / 2 + _loc3_.top);
         disp.itemHolder.addChild(this.ingredientMC);
         disp.visible = true;
      }
   }
}
