package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeFancyCookingDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeFancyCookingDialog";
       
      
      private var MAX_DISH_WIDTH:int = 50;
      
      private var MAX_DISH_HEIGHT:int = 40;
      
      private var MAX_FANCY_WIDTH:int = 80;
      
      private var MAX_FANCY_HEIGHT:int = 70;
      
      private var fancyVO:BasicIngredientVO;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeFancyCookingDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.isWaitingForServerMessage = false;
         var _loc1_:int = this.fancyDialogProperties.dishVO.fancyRequirement.wodId;
         this.fancyVO = CafeModel.wodData.voList[_loc1_] as BasicIngredientVO;
         this.fancyDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_fancycooking_title",[CafeModel.languageData.getTextById("ingredient_" + this.fancyVO.type.toLowerCase())]);
         this.fancyDialog.txt_servings.text = "+ " + this.fancyDialogProperties.dishVO.getFancyServingAmount();
         this.fancyDialog.txt_xp.text = "+ " + this.fancyDialogProperties.dishVO.getFancyXpAmount();
         this.fancyDialog.btn_no.label = CafeModel.languageData.getTextById("btn_text_no");
         this.fancyDialog.btn_yes.label = CafeModel.languageData.getTextById("btn_text_yes");
         this.fancyDialog.btn_yes.visible = this.fancyDialogProperties.type == CafeFancyCookingDialogProperties.USE_FANCY;
         this.fancyDialog.btn_buy.visible = this.fancyDialogProperties.type == CafeFancyCookingDialogProperties.BUY_FANCY;
         if(this.fancyVO == null)
         {
            return;
         }
         this.fancyDialog.btn_buy.txt_label.text = "x" + this.fancyVO.itemGold;
         this.fillItems();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.fancyDialog.btn_close:
               hide();
               break;
            case this.fancyDialog.btn_yes:
               hide();
               if(this.fancyDialogProperties.onCookWithFancy != null)
               {
                  this.fancyDialogProperties.onCookWithFancy(null);
               }
               break;
            case this.fancyDialog.btn_buy:
               hide();
               this.isWaitingForServerMessage = true;
               controller.sendServerMessageAndWait(SFConstants.C2S_SHOP_BUY_ITEM,[this.fancyVO.wodId,this.fancyVO.amount],SFConstants.S2C_SHOP_BUY_ITEM);
               break;
            case this.fancyDialog.btn_no:
               hide();
               CafeModel.userData.startFancyPopupTimer(this.fancyDialogProperties.dishVO.wodId);
               if(this.fancyDialogProperties.onCookWithoutFancy != null)
               {
                  this.fancyDialogProperties.onCookWithoutFancy(null);
               }
         }
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(this.isWaitingForServerMessage && param1 == SFConstants.S2C_SHOP_BUY_ITEM)
         {
            this.isWaitingForServerMessage = false;
            if(this.fancyDialogProperties.onCookWithFancy != null)
            {
               this.fancyDialogProperties.onCookWithFancy(null);
            }
         }
      }
      
      private function fillItems() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:Class = getDefinitionByName(this.fancyVO.getVisClassName()) as Class;
         var _loc3_:Sprite = new _loc2_();
         var _loc4_:Rectangle = _loc3_.getBounds(null);
         _loc1_ = this.MAX_FANCY_WIDTH / _loc4_.width;
         if(_loc4_.height * _loc1_ > this.MAX_FANCY_HEIGHT)
         {
            _loc1_ = this.MAX_FANCY_HEIGHT / _loc4_.height;
         }
         _loc3_.scaleX = _loc3_.scaleY = _loc1_;
         _loc3_.x = -(_loc4_.width * _loc1_ / 2 + _loc4_.left * _loc1_);
         _loc3_.y = -(_loc4_.height * _loc1_ / 2 + _loc4_.top * _loc1_);
         while(this.fancyDialog.mc_fancyholder.numChildren > 0)
         {
            this.fancyDialog.mc_fancyholder.removeChildAt(0);
         }
         this.fancyDialog.mc_fancyholder.addChild(_loc3_);
         var _loc6_:MovieClip;
         var _loc5_:Class;
         (_loc6_ = new (_loc5_ = getDefinitionByName(this.fancyDialogProperties.dishVO.getVisClassName()) as Class)()).gotoAndStop(BasicDishVO.GFX_FRAME_READY);
         var _loc7_:Rectangle = _loc6_.getBounds(null);
         _loc1_ = this.MAX_DISH_WIDTH / _loc7_.width;
         if(_loc7_.height * _loc1_ > this.MAX_DISH_HEIGHT)
         {
            _loc1_ = this.MAX_DISH_HEIGHT / _loc7_.height;
         }
         _loc6_.scaleX = _loc6_.scaleY = _loc1_;
         _loc6_.x = -(_loc7_.width * _loc1_ / 2 + _loc7_.left * _loc1_);
         _loc6_.y = -(_loc7_.height * _loc1_ / 2 + _loc7_.top * _loc1_);
         while(this.fancyDialog.mc_servingholder.numChildren > 0)
         {
            this.fancyDialog.mc_servingholder.removeChildAt(0);
         }
         this.fancyDialog.mc_servingholder.addChild(_loc6_);
      }
      
      protected function get fancyDialogProperties() : CafeFancyCookingDialogProperties
      {
         return properties as CafeFancyCookingDialogProperties;
      }
      
      private function get fancyDialog() : CafeFancyCooking
      {
         return disp as CafeFancyCooking;
      }
   }
}
