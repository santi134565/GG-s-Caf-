package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeAchievementEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.achievement.BasicAchievementVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeAchievementDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeAchievementDialog";
       
      
      private var currentPage:int = 0;
      
      private var maxPage:int = 0;
      
      private var MAX_WIDTH:int = 100;
      
      private var MAX_HEIGHT:int = 80;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeAchievementDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         controller.addEventListener(CafeAchievementEvent.CHANGE_AMOUNT,this.onAmountChanged);
         super.init();
      }
      
      override protected function applyProperties() : void
      {
         controller.sendServerMessageAndWait(SFConstants.C2S_CAFE_ACHIEVEMENT_LIST,[this.achievementDialogProperties.playerID,this.achievementDialogProperties.userID],SFConstants.S2C_CAFE_ACHIEVEMENT_LIST);
         this.achievementDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_achievement_title");
         super.applyProperties();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeAchievementEvent.CHANGE_AMOUNT,this.onAmountChanged);
      }
      
      private function clearLayoutManager(param1:LanguageDataEvent) : void
      {
         updateAllTextFields();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.achievementDialog.mc_arrow_left:
            case this.achievementDialog.mc_arrow_right:
               this.onClickArrow(param1);
               break;
            case this.achievementDialog.btn_cancel:
               hide();
         }
      }
      
      private function onAmountChanged(param1:CafeAchievementEvent) : void
      {
         this.fillItems();
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_CAFE_ACHIEVEMENT_LIST)
         {
            this.isWaitingForServerMessage = false;
            this.fillItems();
         }
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this.currentPage;
         if(param1.target == this.achievementDialog.mc_arrow_left)
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
         this.maxPage = (param1 - 1) / this.achievementDialogProperties.itemsPerPage;
         this.achievementDialog.mc_arrow_right.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.achievementDialog.mc_arrow_left.visible = this.maxPage > 0 && this.currentPage > 0;
      }
      
      private function fillItems() : void
      {
         var _loc5_:int = 0;
         var _loc6_:AchievementItem = null;
         var _loc7_:BasicAchievementVO = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:Class = null;
         var _loc12_:MovieClip = null;
         var _loc13_:Rectangle = null;
         var _loc1_:Number = 0;
         var _loc2_:int = this.currentPage * this.achievementDialogProperties.itemsPerPage;
         var _loc3_:Array = CafeModel.achievementData.achievementArray;
         this.initArrows(_loc3_.length);
         var _loc4_:int = _loc2_;
         while(_loc4_ < _loc2_ + this.achievementDialogProperties.itemsPerPage)
         {
            _loc5_ = _loc4_ - _loc2_;
            _loc6_ = this.achievementDialog["i" + _loc5_] as AchievementItem;
            if(_loc4_ < _loc3_.length)
            {
               _loc7_ = _loc3_[_loc4_];
               _loc6_.mouseChildren = false;
               _loc6_.txt_name.text = CafeModel.languageData.getTextById(_loc7_.getVisClassName());
               _loc8_ = CafeModel.achievementData.getLevelByAmount(_loc7_.achievementId);
               _loc6_.txt_level.text = String(_loc8_);
               if((_loc10_ = CafeModel.achievementData.getNextLevelCount(_loc7_,_loc8_)) > _loc7_.amount)
               {
                  _loc9_ = CafeModel.languageData.getTextById("tt_byAmount",[NumberStringHelper.groupString(_loc7_.amount,CafeModel.languageData.getTextById),NumberStringHelper.groupString(_loc10_,CafeModel.languageData.getTextById)]);
               }
               else
               {
                  _loc9_ = NumberStringHelper.groupString(_loc7_.amount,CafeModel.languageData.getTextById);
               }
               _loc6_.txt_amount.text = _loc9_;
               _loc6_.mc_progress.mc_bar.scaleX = CafeModel.achievementData.getAmountToNextLevelInPercent(_loc7_,_loc8_);
               _loc6_.toolTipText = CafeModel.languageData.getTextById("tt_" + _loc7_.getVisClassName());
               _loc13_ = (_loc12_ = new (_loc11_ = getDefinitionByName(_loc7_.getVisClassName()) as Class)()).getBounds(null);
               _loc1_ = this.MAX_WIDTH / _loc13_.width;
               if(_loc13_.height * _loc1_ > this.MAX_HEIGHT)
               {
                  _loc1_ = this.MAX_HEIGHT / _loc13_.height;
               }
               _loc12_.scaleX = _loc12_.scaleY = _loc1_;
               _loc12_.x = -(_loc13_.width * _loc1_ / 2 + _loc13_.left * _loc1_);
               _loc12_.y = -(_loc13_.height * _loc1_ / 2 + _loc13_.top * _loc1_);
               while(_loc6_.mc_achievementholder.numChildren > 0)
               {
                  _loc6_.mc_achievementholder.removeChildAt(0);
               }
               _loc6_.mc_achievementholder.addChild(_loc12_);
               if(this.isWaitingForServerMessage)
               {
                  _loc6_.mc_achievementholder.addChild(new ServerWaitingAnim());
               }
               _loc6_.visible = true;
            }
            else
            {
               _loc6_.visible = false;
            }
            _loc4_++;
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.currentPage = 0;
         this.isWaitingForServerMessage = true;
         this.fillItems();
      }
      
      protected function get achievementDialogProperties() : CafeAchievementDialogProperties
      {
         return properties as CafeAchievementDialogProperties;
      }
      
      private function get achievementDialog() : AchievementDialog
      {
         return disp as AchievementDialog;
      }
   }
}
