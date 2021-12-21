package com.goodgamestudios.cafe.world.objects.overlay
{
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.cafe.world.objects.moving.VestedMoving;
   import com.goodgamestudios.cafe.world.vo.overlay.ChatOverlayVO;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class ChatOverlay extends StaticOverlay
   {
       
      
      private var dieTime:Number;
      
      private var background:MovieClip;
      
      public function ChatOverlay()
      {
         super();
      }
      
      override protected function createVisualRep() : Boolean
      {
         var _loc1_:Class = getDefinitionByName("Chat_Overlay") as Class;
         overlay = new _loc1_();
         if(!overlay)
         {
            return false;
         }
         textField = overlay.getChildByName("txt_label") as TextField;
         textField.embedFonts = CafeLanguageFontManager.getInstance().useDefaultFont;
         this.background = overlay.getChildByName("mc_bg") as MovieClip;
         addDispChild(overlay);
         cacheAsBitmap = false;
         disp.mouseEnabled = false;
         disp.mouseChildren = false;
         hide();
         return true;
      }
      
      public function newChatMessage(param1:String) : void
      {
         show();
         textField.width = (vo as ChatOverlayVO).maxWidth;
         textField.text = param1;
         if(textField.textWidth < (vo as ChatOverlayVO).maxWidth)
         {
            textField.width = textField.textWidth + 5;
         }
         textField.height = textField.textHeight + 5;
         textField.x = -textField.width / 2;
         textField.y = -textField.height;
         this.background.width = textField.width + 20;
         this.background.height = textField.height;
         var _loc2_:Rectangle = ((vo as ChatOverlayVO).target as VestedMoving).animDisp.getBounds(null);
         visualX = _loc2_.width / 2;
         visualY = -_loc2_.height + 20;
         this.dieTime = getTimer() + (vo as ChatOverlayVO).lifeTime;
      }
      
      override protected function updateVisualRep(param1:Number) : void
      {
         if(param1 > this.dieTime)
         {
            hide();
         }
      }
   }
}
