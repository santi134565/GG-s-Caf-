package com.goodgamestudios.cafe.world.vo.overlay
{
   public class StaticOverlayVO extends MovingOverlayVO
   {
      
      public static const OVERLAY_TYPE_INFOTEXT:String = "overlayinfotext";
      
      public static const OVERLAY_TYPE_SPEECH_BALLOON:String = "overlayspeechballoon";
      
      public static const OVERLAY_TYPE_THIRSTY:String = "overlaythirsty";
      
      public static const OVERLAY_TYPE_WITH_WAITINGICON:String = "overlaywithwaitingicon";
      
      public static const OVERLAY_TYPE_WITH_SEEKINGJOBICON:String = "overlaywithseekingjobicon";
       
      
      public function StaticOverlayVO()
      {
         super();
         relTargetY = 0;
         name = "Static";
         group = "Overlay";
         type = "-";
      }
   }
}
