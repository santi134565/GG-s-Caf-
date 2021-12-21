package com.goodgamestudios.cafe.view.screens
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.event.CafePanelEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeDekoShop;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeCleanStoveDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCleanStoveDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeClearCounterDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeClearCounterDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeClearStoveDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeClearStoveDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeCookBookDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCookBookDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeIngredientShopDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeIngredientShopDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeInstantCookingDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeInstantCookingDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceBoardDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceBoardDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceJobHelpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceJobHelpDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardYesNoDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.objects.chair.BasicChair;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.fridge.BasicFridge;
   import com.goodgamestudios.cafe.world.objects.moving.HeroMoving;
   import com.goodgamestudios.cafe.world.objects.moving.NpcguestMoving;
   import com.goodgamestudios.cafe.world.objects.moving.OtherplayerMoving;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import com.goodgamestudios.cafe.world.objects.vendingmachine.BasicVendingmachine;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcguestMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   import com.goodgamestudios.cafe.world.vo.stove.BasicStoveVO;
   import com.goodgamestudios.isocore.IIsoWorld;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.objects.FloorObject;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.objects.WallObject;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class CafeIsoScreen extends CafeScreen
   {
      
      public static const NAME:String = "CafeIsoScreen";
       
      
      private var _isoWorld:IIsoWorld;
      
      private var _buyTilesParams:Array;
      
      public function CafeIsoScreen(param1:DisplayObject)
      {
         this._isoWorld = null;
         super(param1);
      }
      
      public function buildWorld() : void
      {
         this.destroy();
         this._isoWorld = new CafeIsoWorld();
         this.worldContainer.addChild(this.isoWorld);
         this._isoWorld.buildWorldFromLevelVO(CafeModel.levelData.levelVO);
         this.changeClickableWorldObjects();
         this.controller.addEventListener(CafeDialogEvent.CHANGE_CAFE,this.onUpdateIsoTextFields);
         this.controller.addEventListener(CafePanelEvent.MOUSE_ON_PANEL,this.onMouseOutOfIsoworld);
         this.controller.addEventListener(CafeDialogEvent.MOUSE_ON_DIALOG,this.onMouseOutOfIsoworld);
         this.controller.addEventListener(CafeUserEvent.CHANGE_AVATAR,this.onChangeAvatar);
         this._isoWorld.addEventListener(CafeIsoEvent.WALK_TO,this.onWalkto);
         this._isoWorld.addEventListener(CafeIsoEvent.NPC_LEAVING_CAFE,this.onNpcLeavingCafe);
         this._isoWorld.addEventListener(CafeIsoEvent.HERO_EVENT,this.onHeroEvent);
         this._isoWorld.addEventListener(CafeIsoEvent.RATING_EVENT,this.onRatingEvent);
         this._isoWorld.addEventListener(CafeIsoEvent.DIALOG_EVENT,this.onIsodialog);
         this._isoWorld.addEventListener(CafeIsoEvent.COUNTER_CLICK,this.onCounterClick);
         this._isoWorld.addEventListener(CafeIsoEvent.FRIDGE_CLICK,this.onFridgeClick);
         this._isoWorld.addEventListener(CafeIsoEvent.OTHERPLAYER_CLICK,this.onClickOtherplayer);
         this._isoWorld.addEventListener(CafeIsoEvent.GUEST_CLICK,this.onClickGuest);
         this._isoWorld.addEventListener(CafeIsoEvent.CHAIR_EVENT,this.onClickChair);
         this._isoWorld.addEventListener(CafeIsoEvent.STOVE_EVENT,this.onStoveEvent);
         this._isoWorld.addEventListener(CafeIsoEvent.EDITOR_EVENT,this.onEditorEvent);
         this._isoWorld.addEventListener(CafeIsoEvent.MARKETPLACE_CLICK,this.onMarketplaceClicked);
         this._isoWorld.addEventListener(CafeIsoEvent.ISO_OBJECT_MOUSE_OVER,this.onIsoObjectMouseOver);
         this._isoWorld.addEventListener(CafeIsoEvent.ISO_OBJECT_MOUSE_OUT,this.onIsoObjectMouseOut);
         this._isoWorld.addEventListener(CafeIsoEvent.ISO_OBJECT_MOUSE_UP,this.onIsoObjectMouseUp);
         this._isoWorld.addEventListener(CafeIsoEvent.ISO_OBJECT_MOUSE_DOWN,this.onIsoObjectMouseDown);
         this._isoWorld.addEventListener(IsoWorldEvent.ISOWORLD_MOUSEDOWN,this.onIsoWorldMouseDown);
         this._isoWorld.addEventListener(IsoWorldEvent.ISOWORLD_MOUSEUP,this.onIsoWorldMouseUp);
         layoutManager.addAnimFlashUIComponent(layoutManager.playerActionChoices);
      }
      
      override public function destroy() : void
      {
         if(this._isoWorld)
         {
            this._isoWorld.removeEventListener(CafeIsoEvent.COUNTER_CLICK,this.onCounterClick);
            this._isoWorld.removeEventListener(CafeIsoEvent.WALK_TO,this.onWalkto);
            this._isoWorld.removeEventListener(CafeIsoEvent.FRIDGE_CLICK,this.onFridgeClick);
            this._isoWorld.removeEventListener(CafeIsoEvent.NPC_LEAVING_CAFE,this.onNpcLeavingCafe);
            this._isoWorld.removeEventListener(CafeIsoEvent.OTHERPLAYER_CLICK,this.onClickOtherplayer);
            this._isoWorld.removeEventListener(CafeIsoEvent.GUEST_CLICK,this.onClickGuest);
            this._isoWorld.removeEventListener(CafeIsoEvent.STOVE_EVENT,this.onStoveEvent);
            this._isoWorld.removeEventListener(CafeIsoEvent.EDITOR_EVENT,this.onEditorEvent);
            this._isoWorld.removeEventListener(CafeIsoEvent.HERO_EVENT,this.onHeroEvent);
            this._isoWorld.removeEventListener(CafeIsoEvent.CHAIR_EVENT,this.onClickChair);
            this._isoWorld.removeEventListener(CafeIsoEvent.RATING_EVENT,this.onRatingEvent);
            this._isoWorld.removeEventListener(CafeIsoEvent.DIALOG_EVENT,this.onIsodialog);
            this._isoWorld.removeEventListener(CafeIsoEvent.MARKETPLACE_CLICK,this.onMarketplaceClicked);
            this._isoWorld.removeEventListener(CafeIsoEvent.ISO_OBJECT_MOUSE_OVER,this.onIsoObjectMouseOver);
            this._isoWorld.removeEventListener(CafeIsoEvent.ISO_OBJECT_MOUSE_OUT,this.onIsoObjectMouseOut);
            this._isoWorld.removeEventListener(CafeIsoEvent.ISO_OBJECT_MOUSE_UP,this.onIsoObjectMouseUp);
            this._isoWorld.removeEventListener(CafeIsoEvent.ISO_OBJECT_MOUSE_DOWN,this.onIsoObjectMouseDown);
            this._isoWorld.removeEventListener(IsoWorldEvent.ISOWORLD_MOUSEDOWN,this.onIsoWorldMouseDown);
            this._isoWorld.removeEventListener(IsoWorldEvent.ISOWORLD_MOUSEUP,this.onIsoWorldMouseUp);
            this.controller.removeEventListener(CafePanelEvent.MOUSE_ON_PANEL,this.onMouseOutOfIsoworld);
            this.controller.removeEventListener(CafeDialogEvent.MOUSE_ON_DIALOG,this.onMouseOutOfIsoworld);
            this.controller.removeEventListener(CafeUserEvent.CHANGE_AVATAR,this.onChangeAvatar);
            this.controller.removeEventListener(CafeDialogEvent.CHANGE_CAFE,this.onUpdateIsoTextFields);
            this._isoWorld.destroyWorld();
            if(this.worldContainer.contains(this.isoWorld))
            {
               this.worldContainer.removeChild(this.isoWorld);
            }
         }
         layoutManager.playerActionChoices.kill();
         layoutManager.removeAnimFlashUIComponent(layoutManager.playerActionChoices);
      }
      
      private function onChangeAvatar(param1:CafeUserEvent) : void
      {
         this._isoWorld.spawnPlayer(CafeModel.userData.heroVO);
      }
      
      public function changeClickableWorldObjects() : void
      {
         var _loc2_:IsoObject = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._isoWorld.isoObjects.length)
         {
            _loc2_ = this._isoWorld.isoObjects[_loc1_] as IsoObject;
            switch(_loc2_.group)
            {
               case CafeConstants.GROUP_MOVING:
                  if(!(_loc2_ is NpcguestMoving))
                  {
                     _loc2_.isClickable = !CafeModel.userData.isMyPlayerWaiter;
                  }
                  break;
               case CafeConstants.GROUP_TABLE:
                  if(!CafeModel.userData.isMyPlayerWaiter)
                  {
                     _loc2_.isClickable = false;
                  }
                  break;
               case CafeConstants.GROUP_STOVE:
               case CafeConstants.GROUP_FRIDGE:
                  _loc2_.isClickable = this.isoWorld.cafeWorldType == CafeConstants.CAFE_WORLD_TYPE_MYCAFE;
                  break;
               case CafeConstants.GROUP_COUNTER:
                  if(CafeModel.userData.heroVO.isWaiter)
                  {
                     _loc2_.isClickable = true;
                  }
                  else
                  {
                     _loc2_.isClickable = this.isoWorld.cafeWorldType == CafeConstants.CAFE_WORLD_TYPE_MYCAFE;
                  }
                  break;
            }
            _loc1_++;
         }
      }
      
      private function onClickGuest(param1:CafeIsoEvent) : void
      {
         var _loc3_:BasicVendingmachine = null;
         var _loc2_:NpcguestMoving = param1.params.shift();
         if(_loc2_.chair && this.isoWorld.myPlayer.isFreeForWaiterAction)
         {
            _loc2_.chair.onChairClick();
         }
         else if((_loc2_.getVisualVO() as NpcguestMovingVO).thirsty)
         {
            _loc3_ = this.isoWorld.randomFreeVendingMachine;
            if(_loc3_)
            {
               _loc3_.onNpcUsage(_loc2_);
            }
            else if(!layoutManager.isoScreen.isoWorld.myPlayer.isWorking)
            {
               layoutManager.showDialog(CafeStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("dialogwin_smoothiemaker_nofrosty_copy"),this.onBuyVendingMachine,null,null,CafeModel.languageData.getTextById("dialogwin_smoothiemaker_nofrosty_btn_toshop"),CafeModel.languageData.getTextById("generic_btn_noshare")));
            }
            else
            {
               layoutManager.isoScreen.isoWorld.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.DIALOG_EVENT,[CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")]));
            }
         }
      }
      
      public function onBuyVendingMachine(param1:Event = null) : void
      {
         CafeModel.dekoShop.openFor = CafeDekoShop.OPEN_FOR_VENDINGMACHINES;
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_MODE,[1]);
      }
      
      private function onClickOtherplayer(param1:CafeIsoEvent) : void
      {
         var _loc2_:OtherplayerMoving = param1.params.shift();
         var _loc3_:OtherplayerMovingVO = _loc2_.getVisualVO() as OtherplayerMovingVO;
         if(!_loc2_)
         {
            return;
         }
         layoutManager.playerActionChoices.initPlayerActionChoices(_loc2_,_loc3_,0,_loc3_.allowFriendRequest);
      }
      
      private function onClickChair(param1:CafeIsoEvent) : void
      {
         var _loc2_:BasicChair = null;
         var _loc3_:BasicDishVO = null;
         if(!this.isoWorld.myPlayer.isFreeForWaiterAction)
         {
            return;
         }
         switch(param1.params.shift())
         {
            case CafeIsoEvent.CLICK_CHAIR:
            case CafeIsoEvent.CLICK_GUEST:
            case CafeIsoEvent.CLICK_TABLE:
               _loc2_ = param1.params.shift() as BasicChair;
               _loc3_ = param1.params.shift() as BasicDishVO;
               if(_loc3_)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_JOB_USER_ACTION,[CafeIsoWorld.ACTION_JOBUSER_CLEANSTART,_loc2_.getVisualVO().isoPos.x,_loc2_.getVisualVO().isoPos.y]);
               }
               else
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_JOB_USER_ACTION,[CafeIsoWorld.ACTION_JOBUSER_DELIVERSTART,_loc2_.getVisualVO().isoPos.x,_loc2_.getVisualVO().isoPos.y]);
               }
         }
      }
      
      private function onMarketplaceClicked(param1:CafeIsoEvent) : void
      {
         if(layoutManager.currentState != CafeLayoutManager.STATE_MARKETPLACE)
         {
            return;
         }
         switch(param1.params.shift())
         {
            case CafeIsoEvent.MARKETPLACE_NOTICEBOARD:
               layoutManager.showDialog(CafeMarketplaceBoardDialog.NAME,new CafeMarketplaceBoardDialogProperties(CafeModel.languageData.getTextById("alert_marketplace_noticeboard_title"),CafeModel.userData.heroVO.seekingJob,this.onJobRefill,this.onSeekingJob,this.onJobHelp));
               break;
            case CafeIsoEvent.MARKETPLACE_SHOP:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_marketplace_shop_title"),CafeModel.languageData.getTextById("alert_marketplace_shop_copy")));
         }
      }
      
      private function onJobHelp(param1:Array) : void
      {
         layoutManager.showDialog(CafeMarketplaceJobHelpDialog.NAME,new CafeMarketplaceJobHelpDialogProperties(CafeModel.languageData.getTextById("alert_jobhelp_title"),CafeModel.languageData.getTextById("alert_jobhelp_header1"),CafeModel.languageData.getTextById("alert_jobhelp_header2"),CafeModel.languageData.getTextById("alert_jobhelp_copy1"),CafeModel.languageData.getTextById("alert_jobhelp_copy2"),CafeModel.languageData.getTextById("btn_text_okay")));
      }
      
      private function onJobRefill(param1:Array) : void
      {
         if(CafeModel.userData.isGuest())
         {
            layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
         }
         else if(CafeModel.userData.heroVO.openJobs < CafeConstants.jobsPerDay)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_MARKETPLACE_JOBREFILL,[]);
         }
      }
      
      private function onSeekingJob(param1:Array) : void
      {
         if(CafeModel.userData.isGuest())
         {
            layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
         }
         else
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_MARKETPLACE_SEEKINGJOB,[!!this.isoWorld.myPlayer.isSeekingJob ? 0 : 1]);
         }
      }
      
      private function onRatingEvent(param1:CafeIsoEvent) : void
      {
         CafeModel.levelData.changeRanking(param1.params);
      }
      
      private function onNpcLeavingCafe(param1:CafeIsoEvent) : void
      {
         this._isoWorld.doAction(CafeIsoWorld.ACTION_NPC_ACTION,param1.params);
      }
      
      private function onIsodialog(param1:CafeIsoEvent) : void
      {
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(param1.params.shift(),param1.params.shift()));
      }
      
      private function onWalkto(param1:CafeIsoEvent) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_WALK,[param1.params.shift(),param1.params.shift()]);
      }
      
      private function onEditorEvent(param1:CafeIsoEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = param1.params.shift();
         switch(_loc2_)
         {
            case CafeIsoEvent.EDITOR_DEKOMODE_ON:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_MODE,[1]);
               break;
            case CafeIsoEvent.EDITOR_MOVE:
               if(!this._isoWorld.mouse.iDragObjectIsLocked)
               {
                  this.controller.sendServerMessageAndWait(SFConstants.C2S_EDITOR_MOVE_OBJECT,param1.params,SFConstants.S2C_EDITOR_MOVE_OBJECT);
                  this._isoWorld.mouse.lockDragObject();
               }
               break;
            case CafeIsoEvent.EDITOR_ROTATE:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_ROTATE_OBJECT,param1.params);
               break;
            case CafeIsoEvent.EDITOR_BUY:
               if(!this._isoWorld.mouse.iDragObjectIsLocked)
               {
                  this._isoWorld.mouse.lockDragObject();
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_BUY_OBJECT,param1.params);
               }
               break;
            case CafeIsoEvent.EDITOR_BUY_FLOOR:
               this._isoWorld.mouse.lockDragObject();
               _loc3_ = param1.params.pop();
               if((_loc4_ = param1.params.pop()) > 0)
               {
                  this._buyTilesParams = param1.params;
                  layoutManager.showDialog(CafeStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("dialogwin_buytile_title"),CafeModel.languageData.getTextById("dialogwin_buytile_copy",[_loc4_,String(_loc3_) + " " + CafeModel.languageData.getTextById("cash")]),this.buyTilesYes,this.buyTilesNo,this.buyTilesNo,CafeModel.languageData.getTextById("generic_btn_okay"),CafeModel.languageData.getTextById("generic_btn_no")));
               }
               else
               {
                  this.isoWorld.clearDrawTiles();
               }
         }
      }
      
      private function buyTilesYes(param1:Array) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_BUY_FLOOR,this._buyTilesParams);
      }
      
      private function buyTilesNo(param1:Array) : void
      {
         this.isoWorld.clearDrawTiles();
      }
      
      private function onHeroEvent(param1:CafeIsoEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = param1.params.shift();
         switch(_loc2_)
         {
            case CafeIsoEvent.HERO_CHANGE_MONEY:
               _loc3_ = int(param1.params.shift());
               _loc4_ = int(param1.params.shift());
               CafeModel.userData.checkMoneyChanges(_loc3_,_loc4_);
               break;
            case CafeIsoEvent.HERO_CHANGE_XP:
               _loc5_ = int(param1.params.shift());
               CafeModel.userData.checkXPChanges(_loc5_);
               break;
            case CafeIsoEvent.HERO_CHANGE_JOBSTATE:
               this.changeClickableWorldObjects();
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_JOB_PAYCHECK,[]);
               break;
            case CafeIsoEvent.HERO_PICKDOWN:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_JOB_USER_ACTION,[CafeIsoWorld.ACTION_JOBUSER_PICKDOWNDISH,param1.params.shift(),param1.params.shift()]);
               break;
            case CafeIsoEvent.HERO_PICKUP:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_JOB_USER_ACTION,[CafeIsoWorld.ACTION_JOBUSER_PICKUPDISH,param1.params.shift(),param1.params.shift()]);
               break;
            case CafeIsoEvent.HERO_DELIVER:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_JOB_USER_ACTION,[CafeIsoWorld.ACTION_JOBUSER_DELIVEREND,param1.params.shift(),param1.params.shift()]);
               break;
            case CafeIsoEvent.HERO_CLEAN:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_JOB_USER_ACTION,[CafeIsoWorld.ACTION_JOBUSER_CLEANEND,param1.params.shift(),param1.params.shift()]);
         }
      }
      
      private function onStoveEvent(param1:CafeIsoEvent) : void
      {
         var _loc3_:VisualElement = null;
         var _loc4_:BasicStove = null;
         var _loc5_:VisualVO = null;
         var _loc6_:BasicCounter = null;
         var _loc7_:BasicStove = null;
         var _loc2_:int = param1.params.shift();
         _loc3_ = param1.params[0] as VisualElement;
         if((_loc4_ = _loc3_ as BasicStove) && !_loc4_.isClickable)
         {
            return;
         }
         switch(_loc2_)
         {
            case CafeIsoEvent.STOVE_CLEAN:
               if(_loc4_.currentDish)
               {
                  if(CafeModel.userData.showRefreshPopup(_loc4_.currentDish.wodId))
                  {
                     layoutManager.showDialog(CafeCleanStoveDialog.NAME,new CafeCleanStoveDialogProperties(_loc4_));
                  }
                  else
                  {
                     CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_CLEAN,[_loc4_.stoveVO.isoPos.x,_loc4_.stoveVO.isoPos.y]);
                  }
               }
               else
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_CLEAN,[_loc4_.stoveVO.isoPos.x,_loc4_.stoveVO.isoPos.y]);
               }
               break;
            case CafeIsoEvent.STOVE_PREPARESTEP:
               break;
            case CafeIsoEvent.STOVE_CLICK:
               this.onStoveClick(_loc4_);
               break;
            case CafeIsoEvent.STOVE_COOK:
               if(tutorialController.isActive)
               {
                  tutorialController.nextStep();
               }
               else
               {
                  _loc4_.startCook();
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_COOK,[_loc4_.stoveVO.isoPos.x,_loc4_.stoveVO.isoPos.y,_loc4_.currentDish.wodId,1,0]);
                  if(CafeModel.userData.showInstantPopup(_loc4_.currentDish.wodId) && CafeModel.userData.canInstaCook && CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_INSTANTDIALOG)
                  {
                     layoutManager.showDialog(CafeInstantCookingDialog.NAME,new CafeInstantCookingDialogProperties(_loc4_));
                  }
               }
               break;
            case CafeIsoEvent.STOVE_DELIVER_INFO:
               _loc5_ = _loc4_.getVisualVO();
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_STOVE_DELIVER_INFO,[_loc5_.isoPos.x,_loc5_.isoPos.y]);
               break;
            case CafeIsoEvent.STOVE_DELIVER:
               if(tutorialController.isActive)
               {
                  tutorialController.nextStep();
               }
               _loc6_ = _loc3_ as BasicCounter;
               _loc7_ = param1.params[2] as BasicStove;
               CafeModel.userData.checkXPChanges(_loc7_.currentDish.getXp());
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_STOVE_DELIVER,[_loc7_.stoveVO.isoPos.x,_loc7_.stoveVO.isoPos.y,_loc6_.counterVO.isoPos.x,_loc6_.counterVO.isoPos.y]);
         }
      }
      
      private function onCounterClick(param1:CafeIsoEvent) : void
      {
         var _loc5_:CafeClearCounterDialogProperties = null;
         if(tutorialController.isActive)
         {
            return;
         }
         var _loc2_:BasicCounter = param1.params.shift();
         var _loc3_:int = _loc2_.currentStatus;
         var _loc4_:HeroMoving = this.isoWorld.myPlayer;
         if(!_loc2_.isClickable)
         {
            return;
         }
         if(!_loc4_.canReachObject(_loc2_.getVisualVO().isoPos))
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_counter_outofreach_title"),CafeModel.languageData.getTextById("alert_counter_outofreach_copy")));
            return;
         }
         switch(_loc3_)
         {
            case BasicCounter.COUNTER_STATUS_FREE:
               if(this.isoWorld.myPlayer.isFreeForWaiterAction)
               {
                  _loc4_.walkToCounter(_loc2_);
               }
               break;
            case BasicCounter.COUNTER_STATUS_FULL:
               if(this.isoWorld.myPlayer.isFreeForWaiterAction)
               {
                  _loc4_.walkToCounter(_loc2_);
               }
               else if(!CafeModel.userData.isMyPlayerWaiter)
               {
                  (_loc5_ = new CafeClearCounterDialogProperties()).target = _loc2_;
                  layoutManager.showDialog(CafeClearCounterDialog.NAME,_loc5_);
               }
         }
      }
      
      public function onFridgeClick(param1:CafeIsoEvent) : void
      {
         if(tutorialController.isActive)
         {
            return;
         }
         var _loc2_:BasicFridge = param1.params.shift();
         var _loc3_:BasicFridgeVO = _loc2_.getVisualVO() as BasicFridgeVO;
         var _loc4_:CafeIngredientShopDialogProperties = new CafeIngredientShopDialogProperties();
         if(!_loc2_.isClickable)
         {
            return;
         }
         _loc4_.target = _loc3_;
         layoutManager.showDialog(CafeIngredientShopDialog.NAME,_loc4_);
      }
      
      private function onStoveClick(param1:BasicStove) : void
      {
         var _loc4_:CafeCookBookDialogProperties = null;
         var _loc5_:CafeClearStoveDialogProperties = null;
         var _loc2_:BasicStoveVO = param1.stoveVO;
         var _loc3_:int = param1.currentStatus;
         if(tutorialController.isActive)
         {
            if(param1 != tutorialController.activeIsoObject)
            {
               return;
            }
            switch(tutorialController.tutorialState)
            {
               case CafeTutorialController.TUT_STATE_COOK_PREPARECOOK:
               case CafeTutorialController.TUT_STATE_COOK_PREPARESTEP_ONION:
               case CafeTutorialController.TUT_STATE_COOK_PREPARESTEP_TOMATO:
                  tutorialController.nextStep();
                  break;
               case CafeTutorialController.TUT_STATE_COOK_INSTANT_COOK:
                  tutorialController.nextStep();
                  break;
               case CafeTutorialController.TUT_STATE_COOK_SERVEDISH:
                  tutorialController.removeArrow();
                  if(param1.currentStatus == BasicStove.STOVE_STATUS_DIRTY)
                  {
                     return;
                  }
                  break;
            }
         }
         if(!this.isoWorld.myPlayer.canReachObject(_loc2_.isoPos))
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("alert_stove_outofreach_copy")));
            return;
         }
         if(param1.isInWorkList)
         {
            return;
         }
         switch(_loc3_)
         {
            case BasicStove.STOVE_STATUS_FREE:
               (_loc4_ = new CafeCookBookDialogProperties()).target = _loc2_;
               layoutManager.showDialog(CafeCookBookDialog.NAME,_loc4_);
               break;
            case BasicStove.STOVE_STATUS_PREPARE:
               this.isoWorld.myPlayer.addWorkItem(param1,HeroMoving.COOK_WORK_PREPARE);
               break;
            case BasicStove.STOVE_STATUS_COOKING:
               (_loc5_ = new CafeClearStoveDialogProperties()).target = param1;
               layoutManager.showDialog(CafeClearStoveDialog.NAME,_loc5_);
               break;
            case BasicStove.STOVE_STATUS_READY:
               this.isoWorld.myPlayer.addWorkItem(param1,HeroMoving.COOK_WORK_SERVE_START);
               break;
            case BasicStove.STOVE_STATUS_ROTTEN:
               this.isoWorld.myPlayer.addWorkItem(param1,HeroMoving.COOK_WORK_CLEAN);
               break;
            case BasicStove.STOVE_STATUS_DIRTY:
               this.isoWorld.myPlayer.addWorkItem(param1,HeroMoving.COOK_WORK_CLEAN);
         }
      }
      
      private function onIsoWorldMouseDown(param1:IsoWorldEvent) : void
      {
         if(this.isoWorld.worldStatus != CafeIsoWorld.CAFE_STATUS_DEKO || param1.params == null || param1.params[0].name != "RotateIcon")
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
         }
      }
      
      private function onIsoWorldMouseUp(param1:IsoWorldEvent) : void
      {
         if(this.isoWorld.worldStatus == CafeIsoWorld.CAFE_STATUS_DEKO)
         {
            if(!this.isoWorld.mouse.isOnObject)
            {
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            }
            else
            {
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_HAND);
            }
         }
         else
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      private function onIsoObjectMouseOver(param1:CafeIsoEvent) : void
      {
         var _loc2_:VisualElement = null;
         if(!this.isoWorld.mouse.isWorldDragging)
         {
            _loc2_ = param1.params[0] as VisualElement;
            if(this.isoWorld.worldStatus == CafeIsoWorld.CAFE_STATUS_RUN)
            {
               if(!_loc2_.hasOwnProperty("isClickable") || !_loc2_["isClickable"])
               {
                  return;
               }
               switch(_loc2_.getVisualVO().group)
               {
                  case CafeConstants.GROUP_BACKGROUND:
                  case CafeConstants.GROUP_MOVING:
                  case CafeConstants.GROUP_TABLE:
                  case CafeConstants.GROUP_VENDINGMACHINE:
                  case CafeConstants.GROUP_FRIDGE:
                  case CafeConstants.GROUP_STOVE:
                     layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
                     break;
                  case CafeConstants.GROUP_COUNTER:
                     if(CafeModel.userData.heroVO.isWaiter || (_loc2_ as BasicCounter).currentStatus == BasicCounter.COUNTER_STATUS_FULL)
                     {
                        layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
                     }
               }
            }
            else if(this.isoWorld.worldStatus == CafeIsoWorld.CAFE_STATUS_DEKO)
            {
               if((_loc2_ is FloorObject || _loc2_ is WallObject) && !this.isoWorld.mouse.iDragObject)
               {
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_HAND);
               }
            }
         }
      }
      
      private function onIsoObjectMouseOut(param1:CafeIsoEvent) : void
      {
         if(this.isoWorld.worldStatus == CafeIsoWorld.CAFE_STATUS_RUN && !this.isoWorld.mouse.isWorldDragging || this.isoWorld.worldStatus == CafeIsoWorld.CAFE_STATUS_DEKO && !this.isoWorld.mouse.iDragObject)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      private function onIsoObjectMouseUp(param1:CafeIsoEvent) : void
      {
      }
      
      private function onIsoObjectMouseDown(param1:CafeIsoEvent) : void
      {
         if(this.isoWorld.worldStatus == CafeIsoWorld.CAFE_STATUS_DEKO)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
         }
      }
      
      private function onMouseOutOfIsoworld(param1:Event) : void
      {
         if(this.isoWorld && this.isoWorld.mouse && this.isoWorld.mouse.mouseIsOnWorld)
         {
            this.isoWorld.mouse.onMouseOut();
            if(layoutManager.inGameState)
            {
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            }
         }
      }
      
      private function onUpdateIsoTextFields(param1:Event) : void
      {
         var _loc3_:IsoObject = null;
         this.isoWorld.updateBackgroundTextFields();
         var _loc2_:int = 0;
         while(_loc2_ < this._isoWorld.isoObjects.length)
         {
            _loc3_ = this._isoWorld.isoObjects[_loc2_] as IsoObject;
            switch(_loc3_.group)
            {
               case CafeConstants.GROUP_STOVE:
                  (_loc3_ as BasicStove).updateToolTipTextFields();
                  break;
               case CafeConstants.GROUP_FRIDGE:
                  (_loc3_ as BasicFridge).updateToolTipTextFields();
                  break;
               case CafeConstants.GROUP_COUNTER:
                  (_loc3_ as BasicCounter).updateToolTipTextFields();
                  break;
            }
            _loc2_++;
         }
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      public function get isoWorld() : CafeIsoWorld
      {
         return this._isoWorld as CafeIsoWorld;
      }
      
      private function get worldContainer() : Sprite
      {
         return disp as Sprite;
      }
   }
}
