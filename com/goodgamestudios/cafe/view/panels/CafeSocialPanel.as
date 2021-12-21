package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeBuddyEvent;
   import com.goodgamestudios.cafe.event.CafeChatEvent;
   import com.goodgamestudios.cafe.event.CafeOtherUserEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.view.CafeChoiceLanguageComponent;
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeInviteFriendDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeInviteFriendDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeReportPlayerDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeReportPlayerDialogProperties;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.IPlayerVO;
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
   public class CafeSocialPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeSocialPanel";
      
      public static const SCALE_FACTOR:Number = 0.75;
      
      public static const ADMIN_MSG:int = -100;
       
      
      private var VIEWSTATE_CHAT:int = 0;
      
      private var VIEWSTATE_PLAYER:int = 1;
      
      private var VIEWSTATE_FRIENDS:int = 2;
      
      private var chatHeight:int = 0;
      
      private var currentView:int;
      
      private var currentPlayerPage:int;
      
      private var itemsPerPage:int = 4;
      
      private var maxPage:int = 0;
      
      private var _reportPlayerUserId:int;
      
      private var choiceLanguageComponent:CafeChoiceLanguageComponent;
      
      public function CafeSocialPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.chatHeight = 0;
         this.currentPlayerPage = 0;
         this.socialPanel.tabChildren = false;
         this.socialPanel.btn_buddies.visible = !env.hasNetworkBuddies;
         this.socialPanel.btn_findbuddies.visible = !env.loginIsKeyBased;
         this.socialPanel.btn_buddies.enableButton = true;
         this.setButtons();
         this.socialPanel.btn_chat.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.socialPanel.btn_chat.name);
         this.socialPanel.btn_buddies.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.socialPanel.btn_buddies.name);
         this.socialPanel.btn_buddiesincafe.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.socialPanel.btn_buddiesincafe.name);
         this.socialPanel.mc_chatcontent.txt_chatmsg.condenseWhite = true;
         this.socialPanel.mc_chatcontent.txt_chatmsg.maxChars = 100;
         this.socialPanel.mc_chatcontent.txt_chatmsg.text = "";
         this.enableButtons(false);
         this.socialPanel.mc_chatcontent.chatblocked.visible = false;
         this.socialPanel.mc_chatcontent.btn_slider.addEventListener(MouseEvent.MOUSE_MOVE,this.onSliding);
         controller.addEventListener(CafeUserEvent.LEVELUP,this.setButtons);
         controller.addEventListener(CafeChatEvent.ADD_MSG,this.onAddMsg);
         controller.addEventListener(CafeOtherUserEvent.OTHER_USER_JOIN,this.onJoinUser);
         controller.addEventListener(CafeOtherUserEvent.OTHER_USER_QUIT,this.onQuitUser);
         controller.addEventListener(CafeBuddyEvent.CHANGE_BUDDYDATA,this.onChangeBuddyData);
         disp.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onChangeFullscreen);
         this.changeView(this.VIEWSTATE_CHAT);
         BasicModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLLoadComplete);
         controller.addEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.onFontsLoaded);
         this.socialPanel.mc_language.visible = env.isLocal;
         this.choiceLanguageComponent = new CafeChoiceLanguageComponent(this.socialPanel.mc_language);
         this.choiceLanguageComponent.addLanguageButton(CafeModel.languageData);
         CafeModel.localData.readData();
         if(CafeModel.localData.readLoginDataLanguage() != "")
         {
            this.choiceLanguageComponent.setDefaultLanguage(CafeModel.localData.readLoginDataLanguage());
         }
         this.choiceLanguageComponent.selectetLanguageButton(env.language);
         this.choiceLanguageComponent.addEventListener(LanguageDataEvent.SELECT_LANGUAGE_COMPLETE,this.onClickLanguage);
         super.init();
      }
      
      private function onClickLanguage(param1:LanguageDataEvent) : void
      {
         var _loc2_:String = env.language;
         if(param1.selectedLanguage == "")
         {
            return;
         }
         if(param1.selectedLanguage == env.language)
         {
            return;
         }
         CafeModel.languageData.changeLanguage(param1.selectedLanguage);
         CafeModel.localData.saveLanguageData(param1.selectedLanguage);
      }
      
      private function onLanguageXMLLoadComplete(param1:Event) : void
      {
         CafeLanguageFontManager.getInstance().initFontSwf();
      }
      
      override protected function onFontsLoaded(param1:LanguageDataEvent) : void
      {
         super.onFontsLoaded(param1);
         var _loc2_:int = layoutManager.currentState;
         layoutManager.clearAllLayoutContent();
         layoutManager.state = _loc2_;
      }
      
      private function setButtons(param1:Event = null) : void
      {
         if(this.socialPanel.btn_findbuddies.visible)
         {
            if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_ADDFRIEND)
            {
               this.socialPanel.btn_findbuddies.enableButton = false;
               this.socialPanel.btn_findbuddies.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_ADDFRIEND]);
            }
            else
            {
               this.socialPanel.btn_findbuddies.enableButton = true;
               this.socialPanel.btn_findbuddies.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.socialPanel.btn_findbuddies.name);
            }
         }
      }
      
      private function onChangeFullscreen(param1:FullScreenEvent) : void
      {
         this.socialPanel.mc_chatcontent.chatblocked.visible = param1.fullScreen;
      }
      
      private function onChangeBuddyData(param1:CafeBuddyEvent) : void
      {
         if(this.currentView == this.VIEWSTATE_FRIENDS)
         {
            this.fillPlayerList();
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeChatEvent.ADD_MSG,this.onAddMsg);
         controller.removeEventListener(CafeUserEvent.LEVELUP,this.setButtons);
         controller.removeEventListener(CafeOtherUserEvent.OTHER_USER_JOIN,this.onJoinUser);
         controller.removeEventListener(CafeOtherUserEvent.OTHER_USER_QUIT,this.onQuitUser);
         this.choiceLanguageComponent.removeEventListener(LanguageDataEvent.SELECT_LANGUAGE_COMPLETE,this.onClickLanguage);
         BasicModel.languageData.removeEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLLoadComplete);
         controller.removeEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.onFontsLoaded);
         disp.stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onChangeFullscreen);
      }
      
      private function changeView(param1:int) : void
      {
         this.currentView = param1;
         this.socialPanel.mc_chatcontent.visible = this.currentView == this.VIEWSTATE_CHAT;
         this.socialPanel.mc_playerlistcontent.visible = this.currentView == this.VIEWSTATE_PLAYER || this.currentView == this.VIEWSTATE_FRIENDS;
         switch(this.currentView)
         {
            case this.VIEWSTATE_PLAYER:
               this.socialPanel.mc_playerlistcontent.txt_noplayer.text = [CafeModel.languageData.getTextById("panelwin_social_noplayerincafe")];
               break;
            case this.VIEWSTATE_FRIENDS:
               this.socialPanel.mc_playerlistcontent.txt_noplayer.text = [CafeModel.languageData.getTextById("panelwin_social_noingamefriends")];
         }
         this.currentPlayerPage = 0;
         this.fillPlayerList();
      }
      
      override protected function updateTextField(param1:TextField) : void
      {
         if(param1 == this.socialPanel.mc_chatcontent.txt_chatmsg && !CafeLanguageFontManager.getInstance().useDefaultFont)
         {
            param1.embedFonts = false;
         }
         else
         {
            super.updateTextField(param1);
         }
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         if(disp && disp.stage)
         {
            _loc1_ = disp.getBounds(null);
            disp.y = disp.stage.stageHeight;
            if(env.hasNetworkBuddies)
            {
               disp.y -= CafeBuddylistPanel.BUDDY_PANEL_HEIGHT;
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         if(!(param1.target is BasicButton) || !(param1.target as BasicButton).enabled)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.socialPanel.btn_buddies:
               this.changeView(this.VIEWSTATE_FRIENDS);
               break;
            case this.socialPanel.btn_buddiesincafe:
               this.changeView(this.VIEWSTATE_PLAYER);
               break;
            case this.socialPanel.btn_chat:
               this.changeView(this.VIEWSTATE_CHAT);
               break;
            case this.socialPanel.btn_findbuddies:
               layoutManager.showDialog(CafeInviteFriendDialog.NAME,new CafeInviteFriendDialogProperties(CafeModel.languageData.getTextById("alert_invitefriend_title"),CafeModel.languageData.getTextById("alert_invitefriend_copy"),this.onClickInviteFriend,null,CafeModel.languageData.getTextById("btn_text_okay"),CafeModel.languageData.getTextById("btn_text_cancle")));
               break;
            case this.socialPanel.mc_chatcontent.btn_addmsg:
               this.onSendMsg();
               break;
            case this.socialPanel.mc_chatcontent.btn_up:
               this.onScrollUp();
               break;
            case this.socialPanel.mc_chatcontent.btn_down:
               this.onScrollDown();
               break;
            case this.socialPanel.mc_playerlistcontent.btn_left:
            case this.socialPanel.mc_playerlistcontent.btn_right:
               this.onClickArrow(param1);
               break;
            case this.socialPanel.mc_playerlistcontent.mc_buddy0:
            case this.socialPanel.mc_playerlistcontent.mc_buddy1:
            case this.socialPanel.mc_playerlistcontent.mc_buddy2:
            case this.socialPanel.mc_playerlistcontent.mc_buddy3:
               this.onClickPlayer(param1.target as playerlistitem);
         }
      }
      
      private function onClickPlayer(param1:playerlistitem) : void
      {
         if(param1 && param1.playerVO)
         {
            if(param1.playerVO.hasOwnProperty("allowFriendRequest"))
            {
               layoutManager.playerActionChoices.initPlayerActionChoices(param1,param1.playerVO as IPlayerVO,0,param1.playerVO.allowFriendRequest);
            }
            else
            {
               layoutManager.playerActionChoices.initPlayerActionChoices(param1,param1.playerVO as IPlayerVO,0,true);
            }
         }
      }
      
      private function onJoinUser(param1:CafeOtherUserEvent) : void
      {
         if(param1.userJoined)
         {
            if(CafeModel.levelData.levelVO.worldType != CafeConstants.CAFE_WORLD_TYPE_MARKETPLACE)
            {
               this.writeNewMsg(param1.user.userId,param1.user.playerId,param1.user.playerName,CafeModel.languageData.getTextById("panelwin_social_comein"),false);
            }
         }
         this.fillPlayerList();
      }
      
      private function onQuitUser(param1:CafeOtherUserEvent) : void
      {
         if(CafeModel.levelData.levelVO.worldType != CafeConstants.CAFE_WORLD_TYPE_MARKETPLACE)
         {
            this.writeNewMsg(param1.user.userId,param1.user.playerId,param1.user.playerName,CafeModel.languageData.getTextById("panelwin_social_goout"),false);
         }
         this.fillPlayerList();
      }
      
      private function onClickInviteFriend(param1:Array) : void
      {
         controller.inviteFriend(param1);
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         switch(param1.target)
         {
            case this.socialPanel.mc_chatcontent.txt_chatmsg:
               if(param1.keyCode == Keyboard.ENTER)
               {
                  this.onSendMsg();
               }
         }
      }
      
      private function onSendMsg() : void
      {
         if(this.socialPanel.mc_chatcontent.txt_chatmsg.text == "/clientversion")
         {
            this.writeNewMsg(CafeModel.userData.userID,CafeModel.userData.playerID,"Version",env.versionText);
            this.socialPanel.mc_chatcontent.txt_chatmsg.text = "";
            return;
         }
         if(env.isLocal && this.socialPanel.mc_chatcontent.txt_chatmsg.text == "/lvlup")
         {
            CafeModel.userData.levelUp(1);
         }
         if(CafeModel.userData.userLevel < 1 || CafeModel.userData.isGuest())
         {
            this.writeNewMsg(-1,-1,CafeModel.languageData.getTextById("panelwin_social_bot"),CafeModel.languageData.getTextById("panelwin_social_writeable"));
         }
         else if(this.socialPanel.mc_chatcontent.txt_chatmsg.text.length > 0)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_CHAT,[TextValide.getValideSmartFoxText(this.socialPanel.mc_chatcontent.txt_chatmsg.text)]);
         }
         this.socialPanel.mc_chatcontent.txt_chatmsg.text = "";
      }
      
      private function onScrollDown() : void
      {
         if(this.chatHeight > this.socialPanel.mc_chatcontent.mc_mask.height)
         {
            this.socialPanel.mc_chatcontent.mc_textholder.y = Math.max(-(this.chatHeight - this.socialPanel.mc_chatcontent.mc_mask.height),this.socialPanel.mc_chatcontent.mc_textholder.y - 13);
         }
         this.updateSlider();
      }
      
      private function onScrollUp() : void
      {
         this.socialPanel.mc_chatcontent.mc_textholder.y = Math.min(0,this.socialPanel.mc_chatcontent.mc_textholder.y + 13);
         this.updateSlider();
      }
      
      private function scrollToEnd() : void
      {
         if(this.chatHeight > this.socialPanel.mc_chatcontent.mc_mask.height)
         {
            this.socialPanel.mc_chatcontent.mc_textholder.y = -(this.chatHeight - this.socialPanel.mc_chatcontent.mc_mask.height);
            this.enableButtons(true);
         }
         this.updateSlider();
      }
      
      private function enableButtons(param1:Boolean) : void
      {
         this.socialPanel.mc_chatcontent.btn_slider.enableButton = param1;
         this.socialPanel.mc_chatcontent.btn_up.enableButton = param1;
         this.socialPanel.mc_chatcontent.btn_down.enableButton = param1;
      }
      
      private function onSliding(param1:MouseEvent) : void
      {
         if(!param1.buttonDown || this.chatHeight <= this.socialPanel.mc_chatcontent.mc_mask.height)
         {
            return;
         }
         var _loc2_:int = this.socialPanel.mc_chatcontent.btn_slider.y + param1.localY;
         if(_loc2_ < this.socialPanel.mc_chatcontent.mc_slidebar.height + this.socialPanel.mc_chatcontent.mc_slidebar.y && _loc2_ > this.socialPanel.mc_chatcontent.mc_slidebar.y)
         {
            this.socialPanel.mc_chatcontent.btn_slider.y = _loc2_;
         }
         var _loc3_:int = this.socialPanel.mc_chatcontent.btn_slider.y - this.socialPanel.mc_chatcontent.mc_slidebar.y;
         var _loc4_:int = this.socialPanel.mc_chatcontent.mc_slidebar.height;
         var _loc5_:int = 100 - (_loc4_ - _loc3_) / _loc4_ * 100;
         this.socialPanel.mc_chatcontent.mc_textholder.y = -(this.chatHeight - this.socialPanel.mc_chatcontent.mc_mask.height) * _loc5_ / 100;
      }
      
      private function updateSlider() : void
      {
         if(this.chatHeight < this.socialPanel.mc_chatcontent.mc_mask.height)
         {
            return;
         }
         var _loc1_:int = this.socialPanel.mc_chatcontent.mc_textholder.y;
         var _loc2_:int = -(this.chatHeight - this.socialPanel.mc_chatcontent.mc_mask.height);
         var _loc3_:int = 100 - (_loc2_ - _loc1_) / _loc2_ * 100;
         this.socialPanel.mc_chatcontent.btn_slider.y = this.socialPanel.mc_chatcontent.mc_slidebar.y + this.socialPanel.mc_chatcontent.mc_slidebar.height * _loc3_ / 100;
      }
      
      private function onAddMsg(param1:CafeChatEvent) : void
      {
         var _loc2_:OtherplayerMovingVO = null;
         if(param1.userId == ADMIN_MSG)
         {
            this.writeNewMsg(ADMIN_MSG,ADMIN_MSG,CafeModel.languageData.getTextById("generic_admin"),param1.msg);
         }
         else
         {
            _loc2_ = CafeModel.otherUserData.getUserByUserId(param1.userId);
            if(!_loc2_.isMute)
            {
               this.writeNewMsg(_loc2_.userId,_loc2_.playerId,_loc2_.playerName,param1.msg);
            }
         }
      }
      
      private function writeNewMsg(param1:int, param2:int, param3:String, param4:String, param5:Boolean = true) : void
      {
         var _loc6_:ChatNameText = new ChatNameText();
         var _loc7_:ChatMsgText = new ChatMsgText();
         if(CafeLanguageFontManager.getInstance().useDefaultFont)
         {
            CafeLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.txt_msg);
            CafeLanguageFontManager.getInstance().changeFontByLanguage(_loc7_.txt_msg);
         }
         else
         {
            _loc6_.txt_msg.embedFonts = false;
            _loc7_.txt_msg.embedFonts = false;
         }
         _loc6_.txt_msg.text = param3 + CafeModel.languageData.getTextById("panelwin_social_say");
         _loc6_.txt_msg.width = _loc6_.txt_msg.textWidth + 5;
         _loc6_.txt_msg.height = _loc6_.txt_msg.textHeight + 5;
         if(param5 && (param1 > 0 && param1 != CafeModel.userData.userID))
         {
            _loc6_.mouseChildren = false;
            _loc6_.userId = param1;
            _loc6_.playerId = param2;
            _loc6_.addEventListener(MouseEvent.CLICK,this.onClickNameField);
         }
         _loc7_.mouseEnabled = false;
         _loc7_.mouseChildren = false;
         var _loc8_:TextFormat;
         (_loc8_ = _loc7_.txt_msg.defaultTextFormat).indent = _loc6_.txt_msg.width;
         _loc7_.txt_msg.defaultTextFormat = _loc8_;
         if(param1 == ADMIN_MSG)
         {
            _loc7_.txt_msg.textColor = 16711680;
         }
         else
         {
            _loc7_.txt_msg.textColor = 0;
         }
         _loc7_.txt_msg.text = param4;
         _loc7_.txt_msg.width = this.socialPanel.mc_chatcontent.mc_mask.width;
         _loc7_.txt_msg.height = _loc7_.txt_msg.textHeight + 5;
         _loc7_.y = _loc6_.y = this.socialPanel.mc_chatcontent.mc_textholder.height;
         this.socialPanel.mc_chatcontent.mc_textholder.addChild(_loc7_);
         this.socialPanel.mc_chatcontent.mc_textholder.addChild(_loc6_);
         this.chatHeight = this.socialPanel.mc_chatcontent.mc_textholder.height;
         this.scrollToEnd();
      }
      
      override protected function onCursorOver(param1:MouseEvent) : void
      {
         super.onCursorOver(param1);
         if(param1.target is ChatNameText)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
      }
      
      override protected function onCursorOut(param1:MouseEvent) : void
      {
         super.onCursorOut(param1);
         if(param1.target is ChatNameText)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.socialPanel.txt_version.text = env.versionText + "i" + env.currentInstance;
         this.socialPanel.txt_version.visible = env.showVersion;
         while(this.socialPanel.mc_chatcontent.mc_textholder.numChildren > 0)
         {
            this.socialPanel.mc_chatcontent.mc_textholder.removeChildAt(0);
         }
         this.socialPanel.mc_chatcontent.mc_textholder.y = 0;
         if(CafeModel.levelData.levelVO.worldType == CafeConstants.CAFE_WORLD_TYPE_MARKETPLACE)
         {
            this.writeNewMsg(-1,-1,CafeModel.languageData.getTextById("panelwin_social_bot"),CafeModel.languageData.getTextById("panelwin_social_welcome_marketplace"));
         }
         else
         {
            this.writeNewMsg(-1,-1,CafeModel.languageData.getTextById("panelwin_social_bot"),CafeModel.languageData.getTextById("panelwin_social_welcome_mycafe"));
         }
         this.fillPlayerList();
      }
      
      private function onClickNameField(param1:MouseEvent) : void
      {
         var _loc2_:ChatNameText = param1.target as ChatNameText;
         var _loc3_:OtherplayerMovingVO = CafeModel.otherUserData.getUserByUserId(_loc2_.userId);
         if(_loc3_)
         {
            this._reportPlayerUserId = _loc2_.userId;
            layoutManager.showDialog(CafeReportPlayerDialog.NAME,new CafeReportPlayerDialogProperties(this._reportPlayerUserId,_loc3_.playerName));
         }
      }
      
      private function fillPlayerList() : void
      {
         var _loc6_:playerlistitem = null;
         var _loc7_:IPlayerVO = null;
         var _loc8_:Sprite = null;
         var _loc9_:Rectangle = null;
         var _loc1_:Boolean = true;
         var _loc2_:int = this.currentPlayerPage * this.itemsPerPage;
         var _loc3_:int = _loc2_;
         var _loc4_:Array = [];
         switch(this.currentView)
         {
            case this.VIEWSTATE_FRIENDS:
               _loc4_ = CafeModel.buddyList.ingameBuddyList;
               break;
            case this.VIEWSTATE_PLAYER:
               _loc4_ = CafeModel.otherUserData.getPlayerArray();
         }
         this.initArrows(_loc4_.length);
         var _loc5_:int = 0;
         while(_loc5_ < this.itemsPerPage)
         {
            (_loc6_ = this.socialPanel.mc_playerlistcontent["mc_buddy" + _loc5_] as playerlistitem).mouseChildren = false;
            _loc6_.useHandCursor = true;
            _loc6_.buttonMode = true;
            if(_loc3_ < _loc4_.length)
            {
               _loc7_ = _loc4_[_loc3_];
               _loc6_.visible = true;
               _loc6_.playerVO = _loc7_;
               _loc6_.txt_name.text = _loc7_.playerName;
               _loc6_.txt_lvl.text = String(CafeModel.userData.getLevelByXp(_loc7_.playerXp));
               while(_loc6_.mc_holder.numChildren > 0)
               {
                  _loc6_.mc_holder.removeChildAt(0);
               }
               _loc9_ = (_loc8_ = CreateAvatarHelper.createAvatar(_loc7_.avatarParts)).getBounds(null);
               _loc8_.x = -(_loc9_.width * SCALE_FACTOR / 2 + _loc9_.left * SCALE_FACTOR);
               _loc8_.y = -(_loc9_.top * SCALE_FACTOR) - 40;
               _loc8_.scaleX = _loc8_.scaleY = SCALE_FACTOR;
               _loc6_.mc_holder.addChild(_loc8_);
               _loc1_ = false;
            }
            else
            {
               _loc6_.visible = false;
               _loc6_.userId = -1;
            }
            _loc3_++;
            _loc5_++;
         }
         if(_loc4_.length > 0 && _loc1_)
         {
            --this.currentPlayerPage;
            this.fillPlayerList();
         }
         else
         {
            this.socialPanel.mc_playerlistcontent.txt_noplayer.visible = _loc1_;
         }
      }
      
      private function initArrows(param1:int) : void
      {
         this.maxPage = (param1 - 1) / this.itemsPerPage;
         this.socialPanel.mc_playerlistcontent.btn_right.visible = this.maxPage > 0 && this.currentPlayerPage < this.maxPage;
         this.socialPanel.mc_playerlistcontent.btn_left.visible = this.maxPage > 0 && this.currentPlayerPage > 0;
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this.currentPlayerPage;
         if(param1.target == this.socialPanel.mc_playerlistcontent.btn_left)
         {
            this.currentPlayerPage = Math.max(0,this.currentPlayerPage - 1);
         }
         else
         {
            this.currentPlayerPage = Math.min(this.maxPage,this.currentPlayerPage + 1);
         }
         if(_loc2_ != this.currentPlayerPage)
         {
            this.fillPlayerList();
         }
      }
      
      protected function get socialPanel() : SocialPanel
      {
         return disp as SocialPanel;
      }
   }
}
