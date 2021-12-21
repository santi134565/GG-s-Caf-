package com.goodgamestudios.cafe.view.dialogs
{
   import com.adobe.utils.StringUtil;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicRegisterDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.panels.CafeLoginPanel;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.avatar.BasicAvatarVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.constants.CommonGameStates;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
   public class CafeRegisterDialog extends CafeDialog
   {
      
      public static const NAME:String = CommonDialogNames.RegisterDialog_NAME;
       
      
      private var preset_name:String;
      
      private const PRESET_MAIL:String = "Cafe@GoodgameStudios.com";
      
      private const PRESET_PASS:String = "%%%%%%";
      
      private const SENDTHISIFWRONG:String = ".";
      
      private var isWaitingForServerMessage:Boolean;
      
      private var nameSelectionToolTip:CafeAvatarNameSelectionDialog;
      
      public function CafeRegisterDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.registerDial.passwordInput.inputField.displayAsPassword = true;
         this.registerDial.nameInput.inputField.tabIndex = 1;
         this.registerDial.emailInput.inputField.tabIndex = 2;
         this.registerDial.passwordInput.inputField.tabIndex = 3;
         controller.addEventListener(BasicUserEvent.REGISTERED,this.onRegisterCompleted);
         controller.addEventListener(CafeUserEvent.REGISTER_ERROR,this.onRegisterError);
         controller.addEventListener(CafeUserEvent.CHANGE_AVATAR,this.addAvatar);
         controller.addEventListener(CafeDialogEvent.SELECT_NAME,this.onSelectName);
         layoutManager.hidePanel(CafeLoginPanel.NAME);
         super.init();
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(BasicUserEvent.REGISTERED,this.onRegisterCompleted);
         controller.removeEventListener(CafeUserEvent.REGISTER_ERROR,this.onRegisterError);
         controller.removeEventListener(CafeUserEvent.CHANGE_AVATAR,this.addAvatar);
         controller.removeEventListener(CafeDialogEvent.SELECT_NAME,this.onSelectName);
         this.registerDial.nameInput.inputField.removeEventListener(TextEvent.TEXT_INPUT,this.onNameChange);
         this.registerDial.passwordInput.inputField.removeEventListener(TextEvent.TEXT_INPUT,this.onPasswordChange);
         this.registerDial.emailInput.inputField.removeEventListener(TextEvent.TEXT_INPUT,this.onMailChange);
         this.registerDial.nameInput.inputField.removeEventListener(FocusEvent.FOCUS_IN,this.onNameClick);
         this.registerDial.passwordInput.inputField.removeEventListener(FocusEvent.FOCUS_IN,this.onPassClick);
         this.registerDial.emailInput.inputField.removeEventListener(FocusEvent.FOCUS_IN,this.onMailClick);
         super.destroy();
      }
      
      override protected function applyProperties() : void
      {
         this.isWaitingForServerMessage = false;
         if(properties)
         {
            if(this.registerDialogProperties.username)
            {
               this.registerDial.emailInput.inputField.text = this.registerDialogProperties.username;
            }
            if(this.registerDialogProperties.password)
            {
               this.registerDial.passwordInput.inputField.text = this.registerDialogProperties.password;
            }
            else
            {
               this.registerDial.passwordInput.inputField.text = this.PRESET_PASS;
            }
            this.registerDial.emailInput.inputField.text = this.PRESET_MAIL;
         }
         else
         {
            this.registerDial.emailInput.inputField.text = this.PRESET_MAIL;
            this.registerDial.passwordInput.inputField.text = this.PRESET_PASS;
         }
         this.registerDial.nameInput.inputField.text = CafeModel.userData.userName;
         this.preset_name = CafeModel.userData.userName;
         this.registerDial.btn_facebook.visible = false;
         this.registerDial.btn_facebook.toolTipText = CafeModel.languageData.getTextById("generic_login_facebook");
         this.colorCheckAllTextFields();
         this.registerDial.btn_agb.deselected();
         this.registerDial.btn_login.label = CafeModel.languageData.getTextById("generic_register_btn_save");
         if(properties is CafeRegisterDialogProperties && (properties as CafeRegisterDialogProperties).unlockFunctions)
         {
            this.registerDial.txt_copy.text = CafeModel.languageData.getTextById("generic_register_unlock");
         }
         else
         {
            this.registerDial.txt_copy.text = CafeModel.languageData.getTextById("generic_register_copy_1");
         }
         if(properties is CafeRegisterDialogProperties && (properties as CafeRegisterDialogProperties).showLogoutButton)
         {
            this.registerDial.btn_logout.visible = true;
            this.registerDial.btn_logout.label = CafeModel.languageData.getTextById("generic_logout");
         }
         else
         {
            this.registerDial.btn_logout.label = CafeModel.languageData.getTextById("generic_register_btn_later");
         }
         this.registerDial.txt_title.text = CafeModel.languageData.getTextById("generic_register_letsgo");
         this.registerDial.txt_name.text = CafeModel.languageData.getTextById("dialogwin_highscore_name");
         this.registerDial.txt_mail.text = CafeModel.languageData.getTextById("dialogwin_register_mail");
         this.registerDial.txt_password.text = CafeModel.languageData.getTextById("dialogwin_register_password");
         this.registerDial.btn_agbs.label = CafeModel.languageData.getTextById("dialogwin_register_agbs");
         this.registerDial.txt_alert_email.text = CafeModel.languageData.getTextById("alert_register_email_copy");
         this.registerDial.txt_alert_password.text = CafeModel.languageData.getTextById("alert_register_password_copy");
         this.registerDial.mc_banner.txt_label.text = CafeModel.languageData.getTextById("generic_register_forfree1");
         this.registerDial.btn_agb.x = this.registerDial.btn_agbs.x - this.registerDial.btn_agbs.width / 2 - 20;
         this.registerDial.mc_agbarrow.x = this.registerDial.btn_agb.x - 10;
         this.registerDial.mc_agbarrow.visible = this.registerDial.txt_alert_password.visible = this.registerDial.txt_alert_email.visible = false;
         this.registerDial.nameInput.inputField.stage.focus = this.registerDial.nameInput.inputField;
         this.registerDial.nameInput.inputField.setSelection(this.registerDial.nameInput.inputField.text.length,this.registerDial.nameInput.inputField.text.length);
         this.registerDial.nameInput.inputField.addEventListener(TextEvent.TEXT_INPUT,this.onNameChange);
         this.registerDial.nameInput.inputField.addEventListener(FocusEvent.FOCUS_IN,this.onNameClick);
         this.registerDial.passwordInput.inputField.addEventListener(TextEvent.TEXT_INPUT,this.onPasswordChange);
         this.registerDial.passwordInput.inputField.addEventListener(FocusEvent.FOCUS_IN,this.onPassClick);
         this.registerDial.emailInput.inputField.addEventListener(TextEvent.TEXT_INPUT,this.onMailChange);
         this.registerDial.emailInput.inputField.addEventListener(FocusEvent.FOCUS_IN,this.onMailClick);
         if(CafeModel.userData && CafeModel.userData.avatarParts)
         {
            this.addAvatar(null);
         }
         if(!this.isLoggedIn)
         {
            this.registerDial.btn_close.visible = false;
            this.registerDial.txt_copy.visible = false;
            if(env.campainVars.isValid())
            {
               this.registerDial.btn_logout.visible = false;
            }
         }
         else if(!(this.registerDialogProperties is CafeRegisterDialogProperties) || !(this.registerDialogProperties as CafeRegisterDialogProperties).showLogoutButton)
         {
            this.registerDial.btn_logout.visible = false;
         }
      }
      
      private function onNameClick(param1:Event = null) : void
      {
         if(this.registerDial.nameInput.inputField.text == this.preset_name)
         {
            this.registerDial.nameInput.inputField.text = "";
         }
      }
      
      private function onMailClick(param1:Event = null) : void
      {
         if(this.registerDial.emailInput.inputField.text == this.PRESET_MAIL)
         {
            this.registerDial.emailInput.inputField.text = "";
         }
      }
      
      private function onPassClick(param1:Event = null) : void
      {
         if(this.registerDial.passwordInput.inputField.text == this.PRESET_PASS)
         {
            this.registerDial.passwordInput.inputField.text = "";
         }
      }
      
      private function onNameChange(param1:Event) : void
      {
         this.colorTextField(this.registerDial.nameInput.inputField,true);
      }
      
      private function onPasswordChange(param1:Event) : void
      {
         this.colorTextField(this.registerDial.passwordInput.inputField,true);
      }
      
      private function onMailChange(param1:Event) : void
      {
         this.colorTextField(this.registerDial.emailInput.inputField,true);
      }
      
      private function colorCheckAllTextFields() : void
      {
         this.colorTextField(this.registerDial.nameInput.inputField,this.registerDial.nameInput.inputField.text != this.preset_name);
         this.colorTextField(this.registerDial.emailInput.inputField,this.registerDial.emailInput.inputField.text != this.PRESET_MAIL);
         this.colorTextField(this.registerDial.passwordInput.inputField,this.registerDial.passwordInput.inputField.text != this.PRESET_PASS);
      }
      
      private function colorTextField(param1:TextField, param2:Boolean) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         if(param2)
         {
            _loc3_.color = 0;
         }
         else
         {
            _loc3_.color = 7829367;
         }
         param1.setTextFormat(_loc3_);
         param1.defaultTextFormat = _loc3_;
      }
      
      private function addAvatar(param1:CafeUserEvent) : void
      {
         while(this.registerDial.mc_avatarholder.numChildren > 0)
         {
            this.registerDial.mc_avatarholder.removeChildAt(0);
         }
         var _loc2_:Sprite = CreateAvatarHelper.createAvatar(CafeModel.userData.avatarParts);
         _loc2_.scaleX = _loc2_.scaleY = 2;
         this.registerDial.mc_avatarholder.addChild(_loc2_);
         this.registerDial.mc_avatarholder.mouseChildren = false;
      }
      
      private function onSelectName(param1:CafeDialogEvent) : void
      {
         var _loc2_:String = !!param1.params ? param1.params.shift() : "";
         this.registerDial.nameInput.inputField.text = _loc2_;
         this.resetHelp();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var url:String = null;
         var urlRequest:URLRequest = null;
         var event:MouseEvent = param1;
         super.onClick(event);
         this.colorCheckAllTextFields();
         switch(event.target)
         {
            case this.registerDial.btn_login:
               this.onLogin();
               break;
            case this.registerDial.btn_close:
               this.hide();
               break;
            case this.registerDial.nameInput:
            case this.registerDial.nameInput.inputField:
               this.onNameClick();
               break;
            case this.registerDial.emailInput:
            case this.registerDial.emailInput.inputField:
               this.onMailClick();
               break;
            case this.registerDial.passwordInput:
            case this.registerDial.passwordInput.inputField:
               this.onPassClick();
               break;
            case this.registerDial.btn_agb:
               if(this.registerDial.btn_agb.isSelected)
               {
                  this.registerDial.btn_agb.deselected();
               }
               else
               {
                  this.registerDial.btn_agb.selected();
               }
               this.registerDial.mc_agbarrow.visible = false;
               break;
            case this.registerDial.mc_avatarholder:
               CafeModel.userData.userName = this.registerDial.nameInput.inputField.text;
               layoutManager.showDialog(CafeAvatarChangeDialog.NAME);
               break;
            case this.registerDial.btn_logout:
               this.hide();
               if(!this.isLoggedIn)
               {
                  controller.sendServerMessageAndWait(SFConstants.C2S_CREATE_AVATAR,[CafeModel.userData.userName + "+" + CafeModel.userData.gender + "+" + this.parsAvatarArray(CafeModel.userData.avatarParts),0,CafeModel.smartfoxClient.connectionTime,CafeModel.smartfoxClient.roundTripTime],SFConstants.S2C_CREATE_AVATAR);
               }
               else
               {
                  CommandController.instance.executeCommand(BasicController.COMMAND_LOGOUT);
               }
               break;
            case this.registerDial.btn_agbs:
               try
               {
                  url = env.language == "de" ? env.urlAgb_de : env.urlAgb_otherlanguage;
                  urlRequest = new URLRequest(url);
                  navigateToURL(urlRequest,"goodgamestudios");
               }
               catch(e:Error)
               {
               }
         }
      }
      
      private function parsAvatarArray(param1:Array) : String
      {
         var _loc3_:BasicAvatarVO = null;
         var _loc2_:* = "";
         for each(_loc3_ in param1)
         {
            if(_loc2_.length > 0)
            {
               _loc2_ += "#";
            }
            _loc2_ += _loc3_.wodId + "$" + _loc3_.currentColor;
         }
         return _loc2_;
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         switch(param1.target)
         {
            case this.registerDial.emailInput.inputField:
            case this.registerDial.passwordInput.inputField:
               if(param1.keyCode == Keyboard.ENTER)
               {
                  this.onLogin();
               }
         }
      }
      
      private function onShowNameselection(param1:CafeDialogEvent) : void
      {
         if(this.nameSelectionToolTip == null)
         {
            this.nameSelectionToolTip = new CafeAvatarNameSelectionDialog(new CafeAvatarNameSelection());
            this.registerDial.nameInput.addChild(this.nameSelectionToolTip.disp);
         }
         this.nameSelectionToolTip.showNames(param1.params);
         this.registerDial.mc_agbarrow.visible = false;
      }
      
      private function resetHelp() : void
      {
         this.registerDial.btn_login.enableButton = true;
         if(this.nameSelectionToolTip)
         {
            this.nameSelectionToolTip.hide();
         }
      }
      
      private function onRegisterError(param1:CafeUserEvent) : void
      {
         var _loc2_:int = param1.params.shift();
         var _loc3_:String = "";
         switch(_loc2_)
         {
            case 93:
               param1.params = param1.params[0];
               param1.params.shift();
               _loc3_ = param1.params.shift();
               layoutManager.showDialog(CafeAvatarNameSelectionDialog.NAME,new CafeAvatarNameSelectionDialogProperties(param1.params.shift().split("#"),_loc3_));
               break;
            case 100:
            case 18:
            case 12:
               param1.params[0].shift();
               layoutManager.showDialog(CafeAvatarNameSelectionDialog.NAME,new CafeAvatarNameSelectionDialogProperties(param1.params.shift().shift().split("#")));
               break;
            case 98:
               this.registerDial.mc_agbarrow.visible = true;
               break;
            case 96:
               this.registerDial.txt_alert_password.text = CafeModel.languageData.getTextById("generic_register_passwordshort_copy");
               this.registerDial.txt_alert_password.visible = true;
               break;
            case 101:
            case 10:
               this.registerDial.txt_alert_password.text = CafeModel.languageData.getTextById("generic_register_password_copy");
               this.registerDial.txt_alert_password.visible = true;
               break;
            case 94:
               this.registerDial.txt_alert_email.text = CafeModel.languageData.getTextById("generic_register_emaillong_copy");
               this.registerDial.txt_alert_email.visible = true;
               break;
            case 14:
               this.registerDial.txt_alert_email.text = CafeModel.languageData.getTextById("generic_register_emailwrong_copy");
               this.registerDial.txt_alert_email.visible = true;
               break;
            case 13:
               this.registerDial.txt_alert_email.text = CafeModel.languageData.getTextById("generic_register_error_accountalreadyexists");
               this.registerDial.txt_alert_email.visible = true;
               break;
            case 95:
               this.registerDial.txt_alert_email.text = CafeModel.languageData.getTextById("generic_register_emailwrong_copy");
               this.registerDial.txt_alert_email.visible = true;
         }
      }
      
      private function onLogin() : void
      {
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         var _loc1_:String = this.registerDial.nameInput.inputField.text;
         var _loc2_:String = this.registerDial.emailInput.inputField.text;
         var _loc3_:String = this.registerDial.passwordInput.inputField.text;
         var _loc4_:int = 0;
         this.registerDial.mc_agbarrow.visible = this.registerDial.txt_alert_password.visible = this.registerDial.txt_alert_email.visible = false;
         if(!TextValide.isSmartFoxValide(_loc2_) || _loc2_ == "" || _loc2_ == this.PRESET_MAIL)
         {
            _loc2_ = this.SENDTHISIFWRONG;
         }
         if(!TextValide.isSmartFoxValide(_loc3_) || _loc3_ == "" || _loc3_ == this.PRESET_PASS)
         {
            _loc3_ = this.SENDTHISIFWRONG;
         }
         if(!TextValide.isSmartFoxValide(_loc1_) || _loc1_ == "")
         {
            _loc1_ = this.SENDTHISIFWRONG;
         }
         if(!this.registerDial.btn_agb.isSelected)
         {
            _loc4_ = 0;
         }
         else
         {
            _loc4_ = 1;
         }
         this.isWaitingForServerMessage = true;
         var _loc5_:Object = {
            "email":StringUtil.trim(_loc2_),
            "password":StringUtil.trim(_loc3_),
            "username":StringUtil.trim(_loc1_),
            "agbs":_loc4_
         };
         CommandController.instance.executeCommand(BasicController.COMMAND_REGISTER_USER,_loc5_);
      }
      
      override public function show() : void
      {
         env.gameState = layoutManager.currentState == BasicLayoutManager.STATE_LOGIN ? CommonGameStates.REGISTER_DIAL : CommonGameStates.REGISTER_DIAL_INGAME;
         super.show();
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_REGISTER)
         {
            this.isWaitingForServerMessage = false;
         }
      }
      
      private function onRegisterCompleted(param1:BasicUserEvent) : void
      {
         CafeModel.localData.saveLoginData(this.registerDial.nameInput.inputField.text,this.registerDial.passwordInput.inputField.text,true);
         this.hide();
      }
      
      override public function hide() : void
      {
         super.hide();
         this.destroy();
      }
      
      private function get isLoggedIn() : Boolean
      {
         return layoutManager.isoScreen.isoWorld && CafeModel.levelData.levelVO;
      }
      
      protected function get registerDialogProperties() : BasicRegisterDialogProperties
      {
         return properties as BasicRegisterDialogProperties;
      }
      
      protected function get registerDial() : CafeRegisterNew
      {
         return disp as CafeRegisterNew;
      }
   }
}
