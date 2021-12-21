package com.goodgamestudios.cafe.view
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeAchievementDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAchievementEarnDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAddFriendDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarChangeDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarCreationDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarNameSelectionDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeBigYesNoDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeBonusDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeChangePasswordDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeChoiceAmountDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCleanStoveDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeClearCounterDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeClearStoveDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeComebackBonusDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCookBookDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCoopDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCoopRewardDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCoopsHelpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeDecoshopHelpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeFancyCookingDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeFeatureDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeFeatureUnlockedDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeGameHelpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeGiftboxDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeHighscoreDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeIngredientShopDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeInstantCookingDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeInviteFriendDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeJobPaycheckDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeLevelUpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeLostPasswordDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMailGiftDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMailVerificationDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceBoardDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceJobDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceJobHelpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMasteryCompleteDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMasteryInfoDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMuffinGameDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMultipleDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeOptionDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeOrderCompanyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafePaymentAndSuperRewardDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafePaymentTeaserDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafePaymentcheaperDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafePlayerInfoDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeReconnectDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeReportPlayerDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeSmoothiemakerDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeSmoothiemakerHelpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStaffDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStaffHireDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStaffManagementDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardYesNoDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeTimeFeatureDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeWheelOfFortuneDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeWheelOfFortuneReminderDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeWorldSelectionDialog;
   import com.goodgamestudios.cafe.view.panels.CafeActionPanel;
   import com.goodgamestudios.cafe.view.panels.CafeBuddylistPanel;
   import com.goodgamestudios.cafe.view.panels.CafeDekoShopPanel;
   import com.goodgamestudios.cafe.view.panels.CafeLoginPanel;
   import com.goodgamestudios.cafe.view.panels.CafeNamePanel;
   import com.goodgamestudios.cafe.view.panels.CafeOptionPanel;
   import com.goodgamestudios.cafe.view.panels.CafeRegisterPanel;
   import com.goodgamestudios.cafe.view.panels.CafeSocialPanel;
   import com.goodgamestudios.cafe.view.panels.CafeTeaserPanel;
   import com.goodgamestudios.cafe.view.panels.CafeTutorialPanel;
   import com.goodgamestudios.cafe.view.panels.CafeUserStatePanel;
   import com.goodgamestudios.cafe.view.screens.CafeIsoScreen;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CafeLayoutManager extends BasicLayoutManager
   {
      
      public static const STATE_MY_CAFE:int = 10;
      
      public static const STATE_DEKO_SHOP:int = 11;
      
      public static const STATE_OTHER_CAFE:int = 13;
      
      public static const STATE_MARKETPLACE:int = 14;
       
      
      private var playeroverlayLayer:Sprite;
      
      public var dragLayer:Sprite;
      
      private var loginPanel:CafeLoginPanel;
      
      private var _tutPanel:CafeTutorialPanel;
      
      public var isoScreen:CafeIsoScreen;
      
      public var tooltipManager:CafeToolTipManager;
      
      public var playerActionChoices:PlayerActionChoicesComponent;
      
      private var timerFor:Array;
      
      public function CafeLayoutManager()
      {
         this.timerFor = [];
         super();
         if(layoutManager)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : CafeLayoutManager
      {
         if(!layoutManager)
         {
            layoutManager = new CafeLayoutManager();
         }
         return layoutManager as CafeLayoutManager;
      }
      
      override public function initialize(param1:BasicBackgroundComponent) : void
      {
         super.initialize(param1);
         this.playeroverlayLayer = new Sprite();
         this.dragLayer = new Sprite();
         this.dragLayer.mouseEnabled = false;
         this.dragLayer.mouseChildren = false;
         this.tooltipManager = new CafeToolTipManager(tooltipLayer);
         this.playerActionChoices = new PlayerActionChoicesComponent(this.playeroverlayLayer);
         layoutManager.addChild(backgroundLayer);
         layoutManager.addChild(screenLayer);
         layoutManager.addChild(panelLayer);
         layoutManager.addChild(dialogLayer);
         layoutManager.addChild(tutorialLayer);
         layoutManager.addChild(this.playeroverlayLayer);
         layoutManager.addChild(tooltipLayer);
         layoutManager.addChild(this.dragLayer);
         layoutManager.addChild(adminLayer);
         layoutManager.addChild(mouseLayer);
         this.isoScreen = showScreen(CafeIsoScreen.NAME) as CafeIsoScreen;
      }
      
      override public function set state(param1:int) : void
      {
         super.state = param1;
         switch(param1)
         {
            case STATE_CONNECT:
               this.isoScreen.hide();
               break;
            case STATE_LOGIN:
               this.isoScreen.hide();
               showPanel(CafeLoginPanel.NAME);
               break;
            case STATE_OTHER_CAFE:
            case STATE_MARKETPLACE:
            case STATE_MY_CAFE:
               if(outGameState)
               {
                  hideAllPanels();
               }
               if(_currentState == STATE_MARKETPLACE)
               {
                  hideAllDialogs();
               }
               if(_currentState == STATE_DEKO_SHOP)
               {
                  hidePanel(CafeDekoShopPanel.NAME);
               }
               hideBackgroundLayer();
               this.isoScreen.show();
               showPanel(CafeNamePanel.NAME);
               showPanel(CafeUserStatePanel.NAME);
               showPanel(CafeOptionPanel.NAME);
               if(CafeModel.userData.isGuest())
               {
                  showPanel(CafeRegisterPanel.NAME);
               }
               else
               {
                  hidePanel(CafeRegisterPanel.NAME);
               }
               showPanel(CafeSocialPanel.NAME);
               showPanel(CafeActionPanel.NAME);
               if(this.env.hasNetworkBuddies)
               {
                  showPanel(CafeBuddylistPanel.NAME);
               }
               if(CafeModel.userData.firstLogin)
               {
                  this.addTutorialPanel();
                  CafeTutorialController.getInstance().startTutorial(new TutorialArrow());
                  CafeModel.userData.firstLogin = false;
                  break;
               }
               BasicController.getInstance().dispatchEvent(new CafeDialogEvent(CafeDialogEvent.CHANGE_CAFE));
               break;
            case STATE_DEKO_SHOP:
               hidePanel(CafeActionPanel.NAME);
               hidePanel(CafeSocialPanel.NAME);
               showPanel(CafeDekoShopPanel.NAME);
         }
         if(_currentState != param1)
         {
            _currentState = param1;
            BasicController.getInstance().dispatchEvent(new CafeDialogEvent(CafeDialogEvent.CHANGE_LAYOUTSTATE,[_currentState]));
         }
      }
      
      override protected function onEnterFrame(param1:Event) : void
      {
         CafeModel.updateModelData();
         super.onEnterFrame(param1);
      }
      
      private function addTutorialPanel() : void
      {
         this._tutPanel = new CafeTutorialPanel(new TutorialPanelNew());
         tutorialLayer.addChild(this.tutPanel.disp);
      }
      
      public function removeTutorialPanel() : void
      {
         if(this.tutPanel)
         {
            this.tutPanel.destroy();
            tutorialLayer.removeChild(this.tutPanel.disp);
            this._tutPanel = null;
         }
      }
      
      override public function clearAllLayoutContent() : void
      {
         clearAllPanels();
         clearAllDialogs();
         this.removeTutorialPanel();
         this.clearToolTipLayer();
         this.tooltipManager = new CafeToolTipManager(tooltipLayer);
      }
      
      private function clearToolTipLayer() : void
      {
         this.tooltipManager.destroy();
         while(tooltipLayer.numChildren > 0)
         {
            tooltipLayer.removeChildAt(0);
         }
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      override protected function createFlashComponent(param1:String) : FlashUIComponent
      {
         switch(param1)
         {
            case CafeIsoScreen.NAME:
               return new CafeIsoScreen(new Sprite());
            case CafeLoginPanel.NAME:
               return new CafeLoginPanel(new CafeLogin());
            case CafeTeaserPanel.NAME:
               return new CafeTeaserPanel(new TeaserPanel());
            case CafeRegisterDialog.NAME:
               return new CafeRegisterDialog(new CafeRegisterNew());
            case CafeUserStatePanel.NAME:
               return new CafeUserStatePanel(new UserStatePanel());
            case CafeOptionPanel.NAME:
               return new CafeOptionPanel(new OptionPanel());
            case CafeRegisterPanel.NAME:
               return new CafeRegisterPanel(new RegisterPanel());
            case CafeSocialPanel.NAME:
               return new CafeSocialPanel(new SocialPanel());
            case CafeActionPanel.NAME:
               return new CafeActionPanel(new ActionPanel());
            case CafeDekoShopPanel.NAME:
               return new CafeDekoShopPanel(new DekoShopPanel());
            case CafeAvatarCreationDialog.NAME:
               return new CafeAvatarCreationDialog(new CafeAvatarSelection());
            case CafeBuddylistPanel.NAME:
               return new CafeBuddylistPanel(new BuddylistPanel());
            case CafeAvatarNameSelectionDialog.NAME:
               return new CafeAvatarNameSelectionDialog(new CafeAvatarNameSelection());
            case CafeCookBookDialog.NAME:
               return new CafeCookBookDialog(new CafeCBook());
            case CafeIngredientShopDialog.NAME:
               return new CafeIngredientShopDialog(new CafeIShop());
            case CafeStaffDialog.NAME:
               return new CafeStaffDialog(new CafeStaff());
            case CafeClearStoveDialog.NAME:
               return new CafeClearStoveDialog(new CafeClearStove());
            case CafeCleanStoveDialog.NAME:
               return new CafeCleanStoveDialog(new CafeCleanStove());
            case CafeClearCounterDialog.NAME:
               return new CafeClearCounterDialog(new CafeClearCounter());
            case CafeStandardOkDialog.NAME:
               return new CafeStandardOkDialog(new CafeStandardOk());
            case CafeStandardYesNoDialog.NAME:
               return new CafeStandardYesNoDialog(new CafeStandardYesNo());
            case CafeBigYesNoDialog.NAME:
               return new CafeBigYesNoDialog(new CafeBigYesNo());
            case CafeStaffHireDialog.NAME:
               return new CafeStaffHireDialog(new CafeStaffHire());
            case CafeBonusDialog.NAME:
               return new CafeBonusDialog(new CafeBonus());
            case CafeLostPasswordDialog.NAME:
               return new CafeLostPasswordDialog(new LostPassword());
            case CafeChoiceAmountDialog.NAME:
               return new CafeChoiceAmountDialog(new CafeCourier());
            case CafeNamePanel.NAME:
               return new CafeNamePanel(new CafeName());
            case CafeInviteFriendDialog.NAME:
               return new CafeInviteFriendDialog(new CafeInviteFriend());
            case CafeChangePasswordDialog.NAME:
               return new CafeChangePasswordDialog(new ChangePassword());
            case CafeAchievementDialog.NAME:
               return new CafeAchievementDialog(new AchievementDialog());
            case CafeNoMoneyDialog.NAME:
               return new CafeNoMoneyDialog(new CafeNoMoney());
            case CafeFeatureDialog.NAME:
               return new CafeFeatureDialog(new FeatureDialog());
            case CafeOrderCompanyDialog.NAME:
               return new CafeOrderCompanyDialog(new OrderCompanyDialog());
            case CafePlayerInfoDialog.NAME:
               return new CafePlayerInfoDialog(new CafePlayerInfo());
            case CafeMarketplaceJobDialog.NAME:
               return new CafeMarketplaceJobDialog(new CafeStandardYesNo());
            case CafeJobPaycheckDialog.NAME:
               return new CafeJobPaycheckDialog(new CafeJobPaycheck());
            case CafePaymentAndSuperRewardDialog.NAME:
               return new CafePaymentAndSuperRewardDialog(new CafePaymentReward());
            case CafeMarketplaceBoardDialog.NAME:
               return new CafeMarketplaceBoardDialog(new CafeMarketplaceBoard());
            case CafeMarketplaceJobHelpDialog.NAME:
               return new CafeMarketplaceJobHelpDialog(new CafeMarketplaceJobhelp());
            case CafeAddFriendDialog.NAME:
               return new CafeAddFriendDialog(new CafeStandardYesNo());
            case CafeStaffManagementDialog.NAME:
               return new CafeStaffManagementDialog(new CafeStaffManagement());
            case CafeGiftboxDialog.NAME:
               return new CafeGiftboxDialog(new CafeGiftBox());
            case CafeCoopDialog.NAME:
               return new CafeCoopDialog(new CafeCoop());
            case CafeMultipleDialog.NAME:
               return new CafeMultipleDialog(new CafeStandardOk());
            case CafeCoopsHelpDialog.NAME:
               return new CafeCoopsHelpDialog(new CafeCoopHelp());
            case CafeCoopRewardDialog.NAME:
               return new CafeCoopRewardDialog(new CafeCoopReward());
            case CafeReportPlayerDialog.NAME:
               return new CafeReportPlayerDialog(new CafeReportPlayer());
            case CafeFancyCookingDialog.NAME:
               return new CafeFancyCookingDialog(new CafeFancyCooking());
            case CafeInstantCookingDialog.NAME:
               return new CafeInstantCookingDialog(new CafeInstantCooking());
            case CafeHighscoreDialog.NAME:
               return new CafeHighscoreDialog(new CafeHighscore());
            case CafeTimeFeatureDialog.NAME:
               return new CafeTimeFeatureDialog(new LtdFeatureDialog());
            case CafeWorldSelectionDialog.NAME:
               return new CafeWorldSelectionDialog(new CafeWorldSelection());
            case CafeDecoshopHelpDialog.NAME:
               return new CafeDecoshopHelpDialog(new CafeDekoShopHelp());
            case CafeMasteryInfoDialog.NAME:
               return new CafeMasteryInfoDialog(new CafeMasteryInfo());
            case CafeMasteryCompleteDialog.NAME:
               return new CafeMasteryCompleteDialog(new CafeMasteyComplete());
            case CafeReconnectDialog.NAME:
               return new CafeReconnectDialog(new CafeReconnect());
            case CafePaymentTeaserDialog.NAME:
               return new CafePaymentTeaserDialog(new PaymentBonusPopup());
            case CafeMuffinGameDialog.NAME:
               return new CafeMuffinGameDialog(new CafeMuffinGame());
            case CafeWheelOfFortuneDialog.NAME:
               return new CafeWheelOfFortuneDialog(new CafeWheelOfFortune());
            case CafeWheelOfFortuneReminderDialog.NAME:
               return new CafeWheelOfFortuneReminderDialog(new CafeWheelOfFortuneReminder());
            case CafeSmoothiemakerDialog.NAME:
               return new CafeSmoothiemakerDialog(new CafeSmoothieDialog());
            case CafeSmoothiemakerHelpDialog.NAME:
               return new CafeSmoothiemakerHelpDialog(new CafeCoopHelp());
            case CafeComebackBonusDialog.NAME:
               return new CafeComebackBonusDialog(new CafeComebackBonus());
            case CafePaymentcheaperDialog.NAME:
               return new CafePaymentcheaperDialog(new PaymentCheaperPopUp());
            case CafeFeatureUnlockedDialog.NAME:
               return new CafeFeatureUnlockedDialog(new CafeFeatureUnlocked());
            case CafeAchievementEarnDialog.NAME:
               return new CafeAchievementEarnDialog(new CafeAchievementEarn());
            case CafeAvatarChangeDialog.NAME:
               return new CafeAvatarChangeDialog(new CafeAvatarCreation());
            case CafeLevelUpDialog.NAME:
               return new CafeLevelUpDialog(new CafeLevelUp());
            case CafeOptionDialog.NAME:
               return new CafeOptionDialog(new OptionDialog());
            case CafeMailVerificationDialog.NAME:
               return new CafeMailVerificationDialog(new CafeMailverification());
            case CafeMailGiftDialog.NAME:
               return new CafeMailGiftDialog(new CafeMailGift());
            case CafeGameHelpDialog.NAME:
               return new CafeGameHelpDialog(new CafeGameHelp());
            default:
               throw Error("Unknown component: " + param1);
         }
      }
      
      public function showDialogAfterTime(param1:String, param2:Number) : void
      {
         if(this.timerFor[param1] && this.timerFor[param1] == true)
         {
            return;
         }
         this.timerFor[param1] = true;
         var _loc3_:Timer = new Timer(param2,1);
         switch(param1)
         {
            case CafeWheelOfFortuneReminderDialog.NAME:
               _loc3_.addEventListener(TimerEvent.TIMER,this.onWheelOfFortuneReminderTimer);
               _loc3_.start();
               return;
            default:
               throw Error("Unknown component: " + param1);
         }
      }
      
      private function onWheelOfFortuneReminderTimer(param1:TimerEvent) : void
      {
         (param1.target as Timer).removeEventListener(TimerEvent.TIMER,this.onWheelOfFortuneReminderTimer);
         this.timerFor[CafeWheelOfFortuneReminderDialog.NAME] = false;
         if(CafeWheelOfFortuneReminderDialog.isShowingAllowed)
         {
            showDialog(CafeWheelOfFortuneReminderDialog.NAME);
         }
      }
      
      public function get tutLayer() : Sprite
      {
         return tutorialLayer;
      }
      
      public function get background() : DisplayObject
      {
         return _backgroundComponent.disp;
      }
      
      public function get tutPanel() : CafeTutorialPanel
      {
         return this._tutPanel;
      }
   }
}
