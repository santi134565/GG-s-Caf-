package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafeInventoryEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeIngredientShopDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeIngredientShopDialog";
       
      
      private var currentPage:int = 0;
      
      private var maxPage:int = 0;
      
      private var inFridgeMode:Boolean = false;
      
      private var selectedItem:CafeIShopItem;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeIngredientShopDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.onChangeFridgeSize();
         controller.addEventListener(CafeInventoryEvent.CHANGE_AVAILIBILITY,this.onChangeIngredient);
         controller.addEventListener(CafeInventoryEvent.UPDATE_INVENTORY,this.onChangeItemAmount);
         controller.addEventListener(CafeInventoryEvent.CHANGE_FRIDGESIZE,this.onChangeFridgeSize);
         controller.addEventListener(CafeUserEvent.CHANGE_USERDATA,this.onChangeUserData);
         controller.addEventListener(CafeUserEvent.INIT_USERDATA,this.onChangeUserData);
         super.init();
      }
      
      override protected function applyProperties() : void
      {
         this.cafeIShop.mc_content.btn_all.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_content.btn_all.name);
         this.cafeIShop.mc_content.btn_cat1.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_content.btn_cat1.name);
         this.cafeIShop.mc_content.btn_cat2.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_content.btn_cat2.name);
         this.cafeIShop.mc_content.btn_cat3.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_content.btn_cat3.name);
         this.cafeIShop.mc_content.btn_cat5.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_content.btn_cat5.name);
         this.cafeIShop.mc_background.btn_fridge.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_background.btn_fridge.name);
         this.cafeIShop.mc_background.btn_shop.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_background.btn_shop.name);
         this.cafeIShop.btn_addcash.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.btn_addcash.name);
         this.cafeIShop.mc_content.btn_help.textArray = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_content.btn_help.name);
         this.cafeIShop.btn_addcash.visible = env.usePayment;
         if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_FANCYS)
         {
            this.cafeIShop.mc_content.btn_cat4.enableButton = false;
            this.cafeIShop.mc_content.btn_cat4.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_FANCYS]);
         }
         else
         {
            this.cafeIShop.mc_content.btn_cat4.enableButton = true;
            this.cafeIShop.mc_content.btn_cat4.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeIShop.mc_content.btn_cat4.name);
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeInventoryEvent.CHANGE_AVAILIBILITY,this.onChangeIngredient);
         controller.removeEventListener(CafeInventoryEvent.UPDATE_INVENTORY,this.onChangeItemAmount);
         controller.removeEventListener(CafeInventoryEvent.CHANGE_FRIDGESIZE,this.onChangeFridgeSize);
         controller.removeEventListener(CafeUserEvent.CHANGE_USERDATA,this.onChangeUserData);
         controller.removeEventListener(CafeUserEvent.INIT_USERDATA,this.onChangeUserData);
      }
      
      override protected function update() : void
      {
         this.isWaitingForServerMessage = true;
         if(this.cafeIShopProperties.target == null)
         {
            this.switchToShop();
         }
         else
         {
            this.switchToFridge();
         }
         this.cafeIShop.txt_cash.text = NumberStringHelper.groupString(CafeModel.userData.cash,CafeModel.languageData.getTextById);
         this.cafeIShop.txt_gold.text = NumberStringHelper.groupString(CafeModel.userData.gold,CafeModel.languageData.getTextById);
         controller.sendServerMessageAndWait(SFConstants.C2S_SHOP_AVAILIBILITY,[],SFConstants.S2C_SHOP_AVAILIBILITY);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(tutorialController.isActive)
         {
            if(tutorialController.tutorialState == CafeTutorialController.TUT_STATE_COOK_BUYMISSINGINGREDIENT)
            {
               if(param1.target != this.cafeIShop.mc_content.i1.btn_buy)
               {
                  return;
               }
               tutorialController.nextStep();
               hide();
            }
         }
         if(param1.target is BasicButton && !(param1.target as BasicButton).enabled)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.cafeIShop.mc_content.btn_help:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_fancyinfo_title"),CafeModel.languageData.getTextById("alert_fancyinfo_copy")));
               break;
            case this.cafeIShop.btn_arrow_left:
               this.onClickArrow(param1);
               break;
            case this.cafeIShop.btn_arrow_right:
               this.onClickArrow(param1);
               break;
            case this.cafeIShop.btn_addcash:
               if(CafeModel.userData.isGuest())
               {
                  layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
               }
               else
               {
                  controller.addExtraGold();
               }
               break;
            case this.cafeIShop.mc_background.btn_fridge:
               if(!this.inFridgeMode)
               {
                  this.switchToFridge();
               }
               break;
            case this.cafeIShop.mc_background.btn_shop:
               if(this.inFridgeMode)
               {
                  this.switchToShop();
               }
               break;
            case this.cafeIShop.btn_cancel:
               hide();
               break;
            case this.cafeIShop.mc_content.btn_all:
               this.onChangeFilter("");
               break;
            case this.cafeIShop.mc_content.btn_cat1:
               this.onChangeFilter("meat");
               break;
            case this.cafeIShop.mc_content.btn_cat2:
               this.onChangeFilter("vegatables");
               break;
            case this.cafeIShop.mc_content.btn_cat3:
               this.onChangeFilter("fruits");
               break;
            case this.cafeIShop.mc_content.btn_cat4:
               this.onChangeFilter("fancy");
               break;
            case this.cafeIShop.mc_content.btn_cat5:
               this.onChangeFilter("other");
               break;
            case this.cafeIShop.mc_content.i0.btn_sell:
            case this.cafeIShop.mc_content.i1.btn_sell:
            case this.cafeIShop.mc_content.i2.btn_sell:
            case this.cafeIShop.mc_content.i3.btn_sell:
            case this.cafeIShop.mc_content.i4.btn_sell:
            case this.cafeIShop.mc_content.i5.btn_sell:
            case this.cafeIShop.mc_content.i6.btn_sell:
            case this.cafeIShop.mc_content.i7.btn_sell:
               this.onSellItem(param1);
               break;
            case this.cafeIShop.mc_content.i0.btn_buy:
            case this.cafeIShop.mc_content.i1.btn_buy:
            case this.cafeIShop.mc_content.i2.btn_buy:
            case this.cafeIShop.mc_content.i3.btn_buy:
            case this.cafeIShop.mc_content.i4.btn_buy:
            case this.cafeIShop.mc_content.i5.btn_buy:
            case this.cafeIShop.mc_content.i6.btn_buy:
            case this.cafeIShop.mc_content.i7.btn_buy:
               this.onBuyItem(param1);
               break;
            case this.cafeIShop.mc_content.i0.btn_unlock:
            case this.cafeIShop.mc_content.i1.btn_unlock:
            case this.cafeIShop.mc_content.i2.btn_unlock:
            case this.cafeIShop.mc_content.i3.btn_unlock:
            case this.cafeIShop.mc_content.i4.btn_unlock:
            case this.cafeIShop.mc_content.i5.btn_unlock:
            case this.cafeIShop.mc_content.i6.btn_unlock:
            case this.cafeIShop.mc_content.i7.btn_unlock:
               this.onUnlockItem(param1);
               break;
            case this.cafeIShop.mc_content.i0.btn_wheel:
            case this.cafeIShop.mc_content.i1.btn_wheel:
            case this.cafeIShop.mc_content.i2.btn_wheel:
            case this.cafeIShop.mc_content.i3.btn_wheel:
            case this.cafeIShop.mc_content.i4.btn_wheel:
            case this.cafeIShop.mc_content.i5.btn_wheel:
            case this.cafeIShop.mc_content.i6.btn_wheel:
            case this.cafeIShop.mc_content.i7.btn_wheel:
               layoutManager.showDialog(CafeWheelOfFortuneDialog.NAME,new CafeWheelOfFortuneDialogProperties(!CafeModel.userData.playedWheelOfFortune,0));
         }
      }
      
      private function unselectButton() : void
      {
         this.cafeIShop.mc_content.btn_all.deselected();
         this.cafeIShop.mc_content.btn_cat1.deselected();
         this.cafeIShop.mc_content.btn_cat2.deselected();
         this.cafeIShop.mc_content.btn_cat3.deselected();
         this.cafeIShop.mc_content.btn_cat4.deselected();
         this.cafeIShop.mc_content.btn_cat5.deselected();
      }
      
      private function selectButtonByFilter(param1:String) : void
      {
         this.unselectButton();
         switch(param1)
         {
            case "":
               this.cafeIShop.mc_content.btn_all.selected();
               break;
            case "meat":
               this.cafeIShop.mc_content.btn_cat1.selected();
               break;
            case "vegatables":
               this.cafeIShop.mc_content.btn_cat2.selected();
               break;
            case "fruits":
               this.cafeIShop.mc_content.btn_cat3.selected();
               break;
            case "fancy":
               this.cafeIShop.mc_content.btn_cat4.selected();
               break;
            case "other":
               this.cafeIShop.mc_content.btn_cat5.selected();
         }
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this.currentPage;
         if(param1.target == this.cafeIShop.btn_arrow_left)
         {
            this.currentPage = Math.max(0,this.currentPage - 1);
         }
         else
         {
            this.currentPage = Math.min(this.maxPage,this.currentPage + 1);
         }
         if(_loc2_ != this.currentPage)
         {
            this.fillItems();
         }
      }
      
      private function initArrows(param1:int) : void
      {
         this.maxPage = (param1 - 1) / this.cafeIShopProperties.itemsPerPage;
         this.cafeIShop.btn_arrow_right.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.cafeIShop.btn_arrow_left.visible = this.maxPage > 0 && this.currentPage > 0;
      }
      
      private function onChangeFilter(param1:String, param2:Boolean = false) : void
      {
         if(this.cafeIShopProperties.filter == param1 && this.currentPage == 0 && !param2)
         {
            return;
         }
         this.currentPage = 0;
         this.cafeIShopProperties.filter = param1;
         this.selectButtonByFilter(param1);
         this.fillItems();
      }
      
      private function fillItems() : void
      {
         var _loc5_:CafeIShopItem = null;
         var _loc6_:BasicIngredientVO = null;
         var _loc7_:Class = null;
         var _loc8_:Sprite = null;
         var _loc9_:Rectangle = null;
         var _loc1_:int = this.currentPage * this.cafeIShopProperties.itemsPerPage;
         var _loc2_:int = _loc1_;
         var _loc3_:Array = this.getFilteredArray();
         this.initArrows(_loc3_.length);
         var _loc4_:int = 0;
         while(_loc4_ < this.cafeIShopProperties.itemsPerPage)
         {
            _loc5_ = this.cafeIShop.mc_content["i" + _loc4_] as CafeIShopItem;
            if(_loc2_ < _loc3_.length)
            {
               _loc6_ = _loc3_[_loc2_] as BasicIngredientVO;
               TextFieldHelper.changeTextFromatSizeByTextWidth(12,_loc5_.txt_label,CafeModel.languageData.getTextById("ingredient_" + _loc6_.type.toLowerCase()));
               if(_loc6_.wodId == CafeConstants.WODID_COCKTAILCHERRY)
               {
                  _loc5_.mc_money.visible = false;
               }
               else if(_loc6_.itemCash > 0)
               {
                  _loc5_.txt_price.text = NumberStringHelper.groupString(_loc6_.itemCash,CafeModel.languageData.getTextById);
                  _loc5_.mc_money.gotoAndStop(1);
               }
               else if(_loc6_.itemGold > 0)
               {
                  _loc5_.txt_price.text = NumberStringHelper.groupString(_loc6_.itemGold,CafeModel.languageData.getTextById);
                  _loc5_.mc_money.gotoAndStop(2);
               }
               _loc5_.wodId = _loc6_.wodId;
               _loc5_.amount = _loc6_.amount;
               _loc9_ = (_loc8_ = new (_loc7_ = getDefinitionByName(_loc6_.getVisClassName()) as Class)()).getBounds(null);
               _loc8_.x = -(_loc9_.width / 2 + _loc9_.left);
               _loc8_.y = -(_loc9_.height / 2 + _loc9_.top);
               _loc5_.mc_amount.txt_amount.text = "x" + _loc6_.amount;
               _loc5_.mc_amount.visible = _loc6_.amount > 1;
               _loc5_.mc_eventview.visible = String(_loc6_.events[0]) == CafeConstants.EVENT_CHRISTMAS;
               while(_loc5_.mc_itemholder.numChildren > 0)
               {
                  _loc5_.mc_itemholder.removeChildAt(0);
               }
               _loc5_.mc_itemholder.addChild(_loc8_);
               if(this.isWaitingForServerMessage)
               {
                  _loc5_.mc_itemholder.addChild(new ServerWaitingAnim());
               }
               this.checkShopItemAmount(_loc5_,_loc6_);
               this.checkShopItemState(_loc5_,_loc6_);
               _loc5_.visible = true;
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc2_++;
            _loc4_++;
         }
      }
      
      private function switchToFridge() : void
      {
         var _loc1_:int = this.cafeIShop.mc_background.currentFrame;
         this.inFridgeMode = true;
         this.onChangeFilter("",true);
         this.cafeIShop.txt_shop.text = CafeModel.languageData.getTextById("dialogwin_ingredient_storelayer");
         this.cafeIShop.mc_background.gotoAndStop(2);
         if(_loc1_ != this.cafeIShop.mc_background.currentFrame)
         {
            updateAllTextFields();
         }
         this.onChangeFridgeInventory();
      }
      
      private function switchToShop() : void
      {
         this.inFridgeMode = false;
         this.onChangeFilter("",true);
         this.cafeIShop.txt_shop.text = CafeModel.languageData.getTextById("dialogwin_ingredient_shoplayer");
         this.cafeIShop.mc_background.gotoAndStop(1);
      }
      
      private function getFilteredArray() : Array
      {
         var _loc2_:BasicIngredientVO = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in CafeModel.ingredientShop.ingredients)
         {
            if(!(_loc2_.wodId == CafeConstants.WODID_COCKTAILCHERRY && CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_WHEELOFFORTUNE))
            {
               if(!(_loc2_.itemGold > 0 && _loc2_.category != "fancy" && CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_PREMIUMDISH))
               {
                  if(this.inFridgeMode && CafeModel.inventoryFridge.isItemInInventoryFridge(_loc2_.wodId) && (this.cafeIShopProperties.filter == "" || this.cafeIShopProperties.filter == _loc2_.category) && CafeModel.inventoryFridge.getInventoryAmountByWodId(_loc2_.wodId) > 0)
                  {
                     _loc1_.push(_loc2_);
                  }
                  if(_loc2_.isItemAvalibleByEvent())
                  {
                     if(!this.inFridgeMode && (this.cafeIShopProperties.filter == "" && _loc2_.category != "fancy" || this.cafeIShopProperties.filter == _loc2_.category))
                     {
                        _loc1_.push(_loc2_);
                     }
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function checkShopItemState(param1:CafeIShopItem, param2:BasicIngredientVO) : void
      {
         var _loc3_:int = param1.currentFrame;
         var _loc4_:int = param2.category == "fancy" || param2.itemCash > 0 ? 0 : 1;
         if(param2.itemLevel > CafeModel.userData.userLevel)
         {
            param1.gotoAndStop(3 + _loc4_);
            param1.txt_level.text = CafeModel.languageData.getTextById("level") + " " + param2.itemLevel;
         }
         else if(!param2.availibility)
         {
            param1.gotoAndStop(5 + _loc4_);
            param1.btn_unlock.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + param1.btn_unlock.name);
            param1.txt_notinstock.text = CafeModel.languageData.getTextById("dialogwin_ingredient_notinstock");
         }
         else
         {
            param1.gotoAndStop(1 + _loc4_);
         }
         if(_loc3_ != param1.currentFrame)
         {
            updateAllTextFields();
         }
         param1.btn_wheel.visible = false;
         param1.txt_amount.visible = param1.currentFrame != 3 + _loc4_;
         param1.txt_price.visible = param1.currentFrame != 3 + _loc4_;
         param1.mc_money.visible = param1.currentFrame != 3 + _loc4_;
         if(param2.itemCash > CafeModel.userData.cash || param2.itemGold > CafeModel.userData.gold)
         {
            param1.btn_buy.enableButton = false;
            delete param1.btn_buy.toolTipText;
         }
         else if(param2.wodId == CafeConstants.WODID_COCKTAILCHERRY)
         {
            param1.gotoAndStop(1);
            param1.mc_money.visible = false;
            param1.txt_price.text = "";
            param1.btn_buy.enableButton = false;
            param1.btn_buy.visible = false;
            if(param1.btn_unlock)
            {
               param1.btn_unlock.visible = false;
            }
            param1.btn_wheel.visible = true;
            param1.btn_wheel.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_btn_wheel");
         }
         else if(param1.currentFrame == 1 + _loc4_)
         {
            param1.btn_buy.visible = true;
            param1.btn_buy.enableButton = param2.isItemAvalibleByEvent();
            if(param1.btn_buy.enabled)
            {
               param1.btn_buy.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + param1.btn_buy.name);
            }
            else
            {
               delete param1.btn_buy.toolTipText;
            }
         }
         else
         {
            param1.btn_buy.enableButton = false;
            delete param1.btn_buy.toolTipText;
         }
      }
      
      private function checkShopItemAmount(param1:CafeIShopItem, param2:BasicIngredientVO) : void
      {
         var _loc3_:int = CafeModel.inventoryFridge.getInventoryAmountByWodId(param2.wodId);
         param1.txt_amount.text = String(_loc3_);
         if(_loc3_ > 0)
         {
            param1.btn_sell.enableButton = true;
            param1.btn_sell.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + param1.btn_sell.name);
         }
         else
         {
            param1.btn_sell.enableButton = false;
            delete param1.btn_sell.toolTipText;
         }
      }
      
      private function onChangeIngredient(param1:CafeInventoryEvent) : void
      {
         this.fillItems();
      }
      
      private function onChangeItemAmount(param1:CafeInventoryEvent) : void
      {
         var _loc2_:BasicIngredientVO = CafeModel.ingredientShop.getIngredientVOById(param1.wodId);
         if(!this.inFridgeMode)
         {
            this.throwOneItemsDo(param1.wodId,this.checkShopItemAmount);
         }
         else
         {
            this.fillItems();
         }
         this.onChangeFridgeSize();
      }
      
      private function onChangeFridgeSize(param1:CafeInventoryEvent = null) : void
      {
         this.cafeIShop.txt_boughtIngredients.text = CafeModel.languageData.getTextById("dialogwin_ingredient_storeinused") + CafeModel.inventoryFridge.inUsed;
         this.cafeIShop.txt_capacity.text = CafeModel.languageData.getTextById("dialogwin_ingredient_storecapacity") + CafeModel.inventoryFridge.maxCapacity;
         this.onChangeFridgeInventory();
      }
      
      private function onChangeFridgeInventory() : void
      {
         if(!this.inFridgeMode)
         {
            return;
         }
         this.cafeIShop.mc_background.mc_emptyfridge.txt_title.text = CafeModel.languageData.getTextById("dialogwin_ingredient_emptyfridge");
         this.cafeIShop.mc_background.mc_emptyfridge.visible = CafeModel.inventoryFridge.inUsed <= 0 && CafeModel.inventoryFridge.numFancy <= 0;
      }
      
      private function onChangeUserData(param1:CafeUserEvent) : void
      {
         this.cafeIShop.txt_cash.text = NumberStringHelper.groupString(CafeModel.userData.cash,CafeModel.languageData.getTextById);
         this.cafeIShop.txt_gold.text = NumberStringHelper.groupString(CafeModel.userData.gold,CafeModel.languageData.getTextById);
         this.throwAllItemsDo(this.checkShopItemState);
      }
      
      private function onUnlockItem(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:CafeIShopItem = _loc2_.parent as CafeIShopItem;
         this.selectedItem = _loc3_;
         if(CafeModel.inventoryFridge.capacity >= 1)
         {
            layoutManager.showDialog(CafeChoiceAmountDialog.NAME,new CafeChoiceAmountDialogProperties(Math.min(CafeModel.inventoryFridge.capacity,CafeConstants.maxCourierSize),this.selectedItem.wodId,CafeModel.languageData.getTextById("alert_unlockitem_title"),CafeModel.languageData.getTextById("alert_unlockitem_copy"),CafeChoiceAmountDialogProperties.BUTTONTYPE_COURIER,this.onClickUnlockDialogYes,null,"x" + CafeConstants.courierPrice,CafeModel.languageData.getTextById("btn_text_cancle")));
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_storefull_title"),CafeModel.languageData.getTextById("alert_storefull_copy")));
         }
      }
      
      private function onBuyItem(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null || !_loc2_.enabled)
         {
            return;
         }
         var _loc3_:CafeIShopItem = _loc2_.parent as CafeIShopItem;
         this.selectedItem = _loc3_;
         if(CafeModel.inventoryFridge.capacity >= this.selectedItem.amount || (CafeModel.wodData.voList[this.selectedItem.wodId] as BasicIngredientVO).category == "fancy")
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_SHOP_BUY_ITEM,[this.selectedItem.wodId,this.selectedItem.amount]);
         }
         else if(CafeModel.inventoryFridge.maxCapacity > 0)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_storefull_title"),CafeModel.languageData.getTextById("alert_storefull_copy")));
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_nofridge_title"),CafeModel.languageData.getTextById("alert_nofridge_copy")));
         }
      }
      
      private function onSellItem(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null || !_loc2_.enabled)
         {
            return;
         }
         var _loc3_:CafeIShopItem = _loc2_.parent as CafeIShopItem;
         this.selectedItem = _loc3_;
         var _loc4_:String = String((CafeModel.wodData.voList[this.selectedItem.wodId] as ShopVO).calculateSaleValueCash()) + " " + CafeModel.languageData.getTextById("cash");
         layoutManager.showDialog(CafeChoiceAmountDialog.NAME,new CafeChoiceAmountDialogProperties(CafeModel.inventoryFridge.getInventoryAmountByWodId(this.selectedItem.wodId),this.selectedItem.wodId,CafeModel.languageData.getTextById("alert_sellitem_title"),CafeModel.languageData.getTextById("alert_sellitem_copy",[_loc4_]),CafeChoiceAmountDialogProperties.BUTTONTYPE_STANDARD,this.onClickSellDialogYes,null,CafeModel.languageData.getTextById("btn_text_okay"),CafeModel.languageData.getTextById("btn_text_cancle")));
      }
      
      private function onClickUnlockDialogYes(param1:Array) : void
      {
         this.selectedItem.mc_waitingcontainer.addChild(new ServerWaitingAnim());
         controller.sendServerMessageAndWait(SFConstants.C2S_SHOP_CARRIER_PIGEON,param1,SFConstants.S2C_SHOP_CARRIER_PIGEON);
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_SHOP_CARRIER_PIGEON)
         {
            while(this.selectedItem.mc_waitingcontainer.numChildren > 0)
            {
               this.selectedItem.mc_waitingcontainer.removeChildAt(0);
            }
         }
         if(param1 == SFConstants.S2C_SHOP_AVAILIBILITY)
         {
            this.isWaitingForServerMessage = false;
            this.fillItems();
         }
      }
      
      private function onClickSellDialogYes(param1:Array) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_SHOP_DELETE_ITEM,param1);
      }
      
      private function throwAllItemsDo(param1:Function) : void
      {
         var _loc2_:BasicIngredientVO = null;
         var _loc3_:int = 0;
         var _loc4_:CafeIShopItem = null;
         for each(_loc2_ in CafeModel.ingredientShop.ingredients)
         {
            _loc3_ = 0;
            while(_loc3_ < this.cafeIShopProperties.itemsPerPage)
            {
               if((_loc4_ = this.cafeIShop.mc_content["i" + _loc3_] as CafeIShopItem).wodId == _loc2_.wodId)
               {
                  param1(_loc4_,_loc2_);
               }
               _loc3_++;
            }
         }
      }
      
      private function throwOneItemsDo(param1:int, param2:Function) : void
      {
         var _loc3_:BasicIngredientVO = null;
         var _loc4_:int = 0;
         var _loc5_:CafeIShopItem = null;
         for each(_loc3_ in CafeModel.ingredientShop.ingredients)
         {
            if(_loc3_.wodId == param1)
            {
               _loc4_ = 0;
               while(_loc4_ < this.cafeIShopProperties.itemsPerPage)
               {
                  if((_loc5_ = this.cafeIShop.mc_content["i" + _loc4_] as CafeIShopItem).wodId == _loc3_.wodId)
                  {
                     param2(_loc5_,_loc3_);
                     return;
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.update();
         this.cafeIShop.btn_addcash.selected();
         if(tutorialController.isActive)
         {
            if(tutorialController.tutorialState == CafeTutorialController.TUT_STATE_COOK_BUYMISSINGINGREDIENT)
            {
               this.cafeIShop.mc_content.i1.btn_buy.addChild(tutorialController.mc_tutotialArrow);
               tutorialController.mc_tutotialArrow.scaleX = tutorialController.mc_tutotialArrow.scaleY = -1;
            }
         }
      }
      
      protected function get cafeIShopProperties() : CafeIngredientShopDialogProperties
      {
         return properties as CafeIngredientShopDialogProperties;
      }
      
      private function get cafeIShop() : CafeIShop
      {
         return disp as CafeIShop;
      }
   }
}
