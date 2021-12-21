package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeOtherUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CafePlayerInfoDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafePlayerInfoDialog";
      
      public static const SCALE_FACTOR:Number = 1.5;
       
      
      public function CafePlayerInfoDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.playerInfoDialog.txt_name.text = "";
         this.playerInfoDialog.txt_level.text = "";
         this.playerInfoDialog.txt_jobs.text = "";
         while(this.playerInfoDialog.mc_holder.numChildren > 0)
         {
            this.playerInfoDialog.mc_holder.removeChildAt(0);
         }
         var _loc1_:MovieClip = new ServerWaitingAnim();
         _loc1_.y = _loc1_.height;
         this.playerInfoDialog.mc_holder.addChild(_loc1_);
         controller.addEventListener(CafeOtherUserEvent.OTHER_USER_UPDATE,this.onOtherplayerInfo);
         controller.sendServerMessageAndWait(SFConstants.C2S_OTHERPLAYER_INFO,[this.playerInfoDialogProperties.userId,this.playerInfoDialogProperties.playerId],SFConstants.S2C_OTHERPLAYER_INFO);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.playerInfoDialog.btn_close:
               hide();
               controller.removeEventListener(CafeOtherUserEvent.OTHER_USER_UPDATE,this.onOtherplayerInfo);
         }
      }
      
      private function onOtherplayerInfo(param1:CafeOtherUserEvent) : void
      {
         var _loc2_:OtherplayerMovingVO = param1.user;
         this.fillItems(_loc2_);
      }
      
      private function fillItems(param1:OtherplayerMovingVO) : void
      {
         var _loc2_:Sprite = null;
         this.playerInfoDialog.txt_name.text = param1.playerName;
         this.playerInfoDialog.txt_level.text = String(CafeModel.userData.getLevelByXp(param1.playerXp));
         this.playerInfoDialog.txt_jobs.text = "x" + param1.openJobs;
         while(this.playerInfoDialog.mc_holder.numChildren > 0)
         {
            this.playerInfoDialog.mc_holder.removeChildAt(0);
         }
         _loc2_ = CreateAvatarHelper.createAvatar(param1.avatarParts);
         var _loc3_:Rectangle = _loc2_.getBounds(null);
         _loc2_.x = -(_loc3_.width * SCALE_FACTOR / 2 + _loc3_.left * SCALE_FACTOR);
         _loc2_.y = -(_loc3_.top * SCALE_FACTOR) - 40;
         _loc2_.scaleX = _loc2_.scaleY = SCALE_FACTOR;
         this.playerInfoDialog.mc_holder.addChild(_loc2_);
      }
      
      protected function get playerInfoDialogProperties() : CafePlayerInfoDialogProperties
      {
         return properties as CafePlayerInfoDialogProperties;
      }
      
      protected function get playerInfoDialog() : CafePlayerInfo
      {
         return disp as CafePlayerInfo;
      }
   }
}
