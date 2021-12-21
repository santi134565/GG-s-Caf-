package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeCoopEvent;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.BuddyVO;
   import com.goodgamestudios.cafe.world.vo.coop.BasicCoopVO;
   import com.goodgamestudios.cafe.world.vo.coop.CoopRequirementVO;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class CafeCoopDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeCoopDialog";
      
      private static const STATE_NEWCOOP:int = 1;
      
      private static const STATE_ACTIVECOOPS:int = 2;
      
      private static const STATE_CURRENTCOOP:int = 3;
      
      private static const STATE_COOPINFO:int = 4;
      
      private static const REFRESHTIME:int = 3000;
      
      private static const DISHLIST_SPACE_1:int = 70;
      
      private static const DISHLIST_SPACE_2:int = 115;
      
      private static const DISHLIST_BOX:int = 45;
      
      private static const PLAYERLIST_SPACE:int = 118;
       
      
      private var _currentState:int;
      
      private var _maxPage:int;
      
      private var _currentPage:int;
      
      private var _lastRefresh:Number = 0;
      
      private var _currentCoop:BasicCoopVO;
      
      public function CafeCoopDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         this._maxPage = 0;
         this._currentPage = 0;
         this.coopDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_coop_txt_title");
         controller.addEventListener(CafeCoopEvent.CHANGE_ACTIVE_COOPLIST,this.onChangeActiveCoopList);
         controller.addEventListener(CafeCoopEvent.CHANGE_ACTIVE_DETAILS,this.onChangeActiveDetails);
         this.coopDialog.cooplist.i0.visible = false;
         this.coopDialog.cooplist.i1.visible = false;
         this.coopDialog.cooplist.i2.visible = false;
         this.coopDialog.cooplist.i3.visible = false;
      }
      
      private function onChangeActiveDetails(param1:CafeCoopEvent) : void
      {
         if(disp.visible)
         {
            this._currentCoop = param1.params.shift();
            this.changeState(STATE_CURRENTCOOP);
         }
      }
      
      private function onChangeActiveCoopList(param1:CafeCoopEvent) : void
      {
         this.changeState(STATE_ACTIVECOOPS);
      }
      
      override protected function applyProperties() : void
      {
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         super.onClick(param1);
         switch(this._currentState)
         {
            case STATE_ACTIVECOOPS:
            case STATE_NEWCOOP:
               switch(param1.target)
               {
                  case this.coopDialog.cooplist.btn_activecoops:
                     CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_ACTIVELIST,[]);
                     break;
                  case this.coopDialog.cooplist.btn_newcoop:
                     this.changeState(STATE_NEWCOOP);
                     break;
                  case this.coopDialog.cooplist.btn_arrow_left:
                  case this.coopDialog.cooplist.btn_arrow_right:
                     this.onClickArrow(param1);
                     break;
                  case this.coopDialog.cooplist.i0.btn_action:
                  case this.coopDialog.cooplist.i1.btn_action:
                  case this.coopDialog.cooplist.i2.btn_action:
                  case this.coopDialog.cooplist.i3.btn_action:
                     this.onClickCoopListItem(param1);
               }
               break;
            case STATE_COOPINFO:
               switch(param1.target)
               {
                  case this.coopDialog.coopInfoNew.btn_start:
                     if(param1.target.enabled)
                     {
                        if(CafeModel.userData.isGuest())
                        {
                           layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
                        }
                        else
                        {
                           CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_START,[this._currentCoop.wodId]);
                        }
                     }
                     break;
                  case this.coopDialog.coopInfoNew.btn_cancel:
                     this.changeState(STATE_NEWCOOP);
               }
               break;
            case STATE_CURRENTCOOP:
               switch(param1.target)
               {
                  case this.coopDialog.coopInfoActive.btn_join:
                     CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_JOIN,[this._currentCoop.coopInstanceID]);
                     break;
                  case this.coopDialog.coopInfoActive.btn_quit:
                     layoutManager.showDialog(CafeStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("generic_alert_information"),CafeModel.languageData.getTextById("dialogwin_coop_quit_copy"),this.onQuitCoop,null,null,CafeModel.languageData.getTextById("btn_text_yes"),CafeModel.languageData.getTextById("btn_text_cancle")));
                     break;
                  case this.coopDialog.coopInfoActive.btn_extendTime:
                     layoutManager.showDialog(CafeBigYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("dialogwin_coop_extendtime_title"),CafeModel.languageData.getTextById("dialogwin_coop_extendtime_copy",[CafeConstants.coopExpansionGold,CafeConstants.coopExpansionHoures * CafeConstants.coopTimeToGold,CafeConstants.coopExpansionHoures * CafeConstants.coopTimeToSilver,CafeConstants.coopExpansionHoures]),this.onExtendTime,null,null,CafeModel.languageData.getTextById("btn_text_yes"),CafeModel.languageData.getTextById("btn_text_cancle")));
                     break;
                  case this.coopDialog.coopInfoActive.btn_refresh:
                     _loc2_ = getTimer();
                     if(this._lastRefresh + REFRESHTIME < _loc2_)
                     {
                        CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_DETAIL,[this._currentCoop.coopInstanceID]);
                        this._lastRefresh = _loc2_;
                     }
                     break;
                  case this.coopDialog.coopInfoActive.btn_back:
                     CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_ACTIVELIST,[]);
                     break;
                  default:
                     if(param1.target is CoopMembersContainer)
                     {
                        this.onClickPlayerItem(param1);
                     }
               }
         }
         switch(param1.target)
         {
            case this.coopDialog.btn_close:
               this.hide();
               break;
            case this.coopDialog.btn_info:
               layoutManager.showDialog(CafeCoopsHelpDialog.NAME);
         }
      }
      
      private function onQuitCoop(param1:Array = null) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_LEAVE,[]);
         CafeModel.coopData.clearActiveCoop();
         this.changeState(STATE_NEWCOOP);
      }
      
      private function onExtendTime(param1:Array = null) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_EXTEND,[]);
      }
      
      private function onClickPlayerItem(param1:MouseEvent) : void
      {
         if((param1.target.buddyVO as BuddyVO).playerId != CafeModel.userData.playerID)
         {
            layoutManager.playerActionChoices.initPlayerActionChoices(param1.target.mc_avatarholder,param1.target.buddyVO);
         }
      }
      
      private function changeState(param1:int) : void
      {
         switch(param1)
         {
            case STATE_NEWCOOP:
               this._currentPage = 0;
               this.coopDialog.gotoAndStop(1);
               this.coopDialog.cooplist.gotoAndStop(2);
               this.fillItems(false);
               this.coopDialog.cooplist.btn_activecoops.label = CafeModel.languageData.getTextById("dialogwin_coop_btn_activecoops");
               this.coopDialog.cooplist.btn_newcoop.label = CafeModel.languageData.getTextById("dialogwin_coop_btn_newcoop");
               break;
            case STATE_ACTIVECOOPS:
               this._currentPage = 0;
               this.coopDialog.gotoAndStop(1);
               this.coopDialog.cooplist.gotoAndStop(1);
               this.fillItems(true);
               this.coopDialog.cooplist.btn_activecoops.label = CafeModel.languageData.getTextById("dialogwin_coop_btn_activecoops");
               this.coopDialog.cooplist.btn_newcoop.label = CafeModel.languageData.getTextById("dialogwin_coop_btn_newcoop");
               break;
            case STATE_COOPINFO:
               this.coopDialog.gotoAndStop(2);
               this.fillCoopInfoNew();
               break;
            case STATE_CURRENTCOOP:
               this.coopDialog.gotoAndStop(3);
               this.fillCoopInfoActive();
         }
         this._currentState = param1;
      }
      
      private function getStaticCoopList() : Vector.<BasicCoopVO>
      {
         var _loc2_:BasicCoopVO = null;
         var _loc1_:Vector.<BasicCoopVO> = new Vector.<BasicCoopVO>();
         for each(_loc2_ in CafeModel.coopData.staticCoopList)
         {
            if(_loc2_.isItemAvalibleByEvent())
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function fillItems(param1:Boolean) : void
      {
         var _loc2_:Vector.<BasicCoopVO> = null;
         var _loc5_:int = 0;
         var _loc6_:CoopItem = null;
         var _loc7_:BasicCoopVO = null;
         updateAllTextFields();
         if(param1)
         {
            _loc2_ = CafeModel.coopData.activeCoopList;
         }
         else
         {
            _loc2_ = this.getStaticCoopList();
         }
         var _loc3_:int = this._currentPage * this.coopDialogProperties.itemsPerPage;
         this.initArrows(_loc2_.length);
         var _loc4_:int = _loc3_;
         while(_loc4_ < _loc3_ + this.coopDialogProperties.itemsPerPage)
         {
            _loc5_ = _loc4_ - _loc3_;
            _loc6_ = this.coopDialog.cooplist["i" + _loc5_] as CoopItem;
            if(_loc4_ < _loc2_.length)
            {
               _loc7_ = _loc2_[_loc4_];
               if(CafeModel.coopData.activeCoop && _loc7_.coopInstanceID == CafeModel.coopData.activeCoop.coopInstanceID)
               {
                  _loc6_.bg.gotoAndStop(2);
               }
               else
               {
                  _loc6_.bg.gotoAndStop(1);
               }
               _loc6_.btn_action.coopVO = _loc7_;
               _loc6_.txt_cash.text = String(_loc7_.rewardCash(CafeConstants.COOP_FINISHLEVEL_GOLD));
               _loc6_.txt_gold.text = String(_loc7_.rewardGold(CafeConstants.COOP_FINISHLEVEL_GOLD));
               _loc6_.txt_xp.text = String(_loc7_.rewardXP(CafeConstants.COOP_FINISHLEVEL_GOLD));
               if(param1)
               {
                  _loc6_.txt_time.text = TimeStringHelper.getTimeToString(_loc7_.timeleftBronze(),TimeStringHelper.ONE_TIME_FORMAT_ADVANCED,CafeModel.languageData.getTextById);
               }
               else
               {
                  _loc6_.txt_time.text = TimeStringHelper.getTimeToString(_loc7_.duration,TimeStringHelper.ONE_TIME_FORMAT_ADVANCED,CafeModel.languageData.getTextById);
               }
               _loc6_.txt_title.text = CafeModel.languageData.getTextById("coop_title_" + _loc7_.type);
               _loc6_.txt_description_short.text = CafeModel.languageData.getTextById("coop_desc_short_" + _loc7_.type);
               _loc6_.btn_action.label = CafeModel.languageData.getTextById("dialogwin_coop_btn_action");
               this.drawCoopPic(_loc6_.mc_cooppicholder,_loc7_);
               _loc6_.visible = true;
            }
            else
            {
               _loc6_.visible = false;
            }
            _loc4_++;
         }
      }
      
      private function fillCoopInfoActive() : void
      {
         if(!this._currentCoop)
         {
            return;
         }
         var _loc1_:int = 20;
         var _loc2_:int = -120;
         var _loc3_:int = -130;
         updateAllTextFields();
         while(this.coopDialog.coopInfoActive.mc_holder.numChildren > 0)
         {
            this.coopDialog.coopInfoActive.mc_holder.removeChildAt(0);
         }
         this.coopDialog.coopInfoActive.txt_title.text = CafeModel.languageData.getTextById("coop_title_" + this._currentCoop.type);
         this.coopDialog.coopInfoActive.txt_description_short.text = CafeModel.languageData.getTextById("coop_desc_short_" + this._currentCoop.type);
         this.coopDialog.coopInfoActive.txt_progress.text = String(Math.floor(this._currentCoop.progress() * 100)) + " %";
         this.coopDialog.coopInfoActive.txt_timeleft.text = CafeModel.languageData.getTextById("dialogwin_coop_timeleft");
         this.coopDialog.coopInfoActive.txt_timeGold.text = TimeStringHelper.getTimeToString(this._currentCoop.timeleftGold(),TimeStringHelper.TWO_TIME_FORMAT,CafeModel.languageData.getTextById,true);
         if(this.coopDialog.coopInfoActive.txt_timeGold.textHeight < 20)
         {
            this.coopDialog.coopInfoActive.txt_timeGold.y = _loc2_;
         }
         else
         {
            this.coopDialog.coopInfoActive.txt_timeGold.y = _loc3_;
         }
         this.coopDialog.coopInfoActive.txt_timeSilver.text = TimeStringHelper.getTimeToString(this._currentCoop.timeleftSilver(),TimeStringHelper.TWO_TIME_FORMAT,CafeModel.languageData.getTextById,true);
         if(this.coopDialog.coopInfoActive.txt_timeSilver.textHeight < 20)
         {
            this.coopDialog.coopInfoActive.txt_timeSilver.y = _loc2_;
         }
         else
         {
            this.coopDialog.coopInfoActive.txt_timeSilver.y = _loc3_;
         }
         this.coopDialog.coopInfoActive.txt_timeBronze.text = TimeStringHelper.getTimeToString(this._currentCoop.timeleftBronze(),TimeStringHelper.TWO_TIME_FORMAT,CafeModel.languageData.getTextById,true);
         if(this.coopDialog.coopInfoActive.txt_timeBronze.textHeight < 20)
         {
            this.coopDialog.coopInfoActive.txt_timeBronze.y = _loc2_;
         }
         else
         {
            this.coopDialog.coopInfoActive.txt_timeBronze.y = _loc3_;
         }
         this.coopDialog.coopInfoActive.txt_mealsInfo.text = CafeModel.languageData.getTextById("dialogwin_coop_subtitle");
         this.coopDialog.coopInfoActive.txt_membersInfo.text = CafeModel.languageData.getTextById("dialogwin_coop_member");
         this.coopDialog.coopInfoActive.btn_join.label = CafeModel.languageData.getTextById("dialogwin_coop_btn_join");
         this.coopDialog.coopInfoActive.btn_quit.label = CafeModel.languageData.getTextById("dialogwin_coop_btn_quit");
         this.coopDialog.coopInfoActive.btn_refresh.label = CafeModel.languageData.getTextById("generic_btn_refresh");
         this.coopDialog.coopInfoActive.btn_back.label = CafeModel.languageData.getTextById("generic_btn_goback");
         if(CafeModel.coopData.activeCoop)
         {
            this.coopDialog.coopInfoActive.btn_join.visible = false;
            this.coopDialog.coopInfoActive.btn_quit.visible = this._currentCoop.coopInstanceID == CafeModel.coopData.activeCoop.coopInstanceID;
            this.coopDialog.coopInfoActive.btn_extendTime.visible = this._currentCoop.coopInstanceID == CafeModel.coopData.activeCoop.coopInstanceID && this._currentCoop.finishLevel < 0;
         }
         else
         {
            this.coopDialog.coopInfoActive.btn_join.visible = this._currentCoop.finishLevel < 0 && this._currentCoop.coopPlayer.length < this._currentCoop.maxMember;
            this.coopDialog.coopInfoActive.btn_quit.visible = this._currentCoop.finishLevel >= 0;
            this.coopDialog.coopInfoActive.btn_extendTime.visible = false;
         }
         this.drawCoopPic(this.coopDialog.coopInfoActive.mc_cooppicholder,this._currentCoop);
         this.drawRquirements(this.coopDialog.coopInfoActive.mc_holder,25,true);
         this.drawPlayerAvatars(this.coopDialog.coopInfoActive.mc_holder,120);
      }
      
      private function fillCoopInfoNew() : void
      {
         if(!this._currentCoop)
         {
            return;
         }
         updateAllTextFields();
         this.coopDialog.coopInfoNew.txt_title.text = CafeModel.languageData.getTextById("coop_title_" + this._currentCoop.type);
         this.coopDialog.coopInfoNew.txt_description_short.text = CafeModel.languageData.getTextById("coop_desc_short_" + this._currentCoop.type);
         this.coopDialog.coopInfoNew.txt_description_long.text = CafeModel.languageData.getTextById("coop_desc_long_" + this._currentCoop.type);
         this.coopDialog.coopInfoNew.txt_subtitle.text = CafeModel.languageData.getTextById("dialogwin_coop_subtitle");
         this.coopDialog.coopInfoNew.txt_maxMember.text = CafeModel.languageData.getTextById("dialogwin_coop_maxuser",[this._currentCoop.maxMember]);
         this.coopDialog.coopInfoNew.txt_maxLevel.text = CafeModel.languageData.getTextById("dialogwin_coop_minlevel",[CafeModel.coopData.minLevelByCoop(this._currentCoop)]);
         this.coopDialog.coopInfoNew.txt_timeInfo1.text = CafeModel.languageData.getTextById("dialogwin_coop_timeInfo");
         this.coopDialog.coopInfoNew.txt_timeInfo2.text = CafeModel.languageData.getTextById("dialogwin_coop_timeInfo");
         this.coopDialog.coopInfoNew.txt_timeInfo3.text = CafeModel.languageData.getTextById("dialogwin_coop_timeInfo");
         this.coopDialog.coopInfoNew.txt_time_gold.text = TimeStringHelper.getTimeToString(this._currentCoop.duration * CafeConstants.coopTimeToGold,TimeStringHelper.ONE_TIME_FORMAT_ADVANCED,CafeModel.languageData.getTextById);
         this.coopDialog.coopInfoNew.txt_gold_gold.text = this._currentCoop.rewardGold(CafeConstants.COOP_FINISHLEVEL_GOLD);
         this.coopDialog.coopInfoNew.txt_cash_gold.text = this._currentCoop.rewardCash(CafeConstants.COOP_FINISHLEVEL_GOLD);
         this.coopDialog.coopInfoNew.txt_xp_gold.text = this._currentCoop.rewardXP(CafeConstants.COOP_FINISHLEVEL_GOLD);
         this.coopDialog.coopInfoNew.txt_time_silver.text = TimeStringHelper.getTimeToString(this._currentCoop.duration * CafeConstants.coopTimeToSilver,TimeStringHelper.ONE_TIME_FORMAT_ADVANCED,CafeModel.languageData.getTextById);
         this.coopDialog.coopInfoNew.txt_gold_silver.text = this._currentCoop.rewardGold(CafeConstants.COOP_FINISHLEVEL_SILVER);
         this.coopDialog.coopInfoNew.txt_cash_silver.text = this._currentCoop.rewardCash(CafeConstants.COOP_FINISHLEVEL_SILVER);
         this.coopDialog.coopInfoNew.txt_xp_silver.text = this._currentCoop.rewardXP(CafeConstants.COOP_FINISHLEVEL_SILVER);
         this.coopDialog.coopInfoNew.txt_time_bronze.text = TimeStringHelper.getTimeToString(this._currentCoop.duration,TimeStringHelper.ONE_TIME_FORMAT_ADVANCED,CafeModel.languageData.getTextById);
         this.coopDialog.coopInfoNew.txt_gold_bronze.text = this._currentCoop.rewardGold(CafeConstants.COOP_FINISHLEVEL_BRONZE);
         this.coopDialog.coopInfoNew.txt_cash_bronze.text = this._currentCoop.rewardCash(CafeConstants.COOP_FINISHLEVEL_BRONZE);
         this.coopDialog.coopInfoNew.txt_xp_bronze.text = this._currentCoop.rewardXP(CafeConstants.COOP_FINISHLEVEL_BRONZE);
         this.coopDialog.coopInfoNew.btn_start.enableButton = CafeModel.coopData.activeCoop == null;
         this.coopDialog.coopInfoNew.btn_cancel.label = CafeModel.languageData.getTextById("generic_btn_goback");
         this.coopDialog.coopInfoNew.btn_start.label = CafeModel.languageData.getTextById("generic_btn_start");
         this.drawCoopPic(this.coopDialog.coopInfoNew.mc_cooppicholder,this._currentCoop);
         this.drawRquirements(this.coopDialog.coopInfoNew.mc_holder,0);
      }
      
      private function drawCoopPic(param1:MovieClip, param2:BasicCoopVO) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
         var _loc3_:Class = getDefinitionByName(param2.getVisClassName()) as Class;
         param1.addChild(new _loc3_());
      }
      
      private function drawPlayerAvatars(param1:MovieClip, param2:int) : void
      {
         var _loc5_:BuddyVO = null;
         var _loc6_:CoopMembersContainer = null;
         var _loc7_:Sprite = null;
         var _loc8_:Number = NaN;
         var _loc9_:Rectangle = null;
         var _loc3_:Number = -(this._currentCoop.coopPlayer.length - 1) * PLAYERLIST_SPACE / 2;
         var _loc4_:int = 0;
         while(_loc4_ < this._currentCoop.coopPlayer.length)
         {
            _loc5_ = this._currentCoop.coopPlayer[_loc4_];
            (_loc6_ = new CoopMembersContainer()).x = _loc3_ + _loc4_ * PLAYERLIST_SPACE;
            _loc6_.y = param2;
            if(_loc5_)
            {
               _loc7_ = CreateAvatarHelper.createAvatar(_loc5_.avatarParts);
               _loc8_ = 0.5;
               _loc9_ = _loc7_.getBounds(null);
               _loc7_.scaleX = _loc7_.scaleY = _loc8_;
               _loc7_.x = -(_loc9_.width * _loc8_ / 2 + _loc9_.left * _loc8_);
               _loc7_.y = -(_loc9_.height * _loc8_ / 2 + _loc9_.top * _loc8_);
               _loc6_.mc_avatarholder.addChild(_loc7_);
               _loc6_.txt_name.text = _loc5_.playerName;
               _loc6_.buddyVO = _loc5_;
               _loc6_.mouseChildren = false;
               param1.addChild(_loc6_);
            }
            _loc4_++;
         }
      }
      
      private function drawRquirements(param1:MovieClip, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc7_:CoopRequirementVO = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Class = null;
         var _loc10_:MovieClip = null;
         var _loc11_:Rectangle = null;
         var _loc12_:Number = NaN;
         if(param3)
         {
            _loc4_ = DISHLIST_SPACE_2;
         }
         else
         {
            _loc4_ = DISHLIST_SPACE_1;
         }
         var _loc5_:Number = -(this._currentCoop.requirements.length - 1) * _loc4_ / 2;
         var _loc6_:int = 0;
         while(_loc6_ < this._currentCoop.requirements.length)
         {
            _loc7_ = this._currentCoop.requirements[_loc6_];
            if(param3)
            {
               _loc8_ = new CoopMealContainer();
            }
            else
            {
               _loc8_ = new CoopMealContainerAll();
            }
            _loc8_.mouseChildren = false;
            (_loc10_ = new (_loc9_ = getDefinitionByName(CafeModel.wodData.voList[_loc7_.dishWodId].getVisClassName()) as Class)()).gotoAndStop(BasicDishVO.GFX_FRAME_READY);
            _loc11_ = _loc10_.getBounds(null);
            _loc12_ = DISHLIST_BOX / _loc11_.width;
            if(_loc11_.height * _loc12_ > DISHLIST_BOX)
            {
               _loc12_ = DISHLIST_BOX / _loc11_.height;
            }
            _loc10_.scaleX = _loc10_.scaleY = _loc12_;
            _loc10_.x = -(_loc11_.width * _loc12_ / 2 + _loc11_.left * _loc12_);
            _loc10_.y = -(_loc11_.height * _loc12_ / 2 + _loc11_.top * _loc12_);
            _loc8_.mc_dishholder.addChild(_loc10_);
            _loc8_.x = _loc5_ + _loc6_ * _loc4_;
            _loc8_.y = param2;
            if(param3)
            {
               _loc8_.txt_amount.text = String(_loc7_.amountDone) + "\n" + "-" + "\n" + String(_loc7_.amountRequired);
            }
            else
            {
               _loc8_.txt_amount.text = String(_loc7_.amountRequired);
            }
            _loc8_.toolTipText = CafeModel.languageData.getTextById("recipe_" + String(CafeModel.wodData.voList[_loc7_.dishWodId].type).toLocaleLowerCase());
            param1.addChild(_loc8_);
            _loc6_++;
         }
      }
      
      private function onClickCoopListItem(param1:MouseEvent) : void
      {
         this._currentCoop = param1.target.coopVO;
         switch(this._currentState)
         {
            case STATE_ACTIVECOOPS:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_DETAIL,[this._currentCoop.coopInstanceID]);
               break;
            case STATE_NEWCOOP:
               this.changeState(STATE_COOPINFO);
         }
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this._currentPage;
         if(param1.target == this.coopDialog.cooplist.btn_arrow_left)
         {
            this._currentPage = Math.max(0,this._currentPage - 1);
         }
         else
         {
            this._currentPage = Math.min(this._maxPage,this._currentPage + 1);
         }
         if(_loc2_ != this._currentPage)
         {
            this.fillItems(this._currentState == STATE_ACTIVECOOPS);
         }
      }
      
      private function initArrows(param1:int) : void
      {
         this._maxPage = (param1 - 1) / this.coopDialogProperties.itemsPerPage;
         this.coopDialog.cooplist.btn_arrow_right.visible = this._maxPage > 0 && this._currentPage < this._maxPage;
         this.coopDialog.cooplist.btn_arrow_left.visible = this._maxPage > 0 && this._currentPage > 0;
      }
      
      override public function show() : void
      {
         controller.addEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeState);
         if(CafeModel.coopData.activeCoop)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_DETAIL,[CafeModel.coopData.activeCoop.coopInstanceID]);
         }
         else if(CafeModel.coopData.activeCoop)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_ACTIVELIST,[]);
         }
         else
         {
            this.changeState(STATE_NEWCOOP);
         }
         super.show();
      }
      
      override public function hide() : void
      {
         controller.removeEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeState);
         layoutManager.playerActionChoices.hide();
         super.hide();
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeState);
         super.destroy();
      }
      
      private function onChangeState(param1:CafeDialogEvent) : void
      {
         this.hide();
      }
      
      protected function get coopDialogProperties() : CafeCoopDialogProperties
      {
         return properties as CafeCoopDialogProperties;
      }
      
      private function get coopDialog() : CafeCoop
      {
         return disp as CafeCoop;
      }
   }
}
