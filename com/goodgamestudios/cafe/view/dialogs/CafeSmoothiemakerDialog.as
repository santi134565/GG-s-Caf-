package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.fastfood.BasicFastfoodVO;
   import com.goodgamestudios.math.MathBase;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeSmoothiemakerDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeSmoothiemakerDialog";
       
      
      private var currentPage:int = 0;
      
      private var maxPage:int = 0;
      
      private var selectedItem:BasicFastfoodVO;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeSmoothiemakerDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         controller.addEventListener(CafeUserEvent.CHANGE_USERDATA,this.onChangeUserData);
         controller.addEventListener(CafeUserEvent.INIT_USERDATA,this.onChangeUserData);
         super.init();
      }
      
      override protected function applyProperties() : void
      {
         this.smoothieDialog.txt_title.text = CafeModel.languageData.getTextById(NAME + "_title");
         this.smoothieDialog.btn_addcash.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.smoothieDialog.btn_addcash.name);
         this.smoothieDialog.btn_addcash.visible = env.usePayment;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeUserEvent.CHANGE_USERDATA,this.onChangeUserData);
         controller.removeEventListener(CafeUserEvent.INIT_USERDATA,this.onChangeUserData);
      }
      
      override protected function update() : void
      {
         this.isWaitingForServerMessage = true;
         TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.smoothieDialog.txt_cash,NumberStringHelper.groupString(CafeModel.userData.cash,CafeModel.languageData.getTextById));
         this.smoothieDialog.txt_gold.text = NumberStringHelper.groupString(CafeModel.userData.gold,CafeModel.languageData.getTextById);
         this.currentPage = 0;
         this.fillItems();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.smoothieDialog.btn_info:
               layoutManager.showDialog(CafeSmoothiemakerHelpDialog.NAME);
               break;
            case this.smoothieDialog.btn_arrow_left:
            case this.smoothieDialog.btn_arrow_right:
               this.onClickArrow(param1);
               break;
            case this.smoothieDialog.btn_addcash:
               if(CafeModel.userData.isGuest())
               {
                  layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
               }
               else
               {
                  controller.addExtraGold();
               }
               break;
            case this.smoothieDialog.btn_close:
               hide();
               break;
            case this.smoothieDialog.i0.btn_action:
            case this.smoothieDialog.i1.btn_action:
            case this.smoothieDialog.j0.btn_action:
            case this.smoothieDialog.j1.btn_action:
               this.onBuyItem(param1);
         }
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this.currentPage;
         if(param1.target == this.smoothieDialog.btn_arrow_left)
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
      
      private function initArrows(param1:int, param2:int) : void
      {
         var _loc3_:int = (param1 - 1) / this.smoothieProperties.PRO_ITEMS_PER_PAGE;
         var _loc4_:int = (param2 - 1) / this.smoothieProperties.STD_ITEMS_PER_PAGE;
         this.maxPage = MathBase.max(_loc3_,_loc4_);
         this.smoothieDialog.btn_arrow_right.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.smoothieDialog.btn_arrow_left.visible = this.maxPage > 0 && this.currentPage > 0;
      }
      
      private function fillItems() : void
      {
         var _loc7_:SmoothieItem_Pro = null;
         var _loc8_:BasicFastfoodVO = null;
         var _loc9_:SmoothieItem_Std = null;
         var _loc10_:BasicFastfoodVO = null;
         var _loc1_:int = this.currentPage * (this.smoothieProperties.PRO_ITEMS_PER_PAGE + this.smoothieProperties.STD_ITEMS_PER_PAGE);
         var _loc2_:int = _loc1_;
         var _loc3_:Array = this.getFilteredProArray();
         var _loc4_:Array = this.getFilteredStdArray();
         this.initArrows(_loc3_.length,_loc4_.length);
         var _loc5_:int = 0;
         while(_loc5_ < this.smoothieProperties.PRO_ITEMS_PER_PAGE)
         {
            _loc7_ = this.smoothieDialog["i" + _loc5_] as SmoothieItem_Pro;
            if(_loc2_ < _loc3_.length)
            {
               _loc8_ = _loc3_[_loc2_] as BasicFastfoodVO;
               _loc7_.txt_price.text = NumberStringHelper.groupString(_loc8_.itemGold,CafeModel.languageData.getTextById);
               this.drawFastFoodItem(_loc7_,_loc8_);
               _loc7_.visible = true;
            }
            else
            {
               _loc7_.visible = false;
            }
            _loc2_++;
            _loc5_++;
         }
         _loc2_ = _loc1_;
         var _loc6_:int = 0;
         while(_loc6_ < this.smoothieProperties.STD_ITEMS_PER_PAGE)
         {
            _loc9_ = this.smoothieDialog["j" + _loc6_] as SmoothieItem_Std;
            if(_loc2_ < _loc4_.length)
            {
               _loc10_ = _loc4_[_loc2_] as BasicFastfoodVO;
               _loc9_.txt_price.text = NumberStringHelper.groupString(_loc10_.itemCash,CafeModel.languageData.getTextById);
               this.drawFastFoodItem(_loc9_,_loc10_);
               _loc9_.visible = true;
            }
            else
            {
               _loc9_.visible = false;
            }
            _loc2_++;
            _loc6_++;
         }
      }
      
      private function drawFastFoodItem(param1:Object, param2:BasicFastfoodVO) : void
      {
         TextFieldHelper.changeTextFromatSizeByTextWidth(15,param1.txt_title,CafeModel.languageData.getTextById("recipe_smoothiemaker_" + param2.type.toLowerCase()));
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,param1.txt_servings,CafeModel.languageData.getTextById("dialogwin_cookbook_servings",[NumberStringHelper.groupString(param2.baseServings,CafeModel.languageData.getTextById)]));
         var _loc3_:int = Math.ceil(param2.baseXP * (CafeModel.userData.userLevel + 18) / 190);
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,param1.txt_xp,CafeModel.languageData.getTextById("dialogwin_cookbook_income",[_loc3_ + ""]));
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,param1.txt_cash,CafeModel.languageData.getTextById("dialogwin_cookbook_income",[NumberStringHelper.groupString(param2.baseCash,CafeModel.languageData.getTextById)]));
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,param1.txt_rating,CafeModel.languageData.getTextById("dialogwin_cookbook_income",[NumberStringHelper.groupString(param2.baseRating / 10,CafeModel.languageData.getTextById)]));
         param1.btn_action.toolTipText = CafeModel.languageData.getTextById("tt_CafeSmoothiemaker_btn_mix");
         param1.wodId = param1.btn_action.wodId = param2.wodId;
         var _loc5_:Sprite;
         var _loc4_:Class;
         var _loc6_:Rectangle = (_loc5_ = new (_loc4_ = getDefinitionByName(param2.getVisClassName()) as Class)()).getBounds(null);
         _loc5_.x = -(_loc6_.width / 2 + _loc6_.left);
         _loc5_.y = -(_loc6_.height / 2 + _loc6_.top);
         while(param1.mc_holder.numChildren > 0)
         {
            param1.mc_holder.removeChildAt(0);
         }
         param1.mc_holder.addChild(_loc5_);
      }
      
      private function getFilteredProArray() : Array
      {
         var _loc2_:BasicFastfoodVO = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in CafeModel.fastfoodData.smoothies)
         {
            if(_loc2_.itemGold > 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function getFilteredStdArray() : Array
      {
         var _loc2_:BasicFastfoodVO = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in CafeModel.fastfoodData.smoothies)
         {
            if(_loc2_.itemCash > 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function onChangeUserData(param1:CafeUserEvent) : void
      {
         this.smoothieDialog.txt_cash.text = NumberStringHelper.groupString(CafeModel.userData.cash,CafeModel.languageData.getTextById);
         this.smoothieDialog.txt_gold.text = NumberStringHelper.groupString(CafeModel.userData.gold,CafeModel.languageData.getTextById);
      }
      
      private function onBuyItem(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null || !_loc2_.enabled)
         {
            return;
         }
         if((CafeModel.wodData.voList[param1.target.wodId] as BasicFastfoodVO).itemCash > CafeModel.userData.cash || (CafeModel.wodData.voList[param1.target.wodId] as BasicFastfoodVO).itemGold > CafeModel.userData.gold)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_copy")));
         }
         else
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_FASTFOOD_COOK,[this.smoothieProperties.target.isoX,this.smoothieProperties.target.isoY,param1.target.wodId]);
            hide();
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.update();
         this.smoothieDialog.btn_addcash.selected();
      }
      
      protected function get smoothieProperties() : CafeSmoothiemakerDialogProperties
      {
         return properties as CafeSmoothiemakerDialogProperties;
      }
      
      private function get smoothieDialog() : CafeSmoothieDialog
      {
         return disp as CafeSmoothieDialog;
      }
   }
}
