package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeMasteryInfoDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeMasteryInfoDialog";
       
      
      public function CafeMasteryInfoDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:BasicDishVO = CafeModel.wodData.voList[this.masteryInfoDialogProperties.wodId] as BasicDishVO;
         var _loc2_:int = CafeModel.masteryData.getMasteryLevel(_loc1_.wodId);
         var _loc3_:int = 1;
         while(_loc3_ < 4)
         {
            this.masteryInfoDialog["m" + _loc3_].gotoAndStop(_loc2_ >= _loc3_ ? 2 : 1);
            this.masteryInfoDialog["i" + _loc3_].gotoAndStop(2);
            _loc3_++;
         }
         this.masteryInfoDialog.m1.toolTipText = CafeModel.languageData.getTextById("tt_CafeMasteryDialog_broncestar");
         this.masteryInfoDialog.m2.toolTipText = CafeModel.languageData.getTextById("tt_CafeMasteryDialog_silverstar");
         this.masteryInfoDialog.m3.toolTipText = CafeModel.languageData.getTextById("tt_CafeMasteryDialog_goldstar");
         this.addDishPic(_loc1_);
         this.masteryInfoDialog.txt_dishname.text = CafeModel.languageData.getTextById("recipe_" + _loc1_.type.toLowerCase());
         this.masteryInfoDialog.txt_hint.text = CafeModel.languageData.getTextById("dialogwin_dishmastery_info");
         this.masteryInfoDialog.txt_servings.text = CafeModel.languageData.getTextById("dialogwin_cookbook_servings",[_loc1_.baseServings]);
         this.masteryInfoDialog.txt_servingsMod.text = "+ " + String(Math.ceil(_loc1_.baseServings * CafeConstants.masteryBonusServing) - _loc1_.baseServings);
         this.masteryInfoDialog.txt_xp.text = CafeModel.languageData.getTextById("xp") + ": " + String(_loc1_.baseXP);
         this.masteryInfoDialog.txt_xpMod.text = "+ " + String(Math.ceil(_loc1_.baseXP * CafeConstants.masteryBonusXP) - _loc1_.baseXP);
         this.masteryInfoDialog.txt_time.text = CafeModel.languageData.getTextById("dialogwin_cookbook_readyin",[TimeStringHelper.getShortTimeStringByMinutes(_loc1_.baseDuration)]);
         var _loc4_:Number = Math.abs(_loc1_.baseDuration - Math.floor(_loc1_.baseDuration * CafeConstants.masteryBonusTime));
         if(_loc1_.baseDuration - _loc4_ <= CafeConstants.MIN_COOKING_TIME)
         {
            _loc4_ -= CafeConstants.MIN_COOKING_TIME;
         }
         this.masteryInfoDialog.txt_timeMod.text = "- " + TimeStringHelper.getShortTimeStringByMinutes(_loc4_);
         this.masteryInfoDialog.txt_currentLevel.text = CafeModel.languageData.getTextById("mastery") + " : " + _loc2_;
         if(_loc2_ < 3)
         {
            _loc5_ = CafeModel.masteryData.getCountTilLevel(_loc1_.wodId,_loc2_ + 1);
            _loc7_ = (_loc6_ = CafeModel.masteryData.getNextLevelRange(_loc1_.wodId,_loc2_)) - _loc5_;
            this.masteryInfoDialog.txt_progress.text = CafeModel.languageData.getTextById("XofY",[_loc7_,_loc6_]);
            this.masteryInfoDialog.progress.visible = true;
            this.masteryInfoDialog.progress.progressBarStatus.scaleX = _loc7_ / _loc6_;
         }
         else
         {
            this.masteryInfoDialog.txt_progress.text = "";
            this.masteryInfoDialog.progress.visible = false;
         }
      }
      
      private function addDishPic(param1:BasicDishVO) : void
      {
         var _loc2_:Class = getDefinitionByName(param1.getVisClassName()) as Class;
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.gotoAndStop(BasicDishVO.GFX_FRAME_READY);
         var _loc4_:Rectangle = _loc3_.getBounds(null);
         _loc3_.x = -(_loc4_.width / 2 + _loc4_.left);
         _loc3_.y = -(_loc4_.height / 2 + _loc4_.top);
         while(this.masteryInfoDialog.mc_recipeContainer.numChildren > 0)
         {
            this.masteryInfoDialog.mc_recipeContainer.removeChildAt(0);
         }
         this.masteryInfoDialog.mc_recipeContainer.addChild(_loc3_);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.masteryInfoDialog.btn_close:
               hide();
         }
      }
      
      protected function get masteryInfoDialogProperties() : CafeMasteryInfoDialogProperties
      {
         return properties as CafeMasteryInfoDialogProperties;
      }
      
      protected function get masteryInfoDialog() : CafeMasteryInfo
      {
         return disp as CafeMasteryInfo;
      }
   }
}
