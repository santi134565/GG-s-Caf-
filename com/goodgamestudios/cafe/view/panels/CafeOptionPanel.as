package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeBoardConstants;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.event.CafeTutorialEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarChangeDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeGameHelpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeHighscoreDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeHighscoreDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeMailVerificationDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeOptionDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.misc.SupportUtil;
   import com.goodgamestudios.utils.ForumUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class CafeOptionPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeOptionPanel";
       
      
      public function CafeOptionPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         if(disp && disp.stage)
         {
            _loc1_ = disp.getBounds(null);
            disp.x = disp.stage.stageWidth;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeUserEvent.LEVELUP,this.initButtons);
         controller.removeEventListener(CafeUserEvent.MAILVERIFICATION_COMPLETED,this.onMailVerified);
      }
      
      override protected function init() : void
      {
         this.initButtons();
         controller.addEventListener(CafeUserEvent.LEVELUP,this.initButtons);
         controller.addEventListener(CafeUserEvent.MAILVERIFICATION_COMPLETED,this.onMailVerified);
         super.init();
      }
      
      override protected function onTutorialEvent(param1:CafeTutorialEvent) : void
      {
         this.initButtons(null);
         super.onTutorialEvent(param1);
      }
      
      private function initButtons(param1:CafeUserEvent = null) : void
      {
         this.optionPanel.btn_options.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_options.name);
         this.optionPanel.btn_help.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_help.name);
         this.optionPanel.btn_fullscreen.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_fullscreen.name);
         this.optionPanel.btn_logout.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_logout.name);
         this.optionPanel.btn_zoomIn.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_zoomIn.name);
         this.optionPanel.btn_zoomOut.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_zoomOut.name);
         this.optionPanel.btn_logout.visible = !env.loginIsKeyBased;
         this.optionPanel.btn_fullscreen.visible = env.allowedfullscreen;
         this.optionPanel.btn_support.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_support.name);
         if(env.networkNewsByJS)
         {
            this.optionPanel.btn_news.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_socialgroup");
         }
         else
         {
            this.optionPanel.btn_news.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_news.name);
         }
         this.optionPanel.btn_avatar.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_custom");
         this.optionPanel.btn_music.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_music.name);
         this.optionPanel.btn_sfx.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.optionPanel.btn_sfx.name);
         this.optionPanel.btn_help.visible = env.useexternallinks;
         this.optionPanel.btn_mailverification.visible = false;
         this.optionPanel.btn_mailverification.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_verifyemail");
         if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_HIGHSCORE)
         {
            this.optionPanel.btn_highscore.enableButton = false;
            this.optionPanel.btn_highscore.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_HIGHSCORE]);
         }
         else
         {
            this.optionPanel.btn_highscore.enableButton = true;
            this.optionPanel.btn_highscore.toolTipText = CafeModel.languageData.getTextById("dialogwin_highscore_title");
         }
         this.setSoundButtons();
      }
      
      private function onMailVerified(param1:CafeUserEvent) : void
      {
         this.optionPanel.btn_mailverification.visible = false;
      }
      
      private function setSoundButtons() : void
      {
         if(CafeSoundController.getInstance().isEffectsMuted)
         {
            this.optionPanel.btn_sfx.gotoAndStop(2);
         }
         else
         {
            this.optionPanel.btn_sfx.gotoAndStop(1);
         }
         if(CafeSoundController.getInstance().isMusicMuted)
         {
            this.optionPanel.btn_music.gotoAndStop(2);
         }
         else
         {
            this.optionPanel.btn_music.gotoAndStop(1);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton && !(param1.target as BasicButton).enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.optionPanel.btn_music:
               super.onClick(param1);
               CafeSoundController.getInstance().toggleMuteMusic();
               controller.saveSoundSettings();
               this.setSoundButtons();
               return;
            case this.optionPanel.btn_sfx:
               super.onClick(param1);
               CafeSoundController.getInstance().toggleMuteEffects();
               controller.saveSoundSettings();
               this.setSoundButtons();
               return;
            default:
               if(isLocked)
               {
                  return;
               }
               super.onClick(param1);
               switch(param1.target)
               {
                  case this.optionPanel.btn_options:
                     layoutManager.showDialog(CafeOptionDialog.NAME);
                     break;
                  case this.optionPanel.btn_avatar:
                     if(layoutManager.isoScreen.isoWorld.myPlayer.isWaiter)
                     {
                        layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_avatarcustom_copy")));
                        break;
                     }
                     if(layoutManager.isoScreen.isoWorld.myPlayer.isWorking)
                     {
                        layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")));
                     }
                     else if(CafeModel.userData.isGuest() && layoutManager.inGameState)
                     {
                        layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
                     }
                     else
                     {
                        layoutManager.showDialog(CafeAvatarChangeDialog.NAME);
                     }
                     break;
                  case this.optionPanel.btn_mailverification:
                     layoutManager.showDialog(CafeMailVerificationDialog.NAME);
                     break;
                  case this.optionPanel.btn_help:
                     layoutManager.showDialog(CafeGameHelpDialog.NAME);
                     break;
                  case this.optionPanel.btn_support:
                     this.mailSupport();
                     break;
                  case this.optionPanel.btn_news:
                     this.goNews();
                     break;
                  case this.optionPanel.btn_logout:
                     if(layoutManager.isoScreen.isoWorld.myPlayer.isWorking)
                     {
                        layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")));
                     }
                     else if(CafeModel.userData.isGuest())
                     {
                        layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(false,true));
                     }
                     else
                     {
                        CommandController.instance.executeCommand(BasicController.COMMAND_LOGOUT);
                     }
                     break;
                  case this.optionPanel.btn_zoomIn:
                     layoutManager.isoScreen.isoWorld.doAction(CafeIsoWorld.ACTION_CAMERA_ZOOM_IN,[]);
                     break;
                  case this.optionPanel.btn_zoomOut:
                     layoutManager.isoScreen.isoWorld.doAction(CafeIsoWorld.ACTION_CAMERA_ZOOM_OUT,[]);
                     break;
                  case this.optionPanel.btn_fullscreen:
                     layoutManager.toggleFullscreen();
                     break;
                  case this.optionPanel.btn_highscore:
                     layoutManager.showDialog(CafeHighscoreDialog.NAME,new CafeHighscoreDialogProperties());
               }
               return;
         }
      }
      
      private function mailSupport() : void
      {
         SupportUtil.navigateToSupport(env.gameId,env.instanceId,env.versionText,env.networkId,env.gameTitle,CafeModel.userData.userName,CafeModel.userData.playerID,CafeModel.userData.userID,env.language,env.referrer);
      }
      
      private function onChangePassword(param1:Array) : void
      {
         if(param1 && param1.length == 2)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CHANGE_PASSWORD,param1);
         }
      }
      
      private function goGroup() : void
      {
         if(!ExternalInterface.available)
         {
            return;
         }
         try
         {
            ExternalInterface.call("requestGroup");
         }
         catch(error:SecurityError)
         {
         }
      }
      
      private function goNews() : void
      {
         if(env.networkNewsByJS)
         {
            this.goGroup();
         }
         else if(env.useexternallinks)
         {
            this.goForum(env.language,CafeBoardConstants.FORUM_POSTFIX);
         }
         else
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_LOGIN_FEATURES,[]);
         }
      }
      
      private function goForum(param1:String = "", param2:String = "") : void
      {
         var urlVariables:URLVariables = null;
         var urlRequest:URLRequest = null;
         var language:String = param1;
         var postfix:String = param2;
         ForumUtils.navigateToForum(basicController.cryptedForumHash + (env.isTest || env.isLocal ? "/1" : ""));
      }
      
      private function onClickLogout(param1:Array) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_LOGOUT);
      }
      
      override public function show() : void
      {
         super.show();
         this.optionPanel.btn_highscore.visible = true;
      }
      
      protected function get optionPanel() : OptionPanel
      {
         return disp as OptionPanel;
      }
   }
}
