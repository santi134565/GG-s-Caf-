package com.goodgamestudios.cafe.view.panels
{
   import com.adobe.utils.StringUtil;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeLevelEvent;
   import com.goodgamestudios.cafe.event.CafePanelEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeChoiceLanguageComponent;
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarCreationDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarCreationDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeLostPasswordDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeLostPasswordDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialog;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   
   public class CafeLoginPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeLogin";
       
      
      private var choiceLanguageComponent:CafeChoiceLanguageComponent;
      
      private var lastLanguage:String;
      
      private var isWaitingForServerMessage:Boolean;
      
      private var preset_name:String = "";
      
      private var preset_pass:String = "";
      
      public function CafeLoginPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         CafeModel.localData.readData();
         this.lastLanguage = CafeModel.localData.readLoginDataLanguage();
         this.cafeLogin.loginName.inputField.text = CafeModel.localData.readLoginDataUsername();
         this.cafeLogin.loginPassword.inputField.text = CafeModel.localData.readLoginDataPass();
         this.cafeLogin.loginPassword.inputField.displayAsPassword = true;
         this.cafeLogin.btn_play.minWidth = 200;
         this.cafeLogin.loginName.inputField.tabIndex = 10;
         this.cafeLogin.loginPassword.inputField.tabIndex = 11;
         if(CafeModel.localData.readLoginDataSave())
         {
            this.cafeLogin.btn_checkData.selected();
         }
         else
         {
            this.cafeLogin.btn_checkData.deselected();
         }
         this.cafeLogin.btn_facebook.visible = false;
         this.choiceLanguageComponent = new CafeChoiceLanguageComponent(this.cafeLogin.mc_language);
         this.choiceLanguageComponent.addLanguageButton(CafeModel.languageData);
         controller.addEventListener(CafeLevelEvent.INIT_LEVELDATA,this.onLoggedIn);
         controller.addEventListener(CafeUserEvent.INIT_USERDATA,this.onLoggedIn);
         controller.addEventListener(CafeUserEvent.TRY_LOGIN,this.enableTextFields);
         controller.addEventListener(CafePanelEvent.TEASER_ON_LOGINPANEL,this.onShowTeaser);
         this.choiceLanguageComponent.addEventListener(LanguageDataEvent.SELECT_LANGUAGE_COMPLETE,this.onClickLanguage);
         BasicModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLLoadComplete);
         this.cafeLogin.loginName.inputField.addEventListener(TextEvent.TEXT_INPUT,this.onEnterUsername);
         this.cafeLogin.loginPassword.inputField.addEventListener(TextEvent.TEXT_INPUT,this.onEnterPassword);
         this.cafeLogin.loginName.inputField.addEventListener(FocusEvent.FOCUS_IN,this.onEnterUsername);
         this.cafeLogin.loginPassword.inputField.addEventListener(FocusEvent.FOCUS_IN,this.onEnterPassword);
         this.cafeLogin.loginName.inputField.addEventListener(FocusEvent.FOCUS_OUT,this.refillEmptyInputFields);
         this.cafeLogin.loginPassword.inputField.addEventListener(FocusEvent.FOCUS_OUT,this.refillEmptyInputFields);
         this.preset_name = CafeModel.languageData.getTextById("generic_login_loginname");
         this.preset_pass = CafeModel.languageData.getTextById("generic_login_password");
         this.refillEmptyInputFields();
         if(this.lastLanguage != "")
         {
            this.choiceLanguageComponent.setDefaultLanguage(this.lastLanguage);
         }
         if(CafeModel.sessionData.specialOffer_Gold > 0)
         {
            this.onShowTeaser(null);
         }
         else
         {
            this.hideTeaser();
         }
      }
      
      private function onLoggedIn(param1:Event) : void
      {
         hide();
         this.destroy();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.cafeLogin.loginName.inputField.removeEventListener(TextEvent.TEXT_INPUT,this.onEnterUsername);
         this.cafeLogin.loginPassword.inputField.removeEventListener(TextEvent.TEXT_INPUT,this.onEnterPassword);
         this.cafeLogin.loginName.inputField.removeEventListener(FocusEvent.FOCUS_IN,this.onEnterUsername);
         this.cafeLogin.loginPassword.inputField.removeEventListener(FocusEvent.FOCUS_IN,this.onEnterPassword);
         this.cafeLogin.loginName.inputField.removeEventListener(FocusEvent.FOCUS_OUT,this.refillEmptyInputFields);
         this.cafeLogin.loginPassword.inputField.removeEventListener(FocusEvent.FOCUS_OUT,this.refillEmptyInputFields);
         controller.removeEventListener(CafeUserEvent.INIT_USERDATA,this.onLoggedIn);
         controller.removeEventListener(CafeLevelEvent.INIT_LEVELDATA,this.onLoggedIn);
         controller.removeEventListener(CafeUserEvent.TRY_LOGIN,this.enableTextFields);
         this.choiceLanguageComponent.removeEventListener(LanguageDataEvent.SELECT_LANGUAGE_COMPLETE,this.onClickLanguage);
         BasicModel.languageData.removeEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLLoadComplete);
         controller.removeEventListener(CafePanelEvent.TEASER_ON_LOGINPANEL,this.onShowTeaser);
      }
      
      override protected function onFontsLoaded(param1:LanguageDataEvent) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CHANGE_LANGUAGE,[env.language]);
         layoutManager.clearAllLayoutContent();
         layoutManager.state = BasicLayoutManager.STATE_LOGIN;
         this.updateTextField(this.cafeLogin.mc_sticker.txt_label);
      }
      
      public function onShowTeaser(param1:CafePanelEvent) : void
      {
         this.hideTeaser();
      }
      
      public function hideTeaser() : void
      {
         this.cafeLogin.mc_sticker.visible = false;
      }
      
      override protected function update() : void
      {
         this.cafeLogin.btn_play.gotoAndStop(2);
         this.updateTextField(this.cafeLogin.btn_play.txt_label);
         TextFieldHelper.changeTextFromatSizeByTextWidth(25,this.cafeLogin.btn_play.txt_label,CafeModel.languageData.getTextById("generic_login_playnow"),1);
         this.cafeLogin.btn_login.label = CafeModel.languageData.getTextById("panelwin_login_login");
         this.cafeLogin.btn_lostpass.txt_label.text = CafeModel.languageData.getTextById("panelwin_login_lostpassword");
         this.cafeLogin.txt_savedata.text = CafeModel.languageData.getTextById("generic_register_rememberdata");
         this.choiceLanguageComponent.selectetLanguageButton(env.language);
         unLockPanel();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(isLocked || this.isWaitingForServerMessage)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.cafeLogin.btn_login:
               this.onLogin();
               break;
            case this.cafeLogin.btn_checkData:
               if(this.cafeLogin.btn_checkData.isSelected)
               {
                  this.cafeLogin.btn_checkData.deselected();
               }
               else
               {
                  this.cafeLogin.btn_checkData.selected();
               }
               break;
            case this.cafeLogin.btn_play:
               layoutManager.showDialog(CafeAvatarCreationDialog.NAME,new CafeAvatarCreationDialogProperties());
               break;
            case this.cafeLogin.loginPassword.inputField:
            case this.cafeLogin.loginName.inputField:
               (param1.target as TextField).setSelection(0,(param1.target as TextField).text.length);
               break;
            case this.cafeLogin.btn_lostpass:
               layoutManager.showDialog(CafeLostPasswordDialog.NAME,new CafeLostPasswordDialogProperties(CafeModel.languageData.getTextById("alert_lostpassword_title"),CafeModel.languageData.getTextById("alert_lostpassword_copy"),this.onSendLostName,null,CafeModel.languageData.getTextById("btn_text_okay"),CafeModel.languageData.getTextById("btn_text_goback")));
         }
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         switch(param1.target)
         {
            case this.cafeLogin.loginName.inputField:
            case this.cafeLogin.loginPassword.inputField:
               if(param1.keyCode == Keyboard.ENTER && !layoutManager.isDialogVisible(CafeRegisterDialog) && !layoutManager.isDialogVisible(CafeAvatarCreationDialog) && !layoutManager.isDialogVisible(CafeLostPasswordDialog))
               {
                  this.onLogin();
               }
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.update();
      }
      
      private function onLogin() : void
      {
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         if(this.cafeLogin.loginName.inputField.text == "" || this.cafeLogin.loginPassword.inputField.text == "")
         {
            return;
         }
         layoutManager.clearAllDialogs();
         CafeModel.userData.loginName = StringUtil.trim(this.cafeLogin.loginName.inputField.text);
         CafeModel.userData.loginPwd = StringUtil.trim(this.cafeLogin.loginPassword.inputField.text);
         if(this.cafeLogin.btn_checkData.isSelected)
         {
            CafeModel.localData.saveLoginData(CafeModel.userData.loginName,CafeModel.userData.loginPwd,true);
         }
         else
         {
            CafeModel.localData.saveLoginData("","",false);
         }
         CafeModel.localData.saveLanguageData(CafeModel.localData.readLoginDataLanguage());
         controller.paymentHash = null;
         CafeModel.sessionData.resetSpecialOffers();
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         layoutManager.customCursor.isEnabled = true;
         this.isWaitingForServerMessage = true;
         this.disableTextFields();
         CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN);
      }
      
      private function enableTextFields(param1:Event = null) : void
      {
         this.cafeLogin.btn_login.enableButton = true;
         this.cafeLogin.loginName.inputField.type = TextFieldType.INPUT;
         this.cafeLogin.loginName.inputField.mouseEnabled = true;
         this.cafeLogin.loginName.inputField.selectable = true;
         this.cafeLogin.loginPassword.inputField.type = TextFieldType.INPUT;
         this.cafeLogin.loginPassword.inputField.mouseEnabled = true;
         this.cafeLogin.loginPassword.inputField.selectable = true;
      }
      
      private function disableTextFields() : void
      {
         this.cafeLogin.btn_login.enableButton = false;
         this.cafeLogin.loginName.inputField.type = TextFieldType.DYNAMIC;
         this.cafeLogin.loginName.inputField.mouseEnabled = false;
         this.cafeLogin.loginName.inputField.selectable = false;
         this.cafeLogin.loginPassword.inputField.type = TextFieldType.DYNAMIC;
         this.cafeLogin.loginPassword.inputField.mouseEnabled = false;
         this.cafeLogin.loginPassword.inputField.selectable = false;
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_LOGIN)
         {
            this.isWaitingForServerMessage = false;
         }
      }
      
      private function onSendLostName(param1:Array) : void
      {
         if(param1 && param1.length > 0)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_LOST_PASSWORD,[param1.shift()]);
         }
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Number = NaN;
         if(disp && disp.stage)
         {
            _loc1_ = (this.backgroundView as MovieClip).mc_mask.getBounds(null);
            _loc2_ = this.backgroundView.stage.stageWidth / _loc1_.width;
            if(_loc1_.height * _loc2_ > this.backgroundView.stage.stageHeight)
            {
               _loc2_ = this.backgroundView.stage.stageHeight / _loc1_.height;
            }
            disp.y = this.backgroundView.y + this.backgroundView.height - 63 * _loc2_;
            disp.x = this.backgroundView.x;
            disp.scaleX = disp.scaleY = _loc2_;
         }
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
         lockPanel();
         CafeModel.languageData.changeLanguage(param1.selectedLanguage);
         CafeModel.localData.saveLanguageData(param1.selectedLanguage);
      }
      
      private function onEnterUsername(param1:Event) : void
      {
         if(this.cafeLogin.loginName.inputField.text == this.preset_name)
         {
            this.cafeLogin.loginName.inputField.text = "";
         }
      }
      
      private function onEnterPassword(param1:Event) : void
      {
         if(this.cafeLogin.loginPassword.inputField.text == this.preset_pass)
         {
            this.cafeLogin.loginPassword.inputField.text = "";
            (this.cafeLogin.loginPassword.inputField as TextField).displayAsPassword = true;
         }
      }
      
      private function refillEmptyInputFields(param1:Event = null) : void
      {
         if(this.cafeLogin.loginName.inputField.text == "")
         {
            this.cafeLogin.loginName.inputField.text = this.preset_name;
         }
         if(this.cafeLogin.loginPassword.inputField.text == "")
         {
            this.cafeLogin.loginPassword.inputField.text = this.preset_pass;
            (this.cafeLogin.loginPassword.inputField as TextField).displayAsPassword = false;
         }
      }
      
      override protected function updateTextField(param1:TextField) : void
      {
         CafeLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
      
      private function get backgroundView() : MovieClip
      {
         return (layoutManager.background as MovieClip).mc_bg as MovieClip;
      }
      
      private function onLanguageXMLLoadComplete(param1:Event) : void
      {
         CafeLanguageFontManager.getInstance().initFontSwf();
      }
      
      private function get cafeLogin() : CafeLogin
      {
         return disp as CafeLogin;
      }
   }
}
