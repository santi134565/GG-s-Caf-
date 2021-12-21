package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.counter.BasicCounterVO;
   import com.goodgamestudios.cafe.world.vo.currency.CurrencyVO;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcwaiterMovingVO;
   import com.goodgamestudios.cafe.world.vo.stove.BasicStoveVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeLevelUpDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeLevelupPanel";
      
      public static const BONUSELEMENT_WIDTH:int = 70;
      
      public static const BONUSELEMENT_HEIGHT:int = 60;
       
      
      public function CafeLevelUpDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         this.buildLevelUpWindow();
      }
      
      private function buildLevelUpWindow() : void
      {
         this.lvlUpDialog.gotoAndStop(this.lvlUpProperties.frameNr);
         this.lvlUpDialog.txt_description.text = "";
         this.lvlUpDialog.btn_ok.label = CafeModel.languageData.getTextById("generic_btn_okay");
         var _loc1_:int = 0;
         _loc1_ = this.fillPrizes(_loc1_);
         _loc1_ = this.fillDishes(_loc1_);
         _loc1_ = this.fillFeatures(_loc1_);
      }
      
      private function fillPrizes(param1:int) : int
      {
         var _loc2_:Lvlup_prizes = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:CurrencyVO = null;
         var _loc6_:DisplayObject = null;
         if(this.lvlUpProperties.prizes && this.lvlUpProperties.prizes.length > 0)
         {
            _loc2_ = new Lvlup_prizes();
            _loc2_.txt_unlocked.text = CafeModel.languageData.getTextById("dialogwin_levelup_copy_1");
            _loc3_ = this.lvlUpProperties.prizes.length;
            _loc4_ = 0;
            for each(_loc5_ in this.lvlUpProperties.prizes)
            {
               (_loc6_ = this.createBonusMovieClip(_loc5_)).y = 30;
               _loc6_.x = _loc2_.txt_unlocked.width / 1.7 + BONUSELEMENT_WIDTH * 1.5 * _loc4_ - _loc3_ / 2 * (BONUSELEMENT_WIDTH * 1.5);
               _loc6_.scaleX = _loc6_.scaleY = _loc6_.scaleX - 0.2;
               _loc2_.addChild(_loc6_);
               _loc4_++;
            }
            param1++;
            this.lvlUpDialog["category_" + param1].addChild(_loc2_);
         }
         return param1;
      }
      
      private function fillDishes(param1:int) : int
      {
         var _loc2_:Lvlup_newDishes = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BasicDishVO = null;
         var _loc6_:DisplayObject = null;
         if(this.lvlUpProperties.dishes && this.lvlUpProperties.dishes.length > 0)
         {
            _loc2_ = new Lvlup_newDishes();
            _loc2_.txt_unlocked.text = CafeModel.languageData.getTextById("dialogwin_bonus_title_dish");
            _loc3_ = this.lvlUpProperties.dishes.length;
            _loc4_ = 0;
            for each(_loc5_ in this.lvlUpProperties.dishes)
            {
               (_loc6_ = this.createBonusMovieClip(_loc5_)).y = 35;
               _loc6_.x = _loc2_.txt_unlocked.width / 1.7 + BONUSELEMENT_WIDTH * 1.3 * _loc4_ - _loc3_ / 2 * (BONUSELEMENT_WIDTH * 1.3);
               _loc2_.addChild(_loc6_);
               _loc4_++;
            }
            param1++;
            this.lvlUpDialog["category_" + param1].addChild(_loc2_);
         }
         return param1;
      }
      
      private function fillFeatures(param1:int) : int
      {
         var _loc2_:Lvlup_newFeatures = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:VisualVO = null;
         var _loc6_:DisplayObject = null;
         if(this.lvlUpProperties.functionals && this.lvlUpProperties.functionals.length > 0)
         {
            _loc2_ = new Lvlup_newFeatures();
            _loc2_.txt_unlocked.text = CafeModel.languageData.getTextById("dialogwin_levelup_copy_2");
            _loc3_ = this.lvlUpProperties.functionals.length;
            _loc4_ = 0;
            for each(_loc5_ in this.lvlUpProperties.functionals)
            {
               (_loc6_ = this.createBonusMovieClip(_loc5_)).y = 30;
               _loc6_.x = _loc2_.txt_unlocked.width / 1.7 + BONUSELEMENT_WIDTH * 1.3 * _loc4_ - _loc3_ / 2 * (BONUSELEMENT_WIDTH * 1.3);
               _loc2_.addChild(_loc6_);
            }
            param1++;
            this.lvlUpDialog["category_" + param1].addChild(_loc2_);
         }
         return param1;
      }
      
      private function createBonusMovieClip(param1:VisualVO) : DisplayObject
      {
         var _loc2_:LevelUpElement = new LevelUpElement();
         _loc2_.mouseChildren = false;
         _loc2_.txt_amount.text = "";
         var _loc3_:Class = getDefinitionByName(param1.getVisClassName()) as Class;
         var _loc4_:DisplayObject = new _loc3_();
         if(param1 is BasicDishVO)
         {
            (_loc4_ as MovieClip).gotoAndStop(BasicDishVO.GFX_FRAME_READY);
         }
         else
         {
            (_loc4_ as MovieClip).stop();
         }
         var _loc5_:Rectangle = _loc4_.getBounds(null);
         var _loc6_:Number = BONUSELEMENT_WIDTH / _loc5_.width;
         if(_loc5_.height * _loc6_ > BONUSELEMENT_HEIGHT)
         {
            _loc6_ = BONUSELEMENT_HEIGHT / _loc5_.height;
         }
         _loc4_.scaleX = _loc4_.scaleY = _loc6_;
         if(param1 is CurrencyVO && (param1 as CurrencyVO).amount > 0)
         {
            _loc2_.txt_amount.text = "x" + (param1 as CurrencyVO).amount;
         }
         if(param1 is BasicDishVO)
         {
            _loc4_.scaleX = _loc4_.scaleY = 1.3;
            _loc4_.x = -(CafeConstants.ISOTILESIZE_X / 1.5);
            _loc4_.y = -(CafeConstants.ISOTILESIZE_Y / 2);
            _loc2_.toolTipText = CafeModel.languageData.getTextById("recipe_" + param1.type.toLocaleLowerCase());
         }
         if(param1 is NpcwaiterMovingVO)
         {
            _loc2_.toolTipText = CafeModel.languageData.getTextById("dialogwin_bonus_title_waiter");
         }
         if(param1 is BasicStoveVO)
         {
            _loc4_.x = -(_loc4_.width / 2);
            _loc2_.toolTipText = CafeModel.languageData.getTextById("dialogwin_bonus_title_stove");
         }
         if(param1 is BasicFridgeVO)
         {
            _loc4_.x = -(_loc4_.width / 2);
            _loc2_.toolTipText = CafeModel.languageData.getTextById("dialogwin_bonus_title_fridge");
         }
         if(param1 is BasicCounterVO)
         {
            _loc4_.x = -(_loc4_.width / 2);
            _loc2_.toolTipText = CafeModel.languageData.getTextById("dialogwin_bonus_title_counter");
         }
         _loc2_.scaleX = _loc2_.scaleY = 1.15;
         _loc2_.mc_holder.addChild(_loc4_);
         return _loc2_;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.lvlUpDialog.btn_ok:
               hide();
               destroy();
         }
      }
      
      protected function get lvlUpDialog() : CafeLevelUp
      {
         return disp as CafeLevelUp;
      }
      
      private function get lvlUpProperties() : CafeLevelUpDialogProperties
      {
         return properties as CafeLevelUpDialogProperties;
      }
   }
}
