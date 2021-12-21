package com.goodgamestudios.cafe.view
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.AnimatedFlashUIComponent;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeOtherUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeAchievementDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAchievementDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafePlayerInfoDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafePlayerInfoDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.objects.moving.BasicMoving;
   import com.goodgamestudios.cafe.world.objects.moving.OtherplayerMoving;
   import com.goodgamestudios.cafe.world.vo.IPlayerVO;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class PlayerActionChoicesComponent extends AnimatedFlashUIComponent
   {
      
      public static const NAME:String = "PlayerActionChoicesComponent";
       
      
      private var _target:Object;
      
      private var _playerVO:IPlayerVO;
      
      public function PlayerActionChoicesComponent(param1:Sprite)
      {
         var _loc2_:CafePlayerActionChoices = new CafePlayerActionChoices();
         _loc2_.visible = false;
         _loc2_.mouseChildren = true;
         param1.addChild(_loc2_);
         super(_loc2_);
      }
      
      private function onUserQuit(param1:CafeOtherUserEvent) : void
      {
         if(param1.user.userId == this.userId)
         {
            this.kill();
         }
      }
      
      override protected function updateTextField(param1:TextField) : void
      {
         CafeLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         if(!(param1.target is BasicButton) || !(param1.target as BasicButton).enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.playerActionDialog.btn_achievements:
            case this.playerActionDialog.btn_achievements2:
               this.layoutManager.showDialog(CafeAchievementDialog.NAME,new CafeAchievementDialogProperties(this.playerId,this.userId));
               this.kill();
               break;
            case this.playerActionDialog.btn_info:
            case this.playerActionDialog.btn_info2:
               this.layoutManager.showDialog(CafePlayerInfoDialog.NAME,new CafePlayerInfoDialogProperties(this.userId,this.playerId));
               this.kill();
               break;
            case this.playerActionDialog.btn_visit:
            case this.playerActionDialog.btn_visit2:
               if(this.layoutManager.isoScreen.isoWorld.myPlayer.isWorking)
               {
                  this.layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")));
               }
               else
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_JOIN_CAFE,[this.userId,this.playerId]);
               }
               this.kill();
               break;
            case this.playerActionDialog.btn_job2:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_MARKETPLACE_JOB,[0,CafeModel.userData.userID,this.userId]);
               this.kill();
               break;
            case this.playerActionDialog.btn_kick2:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_KICK_USER,[this.userId]);
               this.kill();
               break;
            case this.playerActionDialog.btn_friend:
            case this.playerActionDialog.btn_friend2:
               if(param1.target.currentFrame == 1)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_BUDDY_INGAME,[0,CafeModel.userData.playerID,this.playerId]);
               }
               else
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_BUDDY_INGAME,[3,CafeModel.userData.playerID,this.playerId]);
               }
               this.kill();
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton)
         {
            this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
         if(param1.target.hasOwnProperty(BasicToolTipManager.TOOLTIP_LABEL))
         {
            this.layoutManager.tooltipManager.show(param1.target.toolTipText,param1.target as DisplayObject);
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton)
         {
            this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
         if(param1.target.hasOwnProperty(BasicToolTipManager.TOOLTIP_LABEL))
         {
            this.layoutManager.tooltipManager.hide();
         }
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         this.layoutManager.isoScreen.isoWorld.mouse.isOnObject = true;
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         this.kill();
         this.layoutManager.isoScreen.isoWorld.mouse.isOnObject = false;
      }
      
      public function kill() : void
      {
         hide();
         disp.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         disp.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.controller.removeEventListener(CafeOtherUserEvent.OTHER_USER_QUIT,this.onUserQuit);
         if(this._target)
         {
            this._target = null;
         }
      }
      
      public function get userId() : int
      {
         return this._playerVO.userId;
      }
      
      public function get playerId() : int
      {
         return this._playerVO.playerId;
      }
      
      public function initPlayerActionChoices(param1:Object, param2:IPlayerVO, param3:int = 0, param4:Boolean = false) : void
      {
         var _loc5_:Rectangle = null;
         var _loc6_:Rectangle = null;
         this._target = param1;
         this._playerVO = param2;
         disp.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         disp.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.controller.addEventListener(CafeOtherUserEvent.OTHER_USER_QUIT,this.onUserQuit);
         if(this._target is OtherplayerMoving)
         {
            (disp as MovieClip).gotoAndStop(2);
            this.playerActionDialog.btn_kick2.enableButton = this.layoutManager.currentState == CafeLayoutManager.STATE_MY_CAFE && !this._playerVO.isWaiter;
            this.playerActionDialog.btn_job2.enableButton = this.layoutManager.currentState == CafeLayoutManager.STATE_MARKETPLACE && this.playerId != -1 && this._playerVO.seekingJob;
            this.playerActionDialog.btn_visit2.enableButton = !this._playerVO.isEqual(CafeModel.levelData.levelVO.ownerPlayerID,CafeModel.levelData.levelVO.ownerUserID);
            if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_ADDFRIEND)
            {
               this.playerActionDialog.btn_friend2.enableButton = false;
               this.playerActionDialog.btn_friend2.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_ADDFRIEND]);
            }
            else if(!CafeModel.buddyList.isBuddyByPlayerId(this._playerVO.playerId))
            {
               this.playerActionDialog.btn_friend2.enableButton = param4 && !(this._playerVO.playerId < 0 || CafeModel.userData.isGuest()) && !CafeModel.buddyList.isSocialBuddyByPlayerId(this._playerVO.playerId);
               this.playerActionDialog.btn_friend2.gotoAndStop(1);
               this.playerActionDialog.btn_friend2.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_addfriend");
            }
            else
            {
               this.playerActionDialog.btn_friend2.enableButton = !CafeModel.buddyList.isSocialBuddyByPlayerId(this._playerVO.playerId);
               this.playerActionDialog.btn_friend2.gotoAndStop(2);
               this.playerActionDialog.btn_friend2.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_removebuddy");
            }
            this.playerActionDialog.btn_job2.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_job");
            this.playerActionDialog.btn_kick2.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_kick");
            this.playerActionDialog.btn_achievements2.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_achievements");
            this.playerActionDialog.btn_info2.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_info");
            this.playerActionDialog.btn_visit2.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_visit");
         }
         else
         {
            (disp as MovieClip).gotoAndStop(1);
            _loc5_ = (this._target as MovieClip).getBounds(null);
            _loc6_ = (disp as MovieClip).getBounds(null);
            disp.x = Math.max(-_loc6_.left + 5,(this._target as MovieClip).parent.localToGlobal(new Point(this._target.x,this._target.y)).x) + param3;
            disp.y = Math.max(-_loc6_.top + 5,(this._target as MovieClip).parent.localToGlobal(new Point(this._target.x,this._target.y)).y + _loc5_.top + 5);
            if(!CafeModel.buddyList.isBuddyByPlayerId(this._playerVO.playerId))
            {
               this.playerActionDialog.btn_friend.enableButton = param4 && !CafeModel.buddyList.isSocialBuddyByPlayerId(this._playerVO.playerId);
               this.playerActionDialog.btn_friend.gotoAndStop(1);
               this.playerActionDialog.btn_friend.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_addfriend");
            }
            else
            {
               this.playerActionDialog.btn_friend.enableButton = !CafeModel.buddyList.isSocialBuddyByPlayerId(this._playerVO.playerId);
               this.playerActionDialog.btn_friend.gotoAndStop(2);
               this.playerActionDialog.btn_friend.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_removebuddy");
            }
            this.playerActionDialog.btn_achievements.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.playerActionDialog.btn_achievements.name);
            this.playerActionDialog.btn_info.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.playerActionDialog.btn_info.name);
            this.playerActionDialog.btn_visit.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.playerActionDialog.btn_visit.name);
            this.playerActionDialog.btn_visit.enableButton = !this._playerVO.isEqual(CafeModel.levelData.levelVO.ownerPlayerID,CafeModel.levelData.levelVO.ownerUserID);
         }
         show();
      }
      
      override public function onEnterFrameUpdate() : void
      {
         if(this._target is OtherplayerMoving)
         {
            disp.x = this.layoutManager.isoScreen.isoWorld.worldLayer.localToGlobal(new Point(this._target.disp.x + (this._target as BasicMoving).overlayPosition.x,this._target.disp.y)).x;
            disp.y = this.layoutManager.isoScreen.isoWorld.worldLayer.localToGlobal(new Point(this._target.disp.x,this._target.disp.y + (this._target as BasicMoving).overlayPosition.y)).y;
         }
      }
      
      private function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
      
      private function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      private function get playerActionDialog() : CafePlayerActionChoices
      {
         return disp as CafePlayerActionChoices;
      }
   }
}
