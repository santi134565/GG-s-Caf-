package com.goodgamestudios.cafe.world.vo.overlay
{
   import com.goodgamestudios.isocore.VisualElement;
   
   public class ChatOverlayVO extends StaticOverlayVO
   {
       
      
      public var maxWidth:int = 70;
      
      public var target:VisualElement;
      
      public function ChatOverlayVO()
      {
         super();
         name = "Chat";
         lifeTime = 3000;
      }
   }
}
