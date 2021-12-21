package com.goodgamestudios.cafe.model.components
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.BasicConstants;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicUserData;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeShowBonusDialogCommand;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeShowPayCheckDialogCommand;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeBonusDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.LevelXpRelationVO;
   import com.goodgamestudios.cafe.world.vo.achievement.BasicAchievementVO;
   import com.goodgamestudios.cafe.world.vo.avatar.BasicAvatarVO;
   import com.goodgamestudios.cafe.world.vo.currency.CashCurrencyVO;
   import com.goodgamestudios.cafe.world.vo.currency.CurrencyVO;
   import com.goodgamestudios.cafe.world.vo.currency.GoldCurrencyVO;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.icon.BasicIconVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.cafe.world.vo.moving.HeroMovingVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.constants.CommonGameStates;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class CafeUserData extends BasicUserData
   {
       
      
      public var userXP:int;
      
      public var gender:int = 0;
      
      public var avatarParts:Array;
      
      public var heroVO:HeroMovingVO;
      
      public var firstLogin:Boolean = false;
      
      public var isPayUser:Boolean = false;
      
      public var paymentHashRequested:Boolean = false;
      
      public var allowEMails:Boolean = true;
      
      public var playedWheelOfFortune:Boolean = false;
      
      public var emailVerified:Boolean = false;
      
      private var _max_levelXP_level:int;
      
      private var _userCash:int;
      
      private var _userGold:int;
      
      private var _userLevel:int;
      
      private var _instantCookings:int;
      
      private var _levelXpXML:XML;
      
      private var _levelXp:Dictionary;
      
      private var _fancyPopupBlockedTimer:Timer;
      
      private var _instantPopupBlockedTimer:Timer;
      
      private var _refreshPopupBlockedTimer:Timer;
      
      private var _showFancyPopup:Boolean;
      
      private var _showInstantPopup:Boolean;
      
      private var _showInstantPopupWod:int;
      
      private var _showRefreshPopup:Boolean;
      
      private var _showRefreshPopupWod:int;
      
      public var changAvatarPrice:int;
      
      public function CafeUserData()
      {
         super();
      }
      
      public function parseUserData(param1:Array) : void
      {
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:BasicAvatarVO = null;
         CafeModel.sessionData.activeSpecialOffer = false;
         this._userLevel = -1;
         this.avatarParts = [];
         userID = param1.shift();
         playerID = param1.shift();
         param1.shift();
         this._userCash = param1.shift();
         this._userGold = param1.shift();
         this.userXP = param1.shift();
         this._instantCookings = param1.shift();
         var _loc2_:int = param1.shift();
         this.isPayUser = parseInt(param1.shift()) == 1;
         this.playedWheelOfFortune = parseInt(param1.shift()) == 1;
         this.changAvatarPrice = parseInt(param1.shift());
         var _loc3_:* = parseInt(param1.shift()) == 1;
         this.allowEMails = param1.shift() == 1;
         this.emailVerified = parseInt(param1.shift()) == 1;
         CafeModel.giftList.numNewGifts = param1.shift();
         if(CafeModel.giftList.numNewGifts >= CafeConstants.MAXGIFTS)
         {
            CafeLayoutManager.getInstance().showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_giftboxfull_title"),CafeModel.languageData.getTextById("alert_giftboxfull_copy")));
         }
         var _loc4_:Array = param1.shift().split("+");
         userName = _loc4_.shift();
         this.gender = _loc4_.shift();
         _loc4_ = _loc4_.shift().split("#");
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc7_ = (_loc6_ = _loc4_[_loc5_].split("$")).shift();
            if(CafeModel.sessionData.isEventActive(CafeConstants.EVENT_CHRISTMAS))
            {
               if(_loc7_ == 1062)
               {
                  _loc7_ = 1063;
               }
            }
            (_loc8_ = CafeModel.wodData.createVObyWOD(_loc7_) as BasicAvatarVO).currentColor = _loc6_.shift();
            this.avatarParts.push(_loc8_);
            _loc5_++;
         }
         this.heroVO = CafeModel.wodData.createVObyWOD(1605) as HeroMovingVO;
         this.heroVO.avatarParts = this.avatarParts;
         this.heroVO.playerId = playerID;
         this.heroVO.userId = userID;
         this.heroVO.openJobs = _loc2_;
         this.heroVO.allowFriendRequest = _loc3_;
         BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.INIT_USERDATA));
         this.resetFancyPopupBlockedTimer();
         this._fancyPopupBlockedTimer = new Timer(BasicConstants.POPUP_TIME_INTERVAL,1);
         this.resetInstantPopupBlockedTimer();
         this._instantPopupBlockedTimer = new Timer(BasicConstants.POPUP_TIME_INTERVAL,1);
         this.resetRefereshPopupBlockedTimer();
         this._refreshPopupBlockedTimer = new Timer(BasicConstants.POPUP_TIME_INTERVAL,1);
      }
      
      public function startFancyPopupTimer(param1:int) : void
      {
         this._showInstantPopupWod = param1;
         this._fancyPopupBlockedTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onFancyPopupBlockedTimerComplete);
         this._fancyPopupBlockedTimer.start();
         this._showFancyPopup = false;
      }
      
      public function resetFancyPopupBlockedTimer() : void
      {
         if(this._fancyPopupBlockedTimer)
         {
            this._fancyPopupBlockedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onFancyPopupBlockedTimerComplete);
         }
         this._showFancyPopup = true;
      }
      
      private function onFancyPopupBlockedTimerComplete(param1:TimerEvent) : void
      {
         this.resetFancyPopupBlockedTimer();
      }
      
      public function startRefereshPopupTimer(param1:int) : void
      {
         this._showRefreshPopupWod = param1;
         this._refreshPopupBlockedTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onRefereshPopupBlockedTimerComplete);
         this._refreshPopupBlockedTimer.start();
         this._showRefreshPopup = false;
      }
      
      private function onRefereshPopupBlockedTimerComplete(param1:TimerEvent) : void
      {
         this.resetRefereshPopupBlockedTimer();
      }
      
      public function resetRefereshPopupBlockedTimer() : void
      {
         if(this._refreshPopupBlockedTimer)
         {
            this._refreshPopupBlockedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onRefereshPopupBlockedTimerComplete);
         }
         this._showRefreshPopupWod = -1;
         this._showRefreshPopup = true;
      }
      
      public function startInstantPopupTimer(param1:int) : void
      {
         this._showInstantPopupWod = param1;
         this._instantPopupBlockedTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onInstantPopupBlockedTimerComplete);
         this._instantPopupBlockedTimer.start();
         this._showInstantPopup = false;
      }
      
      public function resetInstantPopupBlockedTimer() : void
      {
         if(this._instantPopupBlockedTimer)
         {
            this._instantPopupBlockedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onInstantPopupBlockedTimerComplete);
         }
         this._showInstantPopupWod = -1;
         this._showInstantPopup = true;
      }
      
      private function onInstantPopupBlockedTimerComplete(param1:TimerEvent) : void
      {
         this.resetInstantPopupBlockedTimer();
      }
      
      public function showRefreshPopup(param1:int) : Boolean
      {
         if(this._showRefreshPopupWod != param1)
         {
            return true;
         }
         return this._showRefreshPopup;
      }
      
      public function showInstantPopup(param1:int) : Boolean
      {
         if(this._showInstantPopupWod != param1)
         {
            return true;
         }
         return this._showInstantPopup;
      }
      
      public function get showFancyPopup() : Boolean
      {
         return this.userLevel >= CafeConstants.LEVEL_FOR_FANCYS && this._showFancyPopup;
      }
      
      public function changeAvatarParts(param1:String, param2:Boolean = true) : void
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:BasicAvatarVO = null;
         if(!param1)
         {
            return;
         }
         if(this.env.gameState == CommonGameStates.CONNECT_FAILED || this.env.gameState == CommonGameStates.CONNECTION_LOST || this.env.gameState == CommonGameStates.CONNECT_TIMEOUT || this.env.gameState == CommonGameStates.USER_LOGOUT)
         {
            return;
         }
         this.changAvatarPrice = !!param2 ? 1 : 0;
         var _loc3_:Array = param1.split("+");
         userName = _loc3_.shift();
         this.gender = _loc3_.shift();
         _loc3_ = _loc3_.shift().split("#");
         this.avatarParts = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc6_ = (_loc5_ = _loc3_[_loc4_].split("$")).shift();
            if(CafeModel.sessionData.isEventActive(CafeConstants.EVENT_CHRISTMAS))
            {
               if(_loc6_ == 1062)
               {
                  _loc6_ = 1063;
               }
            }
            (_loc7_ = CafeModel.wodData.createVObyWOD(_loc6_) as BasicAvatarVO).currentColor = _loc5_.shift();
            this.avatarParts.push(_loc7_);
            _loc4_++;
         }
         if(this.heroVO)
         {
            this.heroVO.avatarParts = this.avatarParts;
         }
         BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.CHANGE_AVATAR));
      }
      
      public function checkMoneyChanges(param1:int = 0, param2:int = 0) : void
      {
         if(CafeModel.levelData.levelVO && CafeModel.levelData.levelVO.worldType != CafeConstants.CAFE_WORLD_TYPE_MYCAFE)
         {
            return;
         }
         this.changeUserMoney(param1,param2);
      }
      
      public function changeUserMoney(param1:int = 0, param2:int = 0) : void
      {
         var _loc3_:Array = new Array();
         this._userCash += param1;
         this._userGold += param2;
         if(param1 != 0)
         {
            _loc3_.push(CafeConstants.WODID_CASH);
         }
         if(param2 != 0)
         {
            _loc3_.push(CafeConstants.WODID_GOLD);
         }
         BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.CHANGE_USERDATA,_loc3_));
      }
      
      public function checkXPChanges(param1:int = 0) : void
      {
         if(CafeModel.levelData.levelVO && CafeModel.levelData.levelVO.worldType != CafeConstants.CAFE_WORLD_TYPE_MYCAFE)
         {
            return;
         }
         this.changeUserXp(param1);
      }
      
      public function changeUserXp(param1:int = 0) : void
      {
         this.userXP += param1;
         var _loc2_:int = this._userLevel;
         this._userLevel = this.getLevelByXp(this.userXP);
         if(_loc2_ >= 0 && _loc2_ != this._userLevel)
         {
            this.levelUp(this._userLevel - _loc2_);
         }
         else
         {
            BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.CHANGE_USERDATA));
         }
      }
      
      public function get userLevel() : int
      {
         if(this._userLevel >= 0)
         {
            return this._userLevel;
         }
         this._userLevel = this.getLevelByXp(this.userXP);
         return this._userLevel;
      }
      
      public function get cash() : int
      {
         return this._userCash;
      }
      
      public function get gold() : int
      {
         return this._userGold;
      }
      
      public function get isMyPlayerWaiter() : Boolean
      {
         return this.heroVO.isWaiter;
      }
      
      public function get xpToNextLevel() : int
      {
         if(DictionaryUtil.containsKey(this._levelXp,this.userLevel + 1))
         {
            return this.getXpByLevel(this.userLevel + 1) - this.userXP;
         }
         return 0;
      }
      
      public function get xpToNextLevelPercent() : Number
      {
         var _loc1_:int = 0;
         if(DictionaryUtil.containsKey(this._levelXp,this.userLevel + 1))
         {
            _loc1_ = this.getXpByLevel(this.userLevel + 1) - this.getXpByLevel(this.userLevel);
            return (_loc1_ - this.xpToNextLevel) / _loc1_;
         }
         return 1;
      }
      
      public function set levelXpXML(param1:XML) : void
      {
         this._levelXpXML = param1;
         this.parseLevelXpXML();
      }
      
      private function parseLevelXpXML() : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         this._max_levelXP_level = 0;
         this._levelXp = new Dictionary();
         var _loc1_:XMLList = this._levelXpXML.elements();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = parseInt(_loc2_.attribute("l"));
            _loc4_ = this.getXpByLevel(_loc3_);
            _loc5_ = parseInt(_loc2_.attribute("w"));
            _loc6_ = parseInt(_loc2_.attribute("f"));
            _loc7_ = parseInt(_loc2_.attribute("s"));
            _loc8_ = parseInt(_loc2_.attribute("c"));
            _loc9_ = parseInt(_loc2_.attribute("i"));
            _loc10_ = parseInt(_loc2_.attribute("g"));
            _loc11_ = parseInt(_loc2_.attribute("ch"));
            this._levelXp[_loc3_] = new LevelXpRelationVO(_loc3_,_loc4_,_loc10_,_loc11_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
            if(_loc3_ > this._max_levelXP_level)
            {
               this._max_levelXP_level = _loc3_;
            }
         }
      }
      
      private function getXpByLevel(param1:int) : int
      {
         if(param1 <= 2)
         {
            return Math.floor(Math.pow(param1,2) + 0.99) * 10;
         }
         return Math.floor(Math.pow(param1,3.72) + 0.99) * 5;
      }
      
      public function getLevelByXp(param1:int) : int
      {
         if(param1 < 90)
         {
            return Math.floor(Math.pow(Math.floor(param1 / 10),1 / 2));
         }
         return Math.floor(Math.pow(Math.floor(param1 / 5),1 / 3.72));
      }
      
      public function get levelXpRelation() : LevelXpRelationVO
      {
         if(this.userLevel < this._max_levelXP_level)
         {
            return this._levelXp[this.userLevel];
         }
         return this._levelXp[this._max_levelXP_level];
      }
      
      public function getLevelXpRelationByLevel(param1:int) : LevelXpRelationVO
      {
         if(param1 < this._max_levelXP_level)
         {
            return this._levelXp[param1];
         }
         return this._levelXp[this._max_levelXP_level];
      }
      
      public function levelByGroupRelation(param1:String, param2:int) : int
      {
         var _loc3_:LevelXpRelationVO = null;
         for each(_loc3_ in this._levelXp)
         {
            if(_loc3_[param1] == param2)
            {
               return _loc3_.level;
            }
         }
         return -1;
      }
      
      public function get instantCookings() : int
      {
         return this._instantCookings;
      }
      
      public function set instantCookings(param1:int) : void
      {
         this._instantCookings = param1;
      }
      
      public function get canInstaCook() : Boolean
      {
         return CafeTutorialController.getInstance().isActive || this.instaCookLeft > 0 && CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_INSTANTCOOKING;
      }
      
      public function get instaCookLeft() : int
      {
         return this.levelXpRelation.instant - this._instantCookings;
      }
      
      public function jobPaycheck(param1:Array) : void
      {
         var _loc2_:int = param1.shift();
         var _loc3_:int = param1.shift();
         this.changeUserMoney(_loc2_,0);
         this.changeUserXp(_loc3_);
         CommandController.instance.executeCommand(CafeShowPayCheckDialogCommand.COMMAND_NAME,[_loc2_,_loc3_]);
      }
      
      public function refillJobs() : void
      {
         this.changeUserMoney(0,-CafeConstants.jobRefillGold);
         this.heroVO.openJobs = CafeConstants.jobsPerDay;
         BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.CHANGE_JOBAMOUNT));
      }
      
      public function resetWorkTime() : void
      {
         this.heroVO.workTimeLeft = 0;
         this.heroVO.isWaiter = false;
      }
      
      public function setWorkTime(param1:Number) : void
      {
         this.heroVO.workTimeLeft = param1;
         this.heroVO.isWaiter = param1 > 0;
         --this.heroVO.openJobs;
         BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.CHANGE_JOBAMOUNT));
      }
      
      public function socialLoginBonus(param1:Array, param2:int, param3:String = "") : void
      {
         var _loc6_:VisualVO = null;
         var _loc4_:Array = new Array();
         var _loc5_:Array;
         if((_loc5_ = param1.shift().split("+"))[0] > 0)
         {
            if((_loc6_ = CafeModel.wodData.createVObyWOD(_loc5_[0])) is CurrencyVO)
            {
               (_loc6_ as CurrencyVO).amount = _loc5_[1];
               _loc4_.push(_loc6_);
            }
            else if(_loc6_ is BasicIconVO)
            {
               (_loc6_ as BasicIconVO).amount = _loc5_[1];
               _loc4_.push(_loc6_);
            }
            else if(_loc6_ is BasicDishVO)
            {
               (_loc6_ as BasicDishVO).amount = _loc5_[1];
               _loc4_.push(_loc6_);
            }
            else if(_loc6_ is BasicIngredientVO)
            {
               (_loc6_ as BasicIngredientVO).amount = _loc5_[1];
               _loc4_.push(_loc6_);
            }
         }
         if(_loc4_.length > 0)
         {
            BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.BONUS,[param2,param3,_loc4_]));
            CommandController.instance.executeCommand(CafeShowBonusDialogCommand.COMMAND_NAME,[param2,param3,_loc4_]);
         }
      }
      
      public function loginBonus(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc7_:VisualVO = null;
         var _loc2_:Array = new Array();
         var _loc4_:Array = param1.shift().split("#");
         while(_loc4_.length > 0 && _loc4_[0] != "")
         {
            _loc3_ = _loc4_.shift().split("+");
            if((_loc7_ = CafeModel.wodData.createVObyWOD(_loc3_[0])) is CurrencyVO)
            {
               (_loc7_ as CurrencyVO).amount = _loc3_[1];
               _loc2_.push(_loc7_);
            }
            if(_loc7_ is BasicIngredientVO)
            {
               (_loc7_ as BasicIngredientVO).amount = _loc3_[1];
               _loc2_.push(_loc7_);
            }
            if(_loc7_ is BasicDishVO)
            {
               (_loc7_ as BasicDishVO).amount = _loc3_[1];
               _loc2_.push(_loc7_);
            }
         }
         var _loc5_:BasicAchievementVO;
         (_loc5_ = CafeModel.wodData.createVObyWOD(CafeConstants.WODID_SERVINGACHIEVEMENT) as BasicAchievementVO).amount = param1.shift();
         var _loc6_:CashCurrencyVO;
         (_loc6_ = CafeModel.wodData.createVObyWOD(CafeConstants.WODID_CASH) as CashCurrencyVO).amount = param1.shift();
         if(_loc6_.amount > 0)
         {
            _loc2_.push(_loc6_);
         }
         if(_loc5_.amount > 0)
         {
            _loc2_.push(_loc5_);
         }
         if(_loc2_.length > 0)
         {
            BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.BONUS,[CafeBonusDialogProperties.TYPE_LOGINBONUS,_loc2_]));
            CommandController.instance.executeCommand(CafeShowBonusDialogCommand.COMMAND_NAME,[CafeBonusDialogProperties.TYPE_LOGINBONUS,_loc2_]);
         }
      }
      
      public function levelUp(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:VisualVO = null;
         var _loc6_:VisualVO = null;
         var _loc7_:VisualVO = null;
         var _loc8_:VisualVO = null;
         var _loc9_:Array = null;
         var _loc10_:Array = [];
         this.checkLevelTextAchievement();
         CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_LEVELUP);
         _loc5_ = this.checkExpandAchievement(param1,"counter",CafeConstants.WODID_COUNTER);
         _loc6_ = this.checkExpandAchievement(param1,"fridge",CafeConstants.WODID_FRIDGE);
         _loc7_ = this.checkExpandAchievement(param1,"stove",CafeConstants.WODID_STOVE);
         _loc8_ = this.checkExpandAchievement(param1,"waiter",CafeConstants.WODID_WAITER);
         _loc9_ = this.checkRecipeAchievement(param1);
         _loc4_ = this.checkLevelUpAchievement(param1);
         if(_loc5_)
         {
            _loc10_.push(_loc5_);
         }
         if(_loc6_)
         {
            _loc10_.push(_loc6_);
         }
         if(_loc7_)
         {
            _loc10_.push(_loc7_);
         }
         if(_loc8_)
         {
            _loc10_.push(_loc8_);
         }
         BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.LEVELUP,[CafeBonusDialogProperties.TYPE_LEVELUP,_loc4_,_loc9_,_loc10_]));
         CommandController.instance.executeCommand(CafeShowBonusDialogCommand.COMMAND_NAME,[CafeBonusDialogProperties.TYPE_LEVELUP,_loc4_,_loc9_,_loc10_]);
      }
      
      private function checkLevelUpAchievement(param1:int) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:CashCurrencyVO = CafeModel.wodData.createVObyWOD(CafeConstants.WODID_CASH) as CashCurrencyVO;
         var _loc4_:GoldCurrencyVO = CafeModel.wodData.createVObyWOD(CafeConstants.WODID_GOLD) as GoldCurrencyVO;
         var _loc5_:int = this.userLevel;
         while(_loc5_ > this.userLevel - param1)
         {
            _loc3_.amount += this.getLevelXpRelationByLevel(_loc5_).cash;
            _loc4_.amount += this.getLevelXpRelationByLevel(_loc5_).gold;
            _loc5_--;
         }
         if(_loc3_.amount > 0)
         {
            _loc2_.push(_loc3_);
         }
         if(_loc4_.amount > 0)
         {
            _loc2_.push(_loc4_);
         }
         this.changeUserMoney(_loc3_.amount,_loc4_.amount);
         return _loc2_;
      }
      
      private function checkRecipeAchievement(param1:int) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = this.userLevel;
         while(_loc3_ > this.userLevel - param1)
         {
            _loc2_ = _loc2_.concat(CafeModel.cookBook.getDishesByLevel(_loc3_));
            _loc3_--;
         }
         return _loc2_;
      }
      
      private function checkExpandAchievement(param1:int, param2:String, param3:int) : VisualVO
      {
         var _loc4_:VisualVO = CafeModel.wodData.createVObyWOD(param3);
         if(!this._levelXp[this.userLevel - param1])
         {
            return null;
         }
         if(this.levelXpRelation[param2] > this._levelXp[this.userLevel - param1][param2])
         {
            return _loc4_;
         }
         return null;
      }
      
      private function checkLevelTextAchievement() : void
      {
      }
      
      private function get env() : CafeEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      public function get levelXp() : Dictionary
      {
         return this._levelXp;
      }
   }
}
