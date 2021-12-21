package com.goodgamestudios.cafe.world.vo.overlay
{
   import com.goodgamestudios.isocore.vo.VisualVO;
   
   public class MovingOverlayVO extends VisualVO
   {
      
      public static const OVERLAY_TYPE_WITH_ICON:String = "overlaywithicon";
      
      public static const OVERLAY_TYPE_TEXT:String = "overlaytext";
       
      
      public var text:String;
      
      public var lifeTime:Number = 1200;
      
      public var timeDelay:int = 0;
      
      public var relTargetY:Number = 0;
      
      public function MovingOverlayVO()
      {
         super();
         name = "Moving";
         group = "Overlay";
         type = "-";
      }
   }
}
