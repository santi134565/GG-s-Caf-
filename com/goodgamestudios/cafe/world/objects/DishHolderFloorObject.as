package com.goodgamestudios.cafe.world.objects
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   
   public class DishHolderFloorObject extends CafeInteractiveFloorObject
   {
       
      
      protected var dishGfx:MovieClip;
      
      protected var dishYShift:int = 0;
      
      public var currentDish:BasicDishVO;
      
      public function DishHolderFloorObject()
      {
         super();
      }
      
      protected function addDishGfx(param1:BasicDishVO) : void
      {
         var _loc2_:Class = getDefinitionByName(param1.getVisClassName()) as Class;
         this.dishGfx = new _loc2_();
         this.dishGfx.y += this.dishYShift;
         objectLayer.addChild(this.dishGfx);
      }
      
      public function get dishMcName() : String
      {
         return (CafeModel.wodData.voList[this.currentDish.wodId] as VisualVO).getVisClassName();
      }
      
      protected function removeDishGfx() : void
      {
         if(this.dishGfx)
         {
            objectLayer.removeChild(this.dishGfx);
            this.dishGfx = null;
         }
      }
      
      protected function switchDishGfx(param1:int) : void
      {
         if(this.dishGfx)
         {
            this.dishGfx.gotoAndStop(param1);
         }
      }
   }
}
