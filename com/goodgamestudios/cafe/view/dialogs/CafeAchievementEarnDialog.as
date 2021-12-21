package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeSocialData;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeAchievementEarnDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeAchievementEarnDialog";
       
      
      private const MAX_WIDTH:int = 70;
      
      private const MAX_HEIGHT:int = 70;
      
      private const MAX_TEXTICONHEIGHT:int = 50;
      
      public function CafeAchievementEarnDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function get isUnique() : Boolean
      {
         return false;
      }
      
      override protected function applyProperties() : void
      {
         this.bonusDialog.btn_ok.label = CafeModel.languageData.getTextById("btn_text_okay");
         this.bonusDialog.btn_cancle.label = CafeModel.languageData.getTextById("btn_text_cancle");
         this.bonusDialog.btn_share.label = CafeModel.languageData.getTextById("btn_text_share");
         this.bonusDialog.txt_title.text = this.bonusDialogProperties.title;
         this.bonusDialog.txt_copy.text = this.bonusDialogProperties.copy;
         var _loc1_:Boolean = env.enableFeedMessages;
         this.bonusDialog.btn_share.visible = _loc1_;
         this.bonusDialog.btn_cancle.visible = _loc1_;
         this.bonusDialog.btn_ok.visible = !_loc1_;
         while(this.bonusDialog.mc_achievementholder.numChildren > 0)
         {
            this.bonusDialog.mc_achievementholder.removeChildAt(0);
         }
         while(this.bonusDialog.mc_iconholder.numChildren > 0)
         {
            this.bonusDialog.mc_iconholder.removeChildAt(0);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:VisualVO = null;
         super.onClick(param1);
         switch(param1.target)
         {
            case this.bonusDialog.btn_ok:
            case this.bonusDialog.btn_cancle:
               hide();
               break;
            case this.bonusDialog.btn_share:
               hide();
               _loc2_ = this.bonusDialogProperties.bonuselements[0];
               if(_loc2_)
               {
                  CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_ACHIEVEMENT,this.bonusDialogProperties.feedparams);
               }
         }
      }
      
      private function fillItems() : void
      {
         var _loc2_:VisualVO = null;
         var _loc5_:CafeBonusElement = null;
         var _loc6_:Class = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Rectangle = null;
         var _loc11_:String = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in this.bonusDialogProperties.bonuselements)
         {
            if(!(!_loc2_.isItemAvalibleByEvent() && !(_loc2_ is ShopVO && (_loc2_ as ShopVO).events[0] == "4")))
            {
               (_loc5_ = new CafeBonusElement()).mouseChildren = false;
               if((_loc7_ = new (_loc6_ = getDefinitionByName(CafeModel.wodData.voList[_loc2_.wodId].getVisClassName()) as Class)()) is MovieClip)
               {
                  (_loc7_ as MovieClip).gotoAndStop(1);
               }
               _loc8_ = this.MAX_HEIGHT;
               _loc9_ = 0;
               if(_loc2_.hasOwnProperty("amount") && _loc2_["amount"] > 0)
               {
                  _loc9_ = _loc2_["amount"];
               }
               if(_loc2_.hasOwnProperty("itemAmount") && _loc2_["itemAmount"] > 0)
               {
                  _loc9_ = _loc2_["itemAmount"];
               }
               if(_loc2_ is BasicIngredientVO && _loc2_.hasOwnProperty("inventoryAmount") && _loc2_["inventoryAmount"] > 0)
               {
                  _loc9_ = _loc2_["inventoryAmount"];
               }
               if(_loc9_ > 0)
               {
                  _loc8_ = this.MAX_TEXTICONHEIGHT;
                  _loc5_.txt_value.text = "x " + NumberStringHelper.groupString(_loc9_,CafeModel.languageData.getTextById);
                  _loc5_.txt_value.width = _loc5_.txt_value.textWidth + 5;
                  _loc5_.txt_value.x = -(_loc5_.txt_value.width / 2);
                  _loc5_.txt_value.y = this.MAX_HEIGHT / 2 - 10;
                  _loc5_.txt_value.visible = true;
               }
               else
               {
                  _loc5_.txt_value.visible = false;
               }
               _loc10_ = _loc7_.getBounds(null);
               _loc1_ = this.MAX_WIDTH / _loc10_.width;
               if(_loc10_.height * _loc1_ > _loc8_)
               {
                  _loc1_ = _loc8_ / _loc10_.height;
               }
               _loc7_.scaleX = _loc7_.scaleY = _loc1_;
               if(_loc2_.group == CafeConstants.GROUP_INGREDIENT)
               {
                  _loc11_ = CafeModel.languageData.getTextById("ingredient_" + _loc2_.type.toLocaleLowerCase());
               }
               else
               {
                  (_loc7_ as MovieClip).gotoAndStop(1);
                  _loc11_ = CafeModel.languageData.getTextById("tt_" + _loc2_.getVisClassName());
               }
               if(_loc11_.length > 0)
               {
                  _loc5_.toolTipText = _loc11_;
                  _loc5_.mouseChildren = false;
               }
               _loc7_.x = -(_loc10_.width * _loc1_ / 2 + _loc10_.left * _loc1_);
               if(_loc5_.txt_value.visible)
               {
                  _loc7_.y = -(_loc10_.height * _loc1_ / 2 + _loc10_.top * _loc1_ + 10);
               }
               else
               {
                  _loc7_.y = -(_loc10_.height * _loc1_ / 2 + _loc10_.top * _loc1_);
               }
               while(_loc5_.mc_holder.numChildren > 0)
               {
                  _loc5_.mc_holder.removeChildAt(0);
               }
               _loc5_.mc_holder.addChild(_loc7_);
               this.bonusDialog.mc_achievementholder.addChild(_loc5_);
            }
         }
         this.reposItemHolder(this.bonusDialog.mc_achievementholder);
         if(this.bonusDialogProperties.achievementWodId < 0)
         {
            return;
         }
         var _loc3_:Class = getDefinitionByName(CafeModel.wodData.voList[this.bonusDialogProperties.achievementWodId].getVisClassName()) as Class;
         var _loc4_:MovieClip = new _loc3_();
         this.bonusDialog.mc_iconholder.addChild(_loc4_);
      }
      
      private function reposItemHolder(param1:MovieClip) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc2_:int = 10;
         if(param1.numChildren < 4)
         {
            _loc2_ = 20;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            if(_loc4_ = param1.getChildAt(_loc3_) as DisplayObject)
            {
               _loc4_.x += _loc3_ * (this.MAX_WIDTH + _loc2_) - (param1.numChildren - 1) * (this.MAX_WIDTH + _loc2_) / 2;
            }
            _loc3_++;
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.fillItems();
         updateAllTextFields();
      }
      
      protected function get bonusDialogProperties() : CafeAchievementEarnDialogProperties
      {
         return properties as CafeAchievementEarnDialogProperties;
      }
      
      private function get bonusDialog() : CafeAchievementEarn
      {
         return disp as CafeAchievementEarn;
      }
   }
}
