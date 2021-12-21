package com.goodgamestudios.cafe.world.vo.overlay
{
   import com.goodgamestudios.isocore.VisualElement;
   
   public class ThirstyOverlayVO extends StaticOverlayVO
   {
       
      
      public var target:VisualElement;
      
      public function ThirstyOverlayVO()
      {
         super();
         relTargetY = 0;
         name = "Thirsty";
         group = "Overlay";
         type = "-";
      }
   }
}
