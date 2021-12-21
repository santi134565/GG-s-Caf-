package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeSocialData;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeBonusDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeBonusDialog";
       
      
      private const MAX_WIDTH:int = 70;
      
      private const MAX_HEIGHT:int = 70;
      
      private const MAX_TEXTICONHEIGHT:int = 50;
      
      private const FRAME_STANDARD:int = 1;
      
      private const FRAME_LEVELUP:int = 2;
      
      private const FRAME_LOGINBONUS:int = 3;
      
      private const FRAME_MUFFIN:int = 4;
      
      private const FRAME_BIG:int = 5;
      
      private const FRAME_LOGINBONUS_WITH_WHEELOFFORTUNE:int = 6;
      
      private const FRAME_WOF:int = 7;
      
      public function CafeBonusDialog(param1:Sprite)
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
         this.bonusDialog.btn_playWheelOfFortune.label = CafeModel.languageData.getTextById("dialogwin_wheeloffortune_btn_go");
         var _loc1_:Boolean = env.enableFeedMessages && this.bonusDialogProperties.type < 10;
         if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_FIND_FILLING || this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_WHEELOFFORTUNE)
         {
            _loc1_ = false;
         }
         this.bonusDialog.btn_share.visible = _loc1_;
         this.bonusDialog.btn_cancle.visible = _loc1_;
         this.bonusDialog.btn_ok.visible = !_loc1_;
         this.bonusDialog.btn_playWheelOfFortune.visible = this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_LOGINBONUS;
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
            case this.bonusDialog.btn_playWheelOfFortune:
               hide();
               layoutManager.showDialog(CafeWheelOfFortuneDialog.NAME,new CafeWheelOfFortuneDialogProperties(!CafeModel.userData.playedWheelOfFortune,0));
               break;
            case this.bonusDialog.btn_share:
               hide();
               switch(this.bonusDialogProperties.type)
               {
                  case CafeBonusDialogProperties.TYPE_LEVELUP:
                     CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_LEVELUP,this.bonusDialogProperties.feedparams);
                     break;
                  case CafeBonusDialogProperties.TYPE_EXPAND:
                     CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_EXPAND);
                     break;
                  case CafeBonusDialogProperties.TYPE_ACHIEVEMENT:
                     _loc2_ = this.bonusDialogProperties.bonuselements[0];
                     if(_loc2_)
                     {
                        CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_ACHIEVEMENT,this.bonusDialogProperties.feedparams);
                     }
                     break;
                  case CafeBonusDialogProperties.TYPE_WAITER:
                     CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_WAITER,this.bonusDialogProperties.feedparams);
                     break;
                  case CafeBonusDialogProperties.TYPE_PERFECTDISH:
                     CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_PERFECTDISH,this.bonusDialogProperties.feedparams);
                     break;
                  case CafeBonusDialogProperties.TYPE_FIND_TIP:
                     CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_FIND_TIP,this.bonusDialogProperties.feedparams);
                     break;
                  case CafeBonusDialogProperties.TYPE_FIND_INGREDIENT:
                     CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_FIND_INGREDIENT,this.bonusDialogProperties.feedparams);
               }
         }
      }
      
      private function setBackgroundFrame() : void
      {
         this.bonusDialog.txt_title.y = this.bonusDialog.mc_iconholder.y;
         this.bonusDialog.txt_title.text = this.bonusDialogProperties.title;
         this.bonusDialog.txt_copy.text = this.bonusDialogProperties.copy;
         switch(this.bonusDialogProperties.type)
         {
            case CafeBonusDialogProperties.TYPE_LEVELUP:
               this.bonusDialog.gotoAndStop(this.FRAME_LEVELUP);
               break;
            case CafeBonusDialogProperties.TYPE_FIND_FILLING:
               this.bonusDialog.gotoAndStop(this.FRAME_MUFFIN);
               break;
            case CafeBonusDialogProperties.TYPE_WHEELOFFORTUNE:
               this.bonusDialog.gotoAndStop(this.FRAME_WOF);
               break;
            case CafeBonusDialogProperties.TYPE_LOGINBONUS_WO_WOF:
               this.bonusDialog.gotoAndStop(this.FRAME_LOGINBONUS);
               this.bonusDialog.txt_title.y += 50;
               break;
            case CafeBonusDialogProperties.TYPE_LOGINBONUS:
               this.bonusDialog.gotoAndStop(this.FRAME_LOGINBONUS_WITH_WHEELOFFORTUNE);
               this.bonusDialog.txt_wheelOfFortune.text = CafeModel.languageData.getTextById("dialogwin_wheeloffortune_copy1");
               this.bonusDialog.txt_title.y += 10;
               break;
            case CafeBonusDialogProperties.TYPE_FIND_TIP:
            case CafeBonusDialogProperties.TYPE_FIND_INGREDIENT:
            case CafeBonusDialogProperties.TYPE_PERFECTDISH:
               this.bonusDialog.gotoAndStop(this.FRAME_BIG);
               break;
            default:
               this.bonusDialog.gotoAndStop(this.FRAME_STANDARD);
         }
         this.bonusDialog.txt_title.text = this.bonusDialogProperties.title;
         this.bonusDialog.txt_copy.text = this.bonusDialogProperties.copy;
         this.bonusDialog.txt_copy.y = this.bonusDialog.txt_title.y + this.bonusDialog.txt_title.height - 10;
         this.bonusDialog.mc_achievementholder.y = this.bonusDialog.txt_copy.y + this.bonusDialog.txt_copy.height + 10;
         this.bonusDialog.btn_cancle.y = this.bonusDialog.btn_share.y = this.bonusDialog.btn_playWheelOfFortune.y = this.bonusDialog.btn_ok.y = this.bonusDialog.mc_achievementholder.y + 100;
         if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_ACHIEVEMENT)
         {
            this.bonusDialog.btn_cancle.y = this.bonusDialog.btn_share.y = this.bonusDialog.btn_playWheelOfFortune.y = this.bonusDialog.btn_ok.y = this.bonusDialog.mc_achievementholder.y + 130;
         }
         if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_FIND_FILLING || this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_WHEELOFFORTUNE || this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_FIND_TIP || this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_FIND_INGREDIENT || this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_PERFECTDISH)
         {
            this.bonusDialog.txt_copy.y = this.bonusDialog.txt_title.y + this.bonusDialog.txt_title.height + 5;
            this.bonusDialog.btn_cancle.y = this.bonusDialog.btn_share.y = this.bonusDialog.btn_ok.y = this.bonusDialog.btn_ok.y + 60;
         }
         this.bonusDialog.txt_copy.mouseEnabled = this.bonusDialog.txt_title.mouseEnabled = false;
         if(this.bonusDialog.currentFrame == this.FRAME_LOGINBONUS_WITH_WHEELOFFORTUNE)
         {
            this.bonusDialog.btn_ok.x -= 100;
            this.bonusDialog.txt_copy.y = this.bonusDialog.txt_title.y + this.bonusDialog.txt_title.height - 30;
            this.bonusDialog.mc_achievementholder.y = this.bonusDialog.txt_copy.y + this.bonusDialog.txt_copy.height + 10;
            this.bonusDialog.txt_wheelOfFortune.y = this.bonusDialog.mc_achievementholder.y + this.bonusDialog.mc_achievementholder.height + 55;
            this.bonusDialog.mc_wheelOfFortune.y = this.bonusDialog.txt_wheelOfFortune.y + 40;
            this.bonusDialog.btn_cancle.y = this.bonusDialog.btn_share.y = this.bonusDialog.btn_playWheelOfFortune.y = this.bonusDialog.btn_ok.y = this.bonusDialog.mc_wheelOfFortune.y + this.bonusDialog.mc_wheelOfFortune.height + 15;
         }
      }
      
      private function fillItems() : void
      {
         var _loc2_:VisualVO = null;
         var _loc5_:CafeBonusElement = null;
         var _loc6_:Class = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc9_:Rectangle = null;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:Number = NaN;
         this.setBackgroundFrame();
         var _loc1_:Number = 0;
         for each(_loc2_ in this.bonusDialogProperties.bonuselements)
         {
            if(!(!_loc2_.isItemAvalibleByEvent() && !(_loc2_ is ShopVO && (_loc2_ as ShopVO).events[0] == "4")))
            {
               if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_PERFECTDISH)
               {
                  this.bonusDialogProperties.feedparams.push(CafeModel.languageData.getTextById("recipe_" + _loc2_.type.toLowerCase()));
               }
               (_loc5_ = new CafeBonusElement()).mouseChildren = false;
               if((_loc7_ = new (_loc6_ = getDefinitionByName(CafeModel.wodData.voList[_loc2_.wodId].getVisClassName()) as Class)()) is MovieClip)
               {
                  (_loc7_ as MovieClip).gotoAndStop(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_NEWELEMENTS ? BasicDishVO.GFX_FRAME_READY : 1);
               }
               _loc8_ = this.MAX_HEIGHT;
               if(_loc2_.hasOwnProperty("amount") && _loc2_["amount"] > 0)
               {
                  _loc8_ = this.MAX_TEXTICONHEIGHT;
                  _loc5_.txt_value.text = "x " + NumberStringHelper.groupString(_loc2_["amount"],CafeModel.languageData.getTextById);
                  _loc5_.txt_value.width = _loc5_.txt_value.textWidth + 5;
                  _loc5_.txt_value.x = -(_loc5_.txt_value.width / 2);
                  _loc5_.txt_value.y = this.MAX_HEIGHT / 2 - 10;
                  _loc5_.txt_value.visible = true;
               }
               else if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_WHEELOFFORTUNE && _loc2_.hasOwnProperty("itemAmount") && _loc2_["itemAmount"] > 0)
               {
                  _loc8_ = this.MAX_TEXTICONHEIGHT;
                  _loc5_.txt_value.text = "x " + NumberStringHelper.groupString(_loc2_["itemAmount"],CafeModel.languageData.getTextById);
                  _loc5_.txt_value.width = _loc5_.txt_value.textWidth + 5;
                  _loc5_.txt_value.x = -(_loc5_.txt_value.width / 2);
                  _loc5_.txt_value.y = this.MAX_HEIGHT / 2 - 10;
                  _loc5_.txt_value.visible = true;
               }
               else
               {
                  _loc5_.txt_value.visible = false;
               }
               _loc9_ = _loc7_.getBounds(null);
               _loc1_ = this.MAX_WIDTH / _loc9_.width;
               if(_loc9_.height * _loc1_ > _loc8_)
               {
                  _loc1_ = _loc8_ / _loc9_.height;
               }
               _loc7_.scaleX = _loc7_.scaleY = _loc1_;
               if(_loc2_.group == CafeConstants.GROUP_DISH)
               {
                  (_loc7_ as MovieClip).gotoAndStop(BasicDishVO.GFX_FRAME_READY);
                  _loc10_ = CafeModel.languageData.getTextById("recipe_" + _loc2_.type.toLocaleLowerCase());
               }
               else if(_loc2_.group == CafeConstants.GROUP_INGREDIENT)
               {
                  _loc10_ = CafeModel.languageData.getTextById("ingredient_" + _loc2_.type.toLocaleLowerCase());
               }
               else
               {
                  (_loc7_ as MovieClip).gotoAndStop(1);
                  _loc10_ = CafeModel.languageData.getTextById("tt_" + _loc2_.getVisClassName());
               }
               if(_loc10_.length > 0)
               {
                  _loc5_.toolTipText = _loc10_;
                  _loc5_.mouseChildren = false;
               }
               _loc7_.x = -(_loc9_.width * _loc1_ / 2 + _loc9_.left * _loc1_);
               if(_loc5_.txt_value.visible)
               {
                  _loc7_.y = -(_loc9_.height * _loc1_ / 2 + _loc9_.top * _loc1_ + 10);
               }
               else
               {
                  _loc7_.y = -(_loc9_.height * _loc1_ / 2 + _loc9_.top * _loc1_);
               }
               if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_ACHIEVEMENT)
               {
                  _loc5_.y -= 25;
               }
               if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_PERFECTDISH || this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_FIND_TIP || this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_FIND_INGREDIENT)
               {
                  _loc5_.y += 70;
               }
               if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_WHEELOFFORTUNE)
               {
                  _loc5_.y += 30;
               }
               while(_loc5_.mc_holder.numChildren > 0)
               {
                  _loc5_.mc_holder.removeChildAt(0);
               }
               _loc5_.mc_holder.addChild(_loc7_);
               this.bonusDialog.mc_achievementholder.addChild(_loc5_);
               if(this.bonusDialogProperties.type == CafeBonusDialogProperties.TYPE_WHEELOFFORTUNE)
               {
                  this.bonusDialog.mc_achievementholder.scaleX = this.bonusDialog.mc_achievementholder.scaleY = 1.5;
                  _loc11_ = 425;
                  if(this.bonusDialog.mc_achievementholder.width > _loc11_)
                  {
                     _loc12_ = _loc11_ / this.bonusDialog.mc_achievementholder.width;
                     this.bonusDialog.mc_achievementholder.scaleX = this.bonusDialog.mc_achievementholder.scaleY = _loc12_;
                  }
               }
            }
         }
         this.reposItemHolder(this.bonusDialog.mc_achievementholder);
         if(this.bonusDialogProperties.iconWodId < 0)
         {
            return;
         }
         var _loc3_:Class = getDefinitionByName(CafeModel.wodData.voList[this.bonusDialogProperties.iconWodId].getVisClassName()) as Class;
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
      
      protected function get bonusDialogProperties() : CafeBonusDialogProperties
      {
         return properties as CafeBonusDialogProperties;
      }
      
      private function get bonusDialog() : CafeBonus
      {
         return disp as CafeBonus;
      }
   }
}
