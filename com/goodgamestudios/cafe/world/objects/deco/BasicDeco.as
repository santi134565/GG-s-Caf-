package com.goodgamestudios.cafe.world.objects.deco
{
   import com.goodgamestudios.cafe.world.objects.CafeInteractiveFloorObject;
   import flash.events.MouseEvent;
   
   public class BasicDeco extends CafeInteractiveFloorObject
   {
       
      
      public function BasicDeco()
      {
         super();
         isMutable = false;
      }
      
      override protected function onRollOverRun(param1:MouseEvent) : void
      {
         world.mouse.isOnObject = false;
      }
   }
}
