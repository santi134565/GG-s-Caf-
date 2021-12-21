package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.event.CafeGiftEvent;
   import com.goodgamestudios.cafe.event.CafeMinigameEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.vo.InteractiveFloorVO;
   import com.goodgamestudios.cafe.world.vo.counter.BasicCounterVO;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   import com.goodgamestudios.cafe.world.vo.stove.BasicStoveVO;
   import com.goodgamestudios.cafe.world.vo.tile.StaticTileVO;
   import com.goodgamestudios.cafe.world.vo.wall.StaticWallVO;
   import com.goodgamestudios.cafe.world.vo.wallobject.BasicWallobjectVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BlurFilter;
   
   public class CafeWheelOfFortuneDialog extends CafeDialog
   {
      
      public static const NAME:String = "dialogwin_wheeloffortune";
       
      
      private var gameStarted:Boolean = false;
      
      private var gameAlreadyPlayed:Boolean = false;
      
      private var didCostGold:Boolean = false;
      
      private var wof_framecounter:int = 0;
      
      private var angleToAchieve:Number = 0;
      
      private const WOF_NUMROUNDS:int = 4;
      
      private var youShallWinThisSlot:int = -1;
      
      private var prizes:Array;
      
      public function CafeWheelOfFortuneDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.wheelDialog.txt_title.text = CafeModel.languageData.getTextById(NAME + "_header");
         TextFieldHelper.changeTextFromatSizeByTextWidth(32,this.wheelDialog.txt_title,CafeModel.languageData.getTextById(NAME + "_header"),1);
         this.wheelDialog.txt_freeplay.text = CafeModel.languageData.getTextById(NAME + "_info");
         TextFieldHelper.changeTextFromatSizeByTextWidth(18,this.wheelDialog.txt_freeplay,CafeModel.languageData.getTextById(NAME + "_info"),3);
         this.wheelDialog.btn_go.txt_label.text = CafeModel.languageData.getTextById(NAME + "_btn_go");
         this.wheelDialog.btn_info.visible = this.wheelDialogProperties.jackpot > 0;
         controller.addEventListener(CafeMinigameEvent.WHEELOFFORTUNE,this.onServerAnswer);
         this.wheelDialog.placeholder_pieces.cacheAsBitmap = true;
         this.setInstructions();
         this.setPlayButton();
         this.fillPrizes();
         super.applyProperties();
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(CafeMinigameEvent.WHEELOFFORTUNE,this.onServerAnswer);
         if(this.wheelDialog.hasEventListener(Event.ENTER_FRAME))
         {
            this.wheelDialog.removeEventListener(Event.ENTER_FRAME,this.onGameLoop);
         }
         super.destroy();
      }
      
      override public function hide() : void
      {
         this.destroy();
         super.hide();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton && !param1.target.enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.wheelDialog.btn_close:
               this.hide();
               break;
            case this.wheelDialog.btn_info:
               break;
            case this.wheelDialog.btn_go:
               this.tryToStartGame();
         }
         super.onClick(param1);
      }
      
      private function onServerAnswer(param1:CafeMinigameEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:VisualVO = null;
         if(param1.params.length < 1)
         {
            if(this.didCostGold)
            {
               CafeModel.userData.changeUserMoney(0,1);
            }
            else
            {
               this.gameStarted = false;
               this.gameAlreadyPlayed = false;
               CafeModel.userData.playedWheelOfFortune = false;
            }
            this.hide();
            return;
         }
         this.youShallWinThisSlot = param1.params.shift();
         this.prizes = [];
         var _loc2_:Array = [];
         while(param1.params[0])
         {
            _loc2_ = (param1.params.shift() as String).split("#");
            if(!_loc2_[0] && _loc2_.length > 0)
            {
               _loc2_.shift();
            }
            while(_loc2_[0])
            {
               _loc3_ = (_loc2_.shift() as String).split("+");
               _loc4_ = _loc3_.shift();
               if((_loc5_ = _loc3_.shift()) > 0)
               {
                  if(_loc6_ = CafeModel.wodData.createVObyWOD(_loc4_) as VisualVO)
                  {
                     if(_loc6_.hasOwnProperty("amount"))
                     {
                        _loc6_["amount"] = _loc5_;
                     }
                     else if(_loc6_.hasOwnProperty("itemAmount"))
                     {
                        _loc6_["itemAmount"] = _loc5_;
                     }
                     this.prizes.push(_loc6_);
                     if(_loc6_ is BasicCounterVO || _loc6_ is BasicStoveVO || _loc6_ is BasicFridgeVO || _loc6_ is StaticTileVO || _loc6_ is BasicWallobjectVO || _loc6_ is StaticWallVO || _loc6_ is InteractiveFloorVO)
                     {
                        CafeModel.inventoryFurniture.addItem(_loc6_.wodId,_loc5_);
                     }
                     else if(_loc4_ != CafeConstants.WODID_CASH && _loc4_ != CafeConstants.WODID_GOLD && _loc4_ != CafeConstants.WODID_XP)
                     {
                        ++CafeModel.giftList.numNewGifts;
                     }
                  }
               }
            }
         }
         this.wheelDialog.btn_close.enableButton = false;
         this.startGameLoop();
      }
      
      private function tryToStartGame() : void
      {
         if(CafeModel.userData.isGuest())
         {
            this.onError_isGuest();
         }
         else if((!this.wheelDialogProperties.firstPlay || this.gameAlreadyPlayed) && CafeModel.userData.gold < 1)
         {
            this.onError_notEnoughGold();
         }
         else if(CafeModel.giftList.numGifts >= CafeConstants.MAXGIFTS)
         {
            this.onError_noSpace();
         }
         else
         {
            this.startGame();
         }
      }
      
      private function startGame() : void
      {
         this.didCostGold = false;
         if(this.gameAlreadyPlayed || !this.wheelDialogProperties.firstPlay)
         {
            CafeModel.userData.changeUserMoney(0,-1);
            this.didCostGold = true;
         }
         this.gameStarted = true;
         this.gameAlreadyPlayed = true;
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_WHEELOFFORTUNE,[]);
         this.setInstructions();
         this.setPlayButton();
      }
      
      private function startGameLoop() : void
      {
         this.calcAngleToAchieve();
         this.wheelDialog.addEventListener(Event.ENTER_FRAME,this.onGameLoop);
      }
      
      private function onGameLoop(param1:Event) : void
      {
         var _loc2_:Number = Math.PI / 2 * 60;
         this.wheelDialog.placeholder_pieces.rotation = -(Math.sin(this.wof_framecounter / _loc2_) * this.angleToAchieve);
         var _loc3_:Number = Math.min(1 / (this.wof_framecounter / _loc2_ / Math.PI / 2) / 25,4);
         this.wheelDialog.placeholder_pieces.filters = [new BlurFilter(_loc3_,_loc3_)];
         if(this.wof_framecounter / _loc2_ >= Math.PI / 2)
         {
            this.finishGame();
         }
         ++this.wof_framecounter;
      }
      
      private function calcAngleToAchieve() : void
      {
         this.angleToAchieve = 360 / CafeWheelOfFortuneDialogProperties.NUM_PRIZES * this.youShallWinThisSlot;
         this.angleToAchieve += 360 * this.WOF_NUMROUNDS;
      }
      
      private function getNearestBar() : WheelOfFortunePiece
      {
         var _loc4_:WheelOfFortunePiece = null;
         var _loc1_:int = 0;
         var _loc2_:int = 359;
         var _loc3_:int = 0;
         while(_loc3_ < CafeWheelOfFortuneDialogProperties.NUM_PRIZES)
         {
            _loc4_ = this.wheelDialog.placeholder_pieces.getChildByName("part_" + _loc3_) as WheelOfFortunePiece;
            if(Math.abs((_loc4_.rotation + this.wheelDialog.placeholder_pieces.rotation) % 360) < _loc2_)
            {
               _loc1_ = _loc3_;
               _loc2_ = Math.abs((_loc4_.rotation + this.wheelDialog.placeholder_pieces.rotation) % 360);
               _loc4_.deltaAngle = (_loc4_.rotation + this.wheelDialog.placeholder_pieces.rotation) % 360;
            }
            _loc3_++;
         }
         return this.wheelDialog.placeholder_pieces.getChildByName("part_" + _loc1_) as WheelOfFortunePiece;
      }
      
      private function finishGame() : void
      {
         var _loc3_:VisualVO = null;
         var _loc1_:WheelOfFortunePiece = this.getNearestBar();
         trace("Sollte Gewinnen:" + this.youShallWinThisSlot + " | habe gewonnen: " + _loc1_.name);
         var _loc2_:String = "dialogwin_wheeloffortune_wonbet";
         switch(this.wheelDialogProperties.getPrizeTypeBySlot(this.youShallWinThisSlot))
         {
            case CafeWheelOfFortuneDialogProperties.TYPE_CASH:
            case CafeWheelOfFortuneDialogProperties.TYPE_XP:
               _loc2_ = "dialogwin_wheeloffortune_woncash";
               break;
            case CafeWheelOfFortuneDialogProperties.TYPE_MOREGOLD:
            case CafeWheelOfFortuneDialogProperties.TYPE_GOLD:
               _loc2_ = "dialogwin_wheeloffortune_wongold";
               break;
            case CafeWheelOfFortuneDialogProperties.TYPE_DECO:
            case CafeWheelOfFortuneDialogProperties.TYPE_RAREDECO:
               _loc2_ = "dialogwin_wheeloffortune_wonitem";
               break;
            case CafeWheelOfFortuneDialogProperties.TYPE_DISH:
            case CafeWheelOfFortuneDialogProperties.TYPE_INGREDIENT:
            case CafeWheelOfFortuneDialogProperties.TYPE_FANCY:
            case CafeWheelOfFortuneDialogProperties.TYPE_RAREINGREDIENT:
               _loc2_ = "dialogwin_wheeloffortune_wonfood";
         }
         this.wheelDialog.removeEventListener(Event.ENTER_FRAME,this.onGameLoop);
         this.wheelDialog.btn_close.enableButton = true;
         this.gameStarted = false;
         this.wof_framecounter = 0;
         this.youShallWinThisSlot = -1;
         this.wheelDialogProperties.firstPlay = false;
         CafeModel.userData.playedWheelOfFortune = true;
         this.setInstructions();
         this.setPlayButton();
         for each(_loc3_ in this.prizes)
         {
            if(_loc3_.wodId == CafeConstants.WODID_CASH)
            {
               CafeModel.userData.changeUserMoney(_loc3_["amount"]);
            }
            else if(_loc3_.wodId == CafeConstants.WODID_GOLD)
            {
               CafeModel.userData.changeUserMoney(0,_loc3_["amount"]);
            }
            else if(_loc3_.wodId == CafeConstants.WODID_XP)
            {
               CafeModel.userData.changeUserXp(_loc3_["amount"]);
            }
            else if(_loc3_ is BasicCounterVO || _loc3_ is BasicStoveVO || _loc3_ is BasicFridgeVO || _loc3_ is StaticTileVO || _loc3_ is BasicWallobjectVO || _loc3_ is StaticWallVO || _loc3_ is InteractiveFloorVO)
            {
               ++CafeModel.inventoryFurniture.numNew;
            }
         }
         CafeLayoutManager.getInstance().showDialog(CafeBonusDialog.NAME,new CafeBonusDialogProperties(CafeBonusDialogProperties.TYPE_WHEELOFFORTUNE,CafeModel.languageData.getTextById("dialogwin_receiveitem_title"),CafeModel.languageData.getTextById(_loc2_),this.prizes));
         CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_ACHIEVEMENT);
         controller.dispatchEvent(new CafeGiftEvent(CafeGiftEvent.CHANGE_MYGIFTS));
      }
      
      private function onError_noSpace() : void
      {
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("gift_error"),CafeModel.languageData.getTextById(NAME + "_nospace")));
      }
      
      private function onError_isGuest() : void
      {
         layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
      }
      
      private function onError_notEnoughGold() : void
      {
         layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById(NAME + "_nomoney")));
      }
      
      private function fillPrizes() : void
      {
         var _loc3_:WheelOfFortunePiece = null;
         var _loc4_:int = 0;
         var _loc1_:* = false;
         var _loc2_:int = 0;
         while(_loc2_ < CafeWheelOfFortuneDialogProperties.NUM_PRIZES)
         {
            _loc3_ = new WheelOfFortunePiece();
            if((_loc4_ = this.wheelDialogProperties.getPrizeTypeBySlot(_loc2_)) == CafeWheelOfFortuneDialogProperties.TYPE_GOLD || _loc4_ == CafeWheelOfFortuneDialogProperties.TYPE_MOREGOLD)
            {
               _loc3_.gotoAndStop(3);
            }
            else if(_loc4_ == CafeWheelOfFortuneDialogProperties.TYPE_RAREDECO)
            {
               _loc3_.gotoAndStop(4);
            }
            else if(_loc1_)
            {
               _loc3_.gotoAndStop(1);
            }
            else
            {
               _loc3_.gotoAndStop(2);
            }
            _loc1_ = !_loc1_;
            _loc3_.name = "part_" + _loc2_;
            _loc3_.partId = _loc2_;
            _loc3_.prize = _loc4_;
            _loc3_.deltaAngle = 360;
            _loc3_.cacheAsBitmap = true;
            _loc3_.mc_prize.gotoAndStop(_loc4_);
            _loc3_.rotation = _loc2_ * (360 / CafeWheelOfFortuneDialogProperties.NUM_PRIZES);
            this.wheelDialog.placeholder_pieces.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      private function setInstructions() : void
      {
         if(!this.gameStarted && !this.gameAlreadyPlayed)
         {
            this.wheelDialog.txt_info.text = CafeModel.languageData.getTextById(NAME + "_beforespin");
         }
         else if(!this.gameStarted)
         {
            this.wheelDialog.txt_info.text = CafeModel.languageData.getTextById(NAME + "_tryagain");
         }
         else
         {
            this.wheelDialog.txt_info.text = CafeModel.languageData.getTextById(NAME + "_beforespin");
         }
      }
      
      private function setPlayButton() : void
      {
         if(this.gameStarted)
         {
            this.wheelDialog.btn_go.visible = false;
         }
         else if(!this.gameAlreadyPlayed && this.wheelDialogProperties.firstPlay)
         {
            this.wheelDialog.btn_go.visible = true;
            this.wheelDialog.btn_go.mc_money.visible = false;
         }
         else
         {
            this.wheelDialog.btn_go.visible = true;
            this.wheelDialog.btn_go.mc_money.visible = true;
            this.wheelDialog.btn_go.mc_money.txt_gold.text = "x 1";
         }
      }
      
      private function get wheelDialogProperties() : CafeWheelOfFortuneDialogProperties
      {
         return properties as CafeWheelOfFortuneDialogProperties;
      }
      
      private function get wheelDialog() : CafeWheelOfFortune
      {
         return disp as CafeWheelOfFortune;
      }
   }
}
