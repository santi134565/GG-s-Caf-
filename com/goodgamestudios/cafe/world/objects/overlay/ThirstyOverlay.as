package com.goodgamestudios.cafe.world.objects.overlay
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.objects.moving.NpcguestMoving;
   import com.goodgamestudios.cafe.world.vo.overlay.ThirstyOverlayVO;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class ThirstyOverlay extends StaticOverlay
   {
       
      
      public function ThirstyOverlay()
      {
         super();
      }
      
      override protected function createVisualRep() : Boolean
      {
         var _loc1_:Class = getDefinitionByName("Thirsty_Overlay") as Class;
         overlay = new _loc1_();
         overlay.scaleX = overlay.scaleY = 0.8;
         if(!overlay)
         {
            return false;
         }
         addDispChild(overlay);
         cacheAsBitmap = false;
         disp.mouseChildren = false;
         return true;
      }
      
      override public function show() : void
      {
         super.show();
         disp.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         disp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         disp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         ((vo as ThirstyOverlayVO).target as NpcguestMoving).onOverlayClick();
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         ((vo as ThirstyOverlayVO).target as NpcguestMoving).addGlow();
         CafeLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         ((vo as ThirstyOverlayVO).target as NpcguestMoving).removeGlow();
         CafeLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      override public function hide() : void
      {
         disp.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         disp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         disp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
   }
}
