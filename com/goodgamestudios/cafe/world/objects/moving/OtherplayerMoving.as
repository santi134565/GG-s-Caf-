package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   import com.goodgamestudios.cafe.world.vo.overlay.StaticOverlayVO;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class OtherplayerMoving extends PlayerMoving
   {
       
      
      public function OtherplayerMoving()
      {
         super();
         _speed = 40;
         overlayPosition.x = 30;
         overlayPosition.y = -100;
         isClickable = !CafeModel.userData.isMyPlayerWaiter;
      }
      
      override protected function createVisualRep() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         vo.deltaDepth = CafeConstants.DEPTH_OTHERPLAYER + (vo as OtherplayerMovingVO).playerId / 100000000;
         if(cafeIsoWorld.cafeWorldType == CafeConstants.CAFE_WORLD_TYPE_MARKETPLACE)
         {
            _loc2_ = int(Math.random() * 2) * 2;
            _loc3_ = int(Math.random() * 2) * 2;
            isoDir = new Point(1 - _loc2_,1 - _loc3_);
         }
         super.createVisualRep();
         var _loc1_:AnimatedDisplayObject = getHatAnim();
         if(_loc1_ && _loc1_.disp)
         {
            _loc1_.disp.visible = (getVisualVO() as OtherplayerMovingVO).userId == cafeIsoWorld.levelData.ownerUserID || (getVisualVO() as OtherplayerMovingVO).playerId == cafeIsoWorld.levelData.ownerPlayerID && cafeIsoWorld.levelData.ownerPlayerID >= 0;
         }
         return true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         cafeIsoWorld.addInfoBox(this,StaticOverlayVO.OVERLAY_TYPE_INFOTEXT,[(getVisualVO() as OtherplayerMovingVO).playerName]);
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         super.onRollOver(param1);
         if(isClickable)
         {
            world.mouse.isOnObject = true;
         }
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         super.onRollOut(param1);
         if(isClickable)
         {
            world.mouse.isOnObject = false;
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         if(isClickable)
         {
            world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.OTHERPLAYER_CLICK,[this]));
         }
      }
   }
}
