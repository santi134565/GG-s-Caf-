package com.goodgamestudios.cafe.world.objects.door
{
   import com.goodgamestudios.isocore.objects.WallObject;
   import flash.filters.GlowFilter;
   
   public class BorderDoor extends WallObject
   {
       
      
      protected var selectedGlowfilter:GlowFilter;
      
      public function BorderDoor()
      {
         this.selectedGlowfilter = new GlowFilter(16711680);
         super();
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         isWalkable = true;
      }
      
      override public function startDrag() : void
      {
      }
      
      override public function stopDrag() : void
      {
      }
      
      public function addGlow() : void
      {
         if(world.mouse.objectsSelectable)
         {
            disp.filters = [this.selectedGlowfilter];
         }
      }
      
      public function removeGlow() : void
      {
         disp.filters = [];
      }
   }
}
