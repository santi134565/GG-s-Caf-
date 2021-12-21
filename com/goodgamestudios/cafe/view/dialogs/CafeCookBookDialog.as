package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafeInventoryEvent;
   import com.goodgamestudios.cafe.event.CafeTutorialEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.dish.RequirementVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   
   public class CafeCookBookDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeCookBookDialog";
      
      public static const GLOWTIME:int = 300;
       
      
      private var currentPage:int = 0;
      
      private var maxPage:int = 0;
      
      private var colorMatrix:ColorMatrix;
      
      private var selectedDish:int;
      
      private var timer:Timer;
      
      public function CafeCookBookDialog(param1:Sprite)
      {
         this.colorMatrix = new ColorMatrix();
         super(param1);
      }
      
      override protected function init() : void
      {
         this.timer = new Timer(GLOWTIME,1);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerEnd);
         this.colorMatrix.desaturate();
         controller.addEventListener(CafeInventoryEvent.UPDATE_INVENTORY,this.onCookBookDataChange);
         controller.addEventListener(CafeUserEvent.LEVELUP,this.onCookBookDataChange);
         controller.addEventListener(CafeTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
         super.init();
      }
      
      override protected function applyProperties() : void
      {
         this.cafeCBook.btn_shop.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeCBook.btn_shop.name);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerEnd);
         controller.removeEventListener(CafeInventoryEvent.UPDATE_INVENTORY,this.onCookBookDataChange);
         controller.removeEventListener(CafeUserEvent.LEVELUP,this.onCookBookDataChange);
         controller.removeEventListener(CafeTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
      }
      
      private function onTutorialEvent(param1:CafeTutorialEvent) : void
      {
         switch(CafeTutorialController.getInstance().tutorialState)
         {
            case CafeTutorialController.TUT_STATE_COOK_COOKMEAL:
               this.cafeCBook.mc_recipe0.btn_cook.addChild(tutorialController.mc_tutotialArrow);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         if(tutorialController.isActive)
         {
            switch(CafeTutorialController.getInstance().tutorialState)
            {
               case CafeTutorialController.TUT_STATE_COOK_OPENSHOP:
                  if(param1.target == this.cafeCBook.btn_shop || param1.target == this.cafeCBook.mc_recipe0.btn_shop)
                  {
                     tutorialController.nextStep();
                     break;
                  }
                  return;
                  break;
               case CafeTutorialController.TUT_STATE_COOK_COOKMEAL:
                  if(param1.target == this.cafeCBook.mc_recipe0.btn_cook)
                  {
                     tutorialController.nextStep();
                     break;
                  }
                  return;
            }
         }
         switch(param1.target)
         {
            case this.cafeCBook.btn_arrowRight:
            case this.cafeCBook.btn_arrowLeft:
               this.onClickArrow(param1);
               break;
            case this.cafeCBook.btn_cancel:
               hide();
               break;
            case this.cafeCBook.btn_shop:
               layoutManager.showDialog(CafeIngredientShopDialog.NAME,new CafeIngredientShopDialogProperties());
               break;
            case this.cafeCBook.mc_recipe0.btn_cook:
            case this.cafeCBook.mc_recipe1.btn_cook:
            case this.cafeCBook.mc_recipe2.btn_cook:
            case this.cafeCBook.mc_recipe3.btn_cook:
               this.onClickCookItem(param1);
               break;
            case this.cafeCBook.mc_recipe0.btn_shop:
            case this.cafeCBook.mc_recipe1.btn_shop:
            case this.cafeCBook.mc_recipe2.btn_shop:
            case this.cafeCBook.mc_recipe3.btn_shop:
               layoutManager.showDialog(CafeIngredientShopDialog.NAME,new CafeIngredientShopDialogProperties());
               break;
            case this.cafeCBook.mc_recipe0.masteryinfo:
            case this.cafeCBook.mc_recipe1.masteryinfo:
            case this.cafeCBook.mc_recipe2.masteryinfo:
            case this.cafeCBook.mc_recipe3.masteryinfo:
               layoutManager.showDialog(CafeMasteryInfoDialog.NAME,new CafeMasteryInfoDialogProperties(param1.target.wodId));
         }
      }
      
      private function highlightShopButton() : void
      {
         this.cafeCBook.btn_shop.selected();
         if(this.timer.running)
         {
            this.timer.stop();
         }
         this.timer.start();
      }
      
      private function onTimerEnd(param1:TimerEvent) : void
      {
         this.timer.stop();
         this.cafeCBook.btn_shop.deselected();
      }
      
      private function getFilteredArray() : Array
      {
         var _loc2_:BasicDishVO = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in CafeModel.cookBook.dishes)
         {
            if(_loc2_.isItemAvalibleByEvent() && this.isAllowedToBuy(_loc2_))
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function isAllowedToBuy(param1:BasicDishVO) : Boolean
      {
         var _loc2_:RequirementVO = null;
         if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_PREMIUMDISH)
         {
            for each(_loc2_ in param1.requirements)
            {
               if((CafeModel.wodData.voList[_loc2_.wodId] as BasicIngredientVO).itemGold > 0)
               {
                  return false;
               }
               if((CafeModel.wodData.voList[_loc2_.wodId] as BasicIngredientVO).itemGold == 0 && (CafeModel.wodData.voList[_loc2_.wodId] as BasicIngredientVO).itemCash == 0)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function fillItems() : void
      {
         var _loc4_:int = 0;
         var _loc5_:CafeCBookItem = null;
         var _loc6_:BasicDishVO = null;
         var _loc7_:Class = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Rectangle = null;
         var _loc1_:int = this.currentPage * this.cookBookDialogProperties.itemsPerPage;
         var _loc2_:Array = this.getFilteredArray();
         this.initArrows(_loc2_.length);
         var _loc3_:int = _loc1_;
         while(_loc3_ < _loc1_ + this.cookBookDialogProperties.itemsPerPage)
         {
            _loc4_ = _loc3_ - _loc1_;
            (_loc5_ = this.cafeCBook["mc_recipe" + _loc4_] as CafeCBookItem).bg.gotoAndStop(1);
            if(_loc3_ < _loc2_.length)
            {
               (_loc6_ = _loc2_[_loc3_] as BasicDishVO).checkFancyRequirements(CafeModel.wodData.voList);
               _loc5_.txt_recipeTitle.text = CafeModel.languageData.getTextById("recipe_" + _loc6_.type.toLowerCase());
               _loc5_.txt_recipeXp.text = String(_loc6_.getMasterdXp());
               _loc5_.txt_servingCost.text = CafeModel.languageData.getTextById("dialogwin_cookbook_income",[_loc6_.incomePerServing]);
               _loc5_.txt_servingsAmount.text = CafeModel.languageData.getTextById("dialogwin_cookbook_servings",[_loc6_.getMasterdServings()]);
               _loc5_.txt_leftTime.text = CafeModel.languageData.getTextById("dialogwin_cookbook_readyin",[TimeStringHelper.getShortTimeStringByMinutes(_loc6_.getDuration())]);
               _loc5_.wodId = _loc6_.wodId;
               _loc5_.btn_cook.wodId = _loc5_.wodId;
               _loc5_.mc_dishcategory.gotoAndStop(_loc6_.dishcategory + 1);
               _loc5_.mc_dishcategory.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + _loc6_.dishcategory);
               (_loc8_ = new (_loc7_ = getDefinitionByName(_loc6_.getVisClassName()) as Class)()).gotoAndStop(BasicDishVO.GFX_FRAME_READY);
               _loc9_ = _loc8_.getBounds(null);
               _loc8_.x = -(_loc9_.width / 2 + _loc9_.left);
               _loc8_.y = -(_loc9_.height / 2 + _loc9_.top);
               if(String(_loc6_.events[0]) == CafeConstants.EVENT_CHRISTMAS)
               {
                  _loc5_.bg.gotoAndStop(2);
               }
               if(_loc6_.isPremium)
               {
                  _loc5_.bg.gotoAndStop(3);
               }
               while(_loc5_.mc_recipeContainer.numChildren > 0)
               {
                  _loc5_.mc_recipeContainer.removeChildAt(0);
               }
               _loc5_.mc_recipeContainer.addChild(_loc8_);
               this.checkItemCookabled(_loc5_,_loc6_);
               this.setMasteryInfo(_loc5_,_loc6_);
               _loc5_.visible = true;
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc3_++;
         }
      }
      
      private function setMasteryInfo(param1:CafeCBookItem, param2:BasicDishVO) : void
      {
         param1.masteryinfo.mouseChildren = false;
         var _loc3_:int = CafeModel.masteryData.getMasteryLevel(param2.wodId);
         var _loc4_:int = CafeModel.masteryData.getCountTilLevel(param2.wodId,_loc3_ + 1);
         var _loc5_:int = 1;
         while(_loc5_ < 4)
         {
            if(_loc3_ >= _loc5_)
            {
               param1.masteryinfo["m" + _loc5_].gotoAndStop(2);
            }
            else
            {
               param1.masteryinfo["m" + _loc5_].gotoAndStop(1);
            }
            _loc5_++;
         }
         param1.masteryinfo.wodId = param2.wodId;
         if(_loc3_ < 3)
         {
            param1.masteryinfo.toolTipText = CafeModel.languageData.getTextById("tt_CafeCookBookDialog_btn_mastery",[_loc4_,_loc3_ + 1]);
         }
         else
         {
            param1.masteryinfo.toolTipText = null;
         }
      }
      
      private function onClickCookItem(param1:MouseEvent) : void
      {
         var _loc2_:BasicDishVO = null;
         var _loc3_:BasicIngredientVO = null;
         if(param1.target.enabled)
         {
            this.selectedDish = param1.target.wodId;
            if(this.selectedDish == -1)
            {
               return;
            }
            _loc2_ = CafeModel.wodData.createVObyWOD(this.selectedDish) as BasicDishVO;
            _loc2_.checkFancyRequirements(CafeModel.wodData.voList);
            if(param1.target.hasFancyIngredient && CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_FANCYS)
            {
               layoutManager.showDialog(CafeFancyCookingDialog.NAME,new CafeFancyCookingDialogProperties(_loc2_,this.onCook,this.onCookFancy,null,CafeFancyCookingDialogProperties.USE_FANCY));
            }
            else if(!tutorialController.isActive && CafeModel.userData.showFancyPopup && _loc2_.fancyRequirement)
            {
               _loc3_ = CafeModel.wodData.createVObyWOD(_loc2_.fancyRequirement.wodId) as BasicIngredientVO;
               layoutManager.showDialog(CafeFancyCookingDialog.NAME,new CafeFancyCookingDialogProperties(_loc2_,this.onCook,this.onCookFancy));
            }
            else
            {
               this.onCook(null);
            }
         }
      }
      
      private function onCookFancy(param1:Array) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_COOK,[this.cookBookDialogProperties.target.isoPos.x,this.cookBookDialogProperties.target.isoPos.y,this.selectedDish,0,1]);
         hide();
      }
      
      private function onCook(param1:Array) : void
      {
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_COOK,[this.cookBookDialogProperties.target.isoPos.x,this.cookBookDialogProperties.target.isoPos.y,this.selectedDish,0,0]);
         hide();
      }
      
      private function checkItemCookabled(param1:CafeCBookItem, param2:BasicDishVO) : void
      {
         var _loc4_:RequirementVO = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Class = null;
         var _loc7_:Sprite = null;
         var _loc8_:Rectangle = null;
         var _loc9_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:Sprite = null;
         var _loc12_:Rectangle = null;
         param1.mc_lock.visible = CafeModel.userData.userLevel < param2.level;
         param1.btn_cook.visible = this.cookBookDialogProperties.target != null;
         param1.btn_shop.visible = false;
         param1.btn_cook.enableButton = true;
         param1.btn_cook.hasFancyIngredient = false;
         param1.mc_lock.toolTipText = !!param1.mc_lock.visible ? CafeModel.languageData.getTextById("tt_byLevel",[param2.level]) : null;
         param1.btn_shop.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.cafeCBook.btn_shop.name);
         var _loc3_:int = 0;
         for each(_loc4_ in param2.requirements)
         {
            (_loc5_ = param1["mc_ingredientSlot" + _loc3_] as MovieClip).mouseChildren = false;
            _loc5_.txt_ingredientAmount.text = "x" + _loc4_.amount;
            _loc5_.toolTipText = CafeModel.languageData.getTextById("ingredient_" + String(CafeModel.ingredientShop.getIngredientVOById(_loc4_.wodId).type).toLocaleLowerCase());
            _loc8_ = (_loc7_ = new (_loc6_ = getDefinitionByName(CafeModel.ingredientShop.getIngredientVOById(_loc4_.wodId).getVisClassName()) as Class)()).getBounds(null);
            _loc7_.x = -(_loc8_.width / 2 + _loc8_.left);
            _loc7_.y = -(_loc8_.height / 2 + _loc8_.top);
            while(_loc5_.mc_recipeContainer.numChildren > 0)
            {
               _loc5_.mc_recipeContainer.removeChildAt(0);
            }
            _loc5_.mc_recipeContainer.addChild(_loc7_);
            if(CafeModel.inventoryFridge.getInventoryAmountByWodId(_loc4_.wodId) < _loc4_.amount)
            {
               param1.btn_shop.visible = true;
               _loc5_.filters = [this.colorMatrix.filter];
            }
            else
            {
               _loc5_.filters = null;
            }
            _loc5_.visible = true;
            _loc3_++;
         }
         while(_loc3_ < 5)
         {
            param1["mc_ingredientSlot" + _loc3_].visible = false;
            _loc3_++;
         }
         if(param2.fancyRequirement && CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_FANCYS)
         {
            (_loc9_ = param1["mc_ingredientSlot" + _loc3_] as MovieClip).mouseChildren = false;
            _loc9_.txt_ingredientAmount.text = "x" + param2.fancyRequirement.amount;
            _loc9_.toolTipText = CafeModel.languageData.getTextById("ingredient_" + String(CafeModel.ingredientShop.getIngredientVOById(param2.fancyRequirement.wodId).type).toLocaleLowerCase());
            _loc12_ = (_loc11_ = new (_loc10_ = getDefinitionByName(CafeModel.ingredientShop.getIngredientVOById(param2.fancyRequirement.wodId).getVisClassName()) as Class)()).getBounds(null);
            _loc11_.x = -(_loc12_.width / 2 + _loc12_.left);
            _loc11_.y = -(_loc12_.height / 2 + _loc12_.top);
            while(_loc9_.mc_recipeContainer.numChildren > 0)
            {
               _loc9_.mc_recipeContainer.removeChildAt(0);
            }
            _loc9_.mc_recipeContainer.addChild(_loc11_);
            if(CafeModel.inventoryFridge.getInventoryAmountByWodId(param2.fancyRequirement.wodId) < param2.fancyRequirement.amount)
            {
               _loc9_.filters = [this.colorMatrix.filter];
            }
            else
            {
               _loc9_.filters = null;
               param1.btn_cook.hasFancyIngredient = true;
            }
            _loc9_.visible = true;
         }
         else
         {
            param1["mc_ingredientSlot" + _loc3_].visible = false;
         }
         param1.btn_cook.toolTipText = !!param1.btn_cook.enabled ? CafeModel.languageData.getTextById("tt_" + NAME + "_" + param1.btn_cook.name) : CafeModel.languageData.getTextById("tt_" + NAME + "_" + param1.btn_cook.name + "_disabled");
         if(param1.mc_lock.visible)
         {
            param1.btn_shop.visible = false;
            param1.btn_cook.enableButton = false;
            param1.btn_cook.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[param2.level]);
         }
         if(!this.cookBookDialogProperties.target)
         {
            param1.btn_shop.visible = false;
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
         switch(param1.target)
         {
            case this.cafeCBook.mc_recipe0.btn_shop:
            case this.cafeCBook.mc_recipe1.btn_shop:
            case this.cafeCBook.mc_recipe2.btn_shop:
            case this.cafeCBook.mc_recipe3.btn_shop:
               this.highlightShopButton();
         }
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this.currentPage;
         if(param1.target == this.cafeCBook.btn_arrowLeft)
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
         this.maxPage = (param1 - 1) / this.cookBookDialogProperties.itemsPerPage;
         this.cafeCBook.btn_arrowRight.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.cafeCBook.btn_arrowLeft.visible = this.maxPage > 0 && this.currentPage > 0;
      }
      
      override public function show() : void
      {
         super.show();
         this.fillItems();
         if(tutorialController.isActive)
         {
            if(tutorialController.tutorialState == CafeTutorialController.TUT_STATE_COOK_OPENSHOP)
            {
               this.cafeCBook.mc_recipe0.btn_shop.addChild(tutorialController.mc_tutotialArrow);
            }
         }
      }
      
      private function onCookBookDataChange(param1:Event) : void
      {
         this.fillItems();
      }
      
      protected function get cookBookDialogProperties() : CafeCookBookDialogProperties
      {
         return properties as CafeCookBookDialogProperties;
      }
      
      private function get cafeCBook() : CafeCBook
      {
         return disp as CafeCBook;
      }
   }
}
