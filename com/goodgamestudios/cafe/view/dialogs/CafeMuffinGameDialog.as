package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.event.CafeMinigameEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.vo.currency.CashCurrencyVO;
   import com.goodgamestudios.cafe.world.vo.currency.GoldCurrencyVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeMuffinGameDialog extends CafeDialog
   {
      
      public static const NAME:String = "dialogwin_muffinman";
       
      
      private const REQUIRED_LEVEL_FOR_GOLDPLAY:int = 10;
      
      private const FACE_HIGH_EXPECTION:int = 1;
      
      private const FACE_HAPPY_MONEY:int = 2;
      
      private const FACE_MMM_YUMMY:int = 3;
      
      private const FACE_NEUTRAL:int = 4;
      
      private const FACE_SAD:int = 5;
      
      private const MUFFIN_NORMAL:int = 1;
      
      private const MUFFIN_EMPTY:int = 2;
      
      private const MUFFIN_YUMMYFILLING:int = 3;
      
      private const CASHINCREASE:int = 100;
      
      private const GOLDINCREASE:int = 1;
      
      private const MAX_CASHBET:int = 9999999;
      
      private const MAX_GOLDBET:int = 10000;
      
      private var gameStarted:Boolean = false;
      
      private var gameAlreadyPlayed:Boolean = false;
      
      private var lastGameWasSuccessful:Boolean = false;
      
      private var goldToBet:int = 0;
      
      private var cashToBet:int = 100;
      
      private var pickedMuffin:MovieClip;
      
      public function CafeMuffinGameDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         this.showOrHideGameElements();
         controller.addEventListener(CafeUserEvent.CHANGE_USERDATA,this.onChangeUserData);
         controller.addEventListener(CafeMinigameEvent.MUFFIN_GAMERESULTS,this.onResultReceived);
         this.muffinDialog.muffin1.gotoAndStop(this.MUFFIN_NORMAL);
         this.muffinDialog.muffin1.mouseChildren = false;
         this.muffinDialog.muffin2.gotoAndStop(this.MUFFIN_NORMAL);
         this.muffinDialog.muffin2.mouseChildren = false;
         this.muffinDialog.muffin3.gotoAndStop(this.MUFFIN_NORMAL);
         this.muffinDialog.muffin3.mouseChildren = false;
         this.muffinDialog.mc_bakerface.gotoAndStop(this.FACE_NEUTRAL);
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(CafeUserEvent.CHANGE_USERDATA,this.onChangeUserData);
         controller.removeEventListener(CafeMinigameEvent.MUFFIN_GAMERESULTS,this.onResultReceived);
         super.destroy();
      }
      
      private function onChangeUserData(param1:CafeUserEvent) : void
      {
         this.updateMoneyFields();
      }
      
      private function onResultReceived(param1:CafeMinigameEvent) : void
      {
         var _loc5_:Array = null;
         var _loc6_:CashCurrencyVO = null;
         var _loc7_:GoldCurrencyVO = null;
         var _loc2_:* = param1.params.shift() > 0;
         var _loc3_:int = param1.params.shift();
         var _loc4_:int = param1.params.shift();
         CafeModel.userData.changeUserMoney(_loc3_,_loc4_);
         if(_loc2_)
         {
            this.pickedMuffin.gotoAndStop(this.MUFFIN_YUMMYFILLING);
            _loc5_ = [];
            if(_loc3_ > 0)
            {
               (_loc6_ = CafeModel.wodData.createVObyWOD(1901) as CashCurrencyVO).amount = _loc3_ * 2;
               _loc5_.push(_loc6_);
            }
            if(_loc4_ > 0)
            {
               (_loc7_ = CafeModel.wodData.createVObyWOD(1902) as GoldCurrencyVO).amount = _loc4_ * 2;
               _loc5_.push(_loc7_);
            }
            CafeLayoutManager.getInstance().showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(CafeBonusDialogProperties.TYPE_FIND_FILLING,CafeModel.languageData.getTextById("dialogwin_receiveitem_title"),CafeModel.languageData.getTextById("dialogwin_muffinman_wonbet"),_loc5_));
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_ACHIEVEMENT);
         }
         else
         {
            this.pickedMuffin.gotoAndStop(this.MUFFIN_EMPTY);
         }
         this.finishGame(_loc2_);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.muffinDialog.muffin1:
            case this.muffinDialog.muffin2:
            case this.muffinDialog.muffin3:
               if(this.gameStarted)
               {
                  this.setFace(this.FACE_HIGH_EXPECTION);
               }
               CafeLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.muffinDialog.muffin1:
            case this.muffinDialog.muffin2:
            case this.muffinDialog.muffin3:
               if(this.gameStarted)
               {
                  this.setFace();
               }
               CafeLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
         super.onMouseOut(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         if(param1.target is BasicButton && !param1.target.enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.muffinDialog.btn_close:
               this.hide();
               break;
            case this.muffinDialog.btn_start:
               if(this.muffinDialog.btn_start.enabled)
               {
                  if(CafeModel.userData.isGuest())
                  {
                     layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
                  }
                  else
                  {
                     this.tryToStartGame();
                  }
               }
               break;
            case this.muffinDialog.btn_plusGold:
               if(this.muffinDialog.btn_plusGold.enabled)
               {
                  this.increaseBet(0,this.GOLDINCREASE);
               }
               break;
            case this.muffinDialog.btn_minusGold:
               if(this.muffinDialog.btn_minusGold.enabled)
               {
                  this.increaseBet(0,-this.GOLDINCREASE);
               }
               break;
            case this.muffinDialog.btn_plusCash:
               if(this.muffinDialog.btn_plusCash.enabled)
               {
                  this.increaseBet(this.CASHINCREASE);
               }
               break;
            case this.muffinDialog.btn_minusCash:
               if(this.muffinDialog.btn_minusCash.enabled)
               {
                  this.increaseBet(-this.CASHINCREASE);
               }
               break;
            case this.muffinDialog.mc_bonusCash:
               this.increaseBet(Math.max(this.cashToBet,100));
               break;
            case this.muffinDialog.mc_bonusGold:
               this.increaseBet(0,Math.max(this.goldToBet,1));
               break;
            case this.muffinDialog.muffin1:
            case this.muffinDialog.muffin2:
            case this.muffinDialog.muffin3:
               if(this.gameStarted)
               {
                  this.pickMuffin(param1.target as MovieClip);
               }
         }
      }
      
      private function tryToStartGame() : void
      {
         if(this.cashToBet > CafeModel.userData.cash || this.goldToBet > CafeModel.userData.gold)
         {
            this.onError_notEnoughMoney();
         }
         else if(this.goldToBet > 0 && !CafeModel.userData.isPayUser && CafeModel.userData.userLevel < this.REQUIRED_LEVEL_FOR_GOLDPLAY)
         {
            this.onError_noPayUser();
         }
         else
         {
            this.startGame();
         }
      }
      
      public function startGame() : void
      {
         this.gameStarted = true;
         this.muffinDialog.muffin1.gotoAndStop(this.MUFFIN_NORMAL);
         this.muffinDialog.muffin2.gotoAndStop(this.MUFFIN_NORMAL);
         this.muffinDialog.muffin3.gotoAndStop(this.MUFFIN_NORMAL);
         this.showOrHideGameElements();
         this.muffinDialog.btn_plusCash.enableButton = false;
         this.muffinDialog.btn_plusGold.enableButton = false;
         this.muffinDialog.btn_minusCash.enableButton = false;
         this.muffinDialog.btn_minusGold.enableButton = false;
      }
      
      private function pickMuffin(param1:MovieClip) : void
      {
         switch(param1)
         {
            case this.muffinDialog.muffin1:
               this.pickedMuffin = this.muffinDialog.muffin1;
               break;
            case this.muffinDialog.muffin2:
               this.pickedMuffin = this.muffinDialog.muffin2;
               break;
            case this.muffinDialog.muffin3:
               this.pickedMuffin = this.muffinDialog.muffin3;
         }
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_MINI_MUFFIN,[this.cashToBet,this.goldToBet]);
      }
      
      public function finishGame(param1:Boolean) : void
      {
         this.lastGameWasSuccessful = param1;
         this.gameAlreadyPlayed = true;
         this.gameStarted = false;
         this.resetMoneyData();
         this.setFace();
         this.setInstructions();
      }
      
      private function resetMoneyData() : void
      {
         this.applyProperties();
         this.showOrHideGameElements();
      }
      
      private function increaseBet(param1:int = 0, param2:int = 0) : void
      {
         this.cashToBet += param1;
         this.goldToBet += param2;
         this.cashToBet = Math.max(Math.min(this.cashToBet,CafeModel.userData.cash),100);
         this.goldToBet = Math.max(Math.min(this.goldToBet,CafeModel.userData.gold),0);
         this.muffinDialog.txt_usedCash.text = NumberStringHelper.groupString(this.cashToBet,CafeModel.languageData.getTextById);
         this.muffinDialog.txt_usedGold.text = NumberStringHelper.groupString(this.goldToBet,CafeModel.languageData.getTextById);
         if(this.cashToBet > 0 || this.goldToBet > 0)
         {
            this.muffinDialog.btn_start.enableButton = true;
         }
         this.setFace();
         this.updateMoneyButtons();
      }
      
      private function updateMoneyButtons() : void
      {
         this.muffinDialog.btn_plusCash.enableButton = this.cashToBet < CafeModel.userData.cash;
         this.muffinDialog.mc_bonusCash.enableButton = this.cashToBet < CafeModel.userData.cash;
         this.muffinDialog.btn_minusCash.enableButton = this.cashToBet > this.CASHINCREASE;
         this.muffinDialog.btn_plusGold.enableButton = this.goldToBet < CafeModel.userData.gold;
         this.muffinDialog.mc_bonusGold.enableButton = this.goldToBet < CafeModel.userData.gold;
         this.muffinDialog.btn_minusGold.enableButton = this.goldToBet >= this.GOLDINCREASE;
      }
      
      private function onError_notEnoughMoney() : void
      {
         layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById(NAME + "_nomoney")));
         this.resetMoneyData();
      }
      
      public function onError_noPayUser() : void
      {
         CafeLayoutManager.getInstance().showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties("",CafeModel.languageData.getTextById(NAME + "_nopayment")));
         this.resetMoneyData();
      }
      
      private function onError_tooHighBet() : void
      {
         CafeLayoutManager.getInstance().showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties("",CafeModel.languageData.getTextById(NAME + "_toohighbet",[this.MAX_GOLDBET,this.MAX_CASHBET])));
         this.resetMoneyData();
      }
      
      override protected function applyProperties() : void
      {
         TextFieldHelper.changeTextFromatSizeByTextWidth(20,this.muffinDialog.txt_title,CafeModel.languageData.getTextById(NAME + "_header"),1);
         this.muffinDialog.btn_start.label = CafeModel.languageData.getTextById(NAME + "_btn_go");
         this.muffinDialog.txt_usedCash.text = NumberStringHelper.groupString(this.cashToBet,CafeModel.languageData.getTextById);
         this.muffinDialog.txt_usedGold.text = NumberStringHelper.groupString(this.goldToBet,CafeModel.languageData.getTextById);
         this.muffinDialog.mc_bonusCash.mouseChildren = false;
         this.muffinDialog.mc_bonusGold.mouseChildren = false;
         this.muffinDialog.btn_plusCash.enableButton = true;
         this.muffinDialog.btn_minusCash.enableButton = true;
         this.muffinDialog.mc_bonusCash.enableButton = true;
         this.muffinDialog.btn_plusGold.enableButton = true;
         this.muffinDialog.mc_bonusGold.enableButton = true;
         this.muffinDialog.btn_minusGold.enableButton = true;
         this.updateMoneyFields();
         this.updateMoneyButtons();
         this.setInstructions();
      }
      
      private function updateMoneyFields() : void
      {
         this.muffinDialog.txt_cash.text = NumberStringHelper.groupString(CafeModel.userData.cash,CafeModel.languageData.getTextById);
         this.muffinDialog.txt_gold.text = NumberStringHelper.groupString(CafeModel.userData.gold,CafeModel.languageData.getTextById);
      }
      
      private function showOrHideGameElements() : void
      {
         this.muffinDialog.muffinArrow1.visible = this.gameStarted;
         this.muffinDialog.muffinArrow2.visible = this.gameStarted;
         this.muffinDialog.muffinArrow3.visible = this.gameStarted;
         this.muffinDialog.btn_start.visible = !this.gameStarted;
         this.muffinDialog.mc_bonusCash.visible = !this.gameStarted;
         this.muffinDialog.mc_bonusGold.visible = !this.gameStarted;
         this.muffinDialog.btn_plusCash.visible = !this.gameStarted;
         this.muffinDialog.btn_plusGold.visible = !this.gameStarted;
         this.muffinDialog.btn_minusCash.visible = !this.gameStarted;
         this.muffinDialog.btn_minusGold.visible = !this.gameStarted;
         this.muffinDialog.mc_infotext.visible = false;
         if(this.gameAlreadyPlayed)
         {
            this.muffinDialog.btn_start.label = CafeModel.languageData.getTextById(NAME + "_btn_again");
         }
         this.setFace();
      }
      
      private function setInstructions() : void
      {
         if(this.gameStarted)
         {
            this.muffinDialog.mc_infotext.visible = false;
         }
         else
         {
            this.muffinDialog.mc_infotext.visible = true;
            if(!this.lastGameWasSuccessful && this.gameAlreadyPlayed)
            {
               this.muffinDialog.mc_infotext.txt_copy.text = CafeModel.languageData.getTextById(NAME + "_lostbet");
            }
            else if(this.lastGameWasSuccessful && this.gameAlreadyPlayed)
            {
               this.muffinDialog.mc_infotext.txt_copy.text = CafeModel.languageData.getTextById(NAME + "_wonbet");
            }
            else
            {
               this.muffinDialog.mc_infotext.txt_copy.text = CafeModel.languageData.getTextById(NAME + "_beforebet");
            }
         }
      }
      
      private function setFace(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            if(this.cashToBet >= 200000 || this.goldToBet >= 20)
            {
               this.muffinDialog.mc_bakerface.gotoAndStop(this.FACE_HAPPY_MONEY);
            }
            else if(this.gameAlreadyPlayed && !this.lastGameWasSuccessful && !this.gameStarted)
            {
               this.muffinDialog.mc_bakerface.gotoAndStop(this.FACE_SAD);
            }
            else if(this.gameAlreadyPlayed && this.lastGameWasSuccessful && !this.gameStarted)
            {
               this.muffinDialog.mc_bakerface.gotoAndStop(this.FACE_MMM_YUMMY);
            }
            else
            {
               this.muffinDialog.mc_bakerface.gotoAndStop(this.FACE_NEUTRAL);
            }
         }
         else
         {
            this.muffinDialog.mc_bakerface.gotoAndStop(param1);
         }
      }
      
      override public function hide() : void
      {
         super.hide();
         this.destroy();
      }
      
      private function get muffinDialog() : CafeMuffinGame
      {
         return disp as CafeMuffinGame;
      }
   }
}
