package com.goodgamestudios.cafe.world.vo.fastfood
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   
   public class BasicFastfoodVO extends ShopVO
   {
       
      
      private var _baseXp:int;
      
      private var _baseServings:int;
      
      private var _baseRating:int;
      
      private var _baseCash:int;
      
      public var isPremium:Boolean = false;
      
      public var color:uint;
      
      public function BasicFastfoodVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         this._baseServings = parseInt(param1.attribute("servings"));
         this._baseXp = parseInt(param1.attribute("xp"));
         this._baseRating = parseInt(param1.attribute("ratingBonus"));
         this._baseCash = parseInt(param1.attribute("incomePerServing"));
         this.color = uint("0x" + param1.attribute("color"));
         this.isPremium = itemGold > 0;
      }
      
      public function get baseServings() : int
      {
         return this._baseServings;
      }
      
      public function set baseServings(param1:int) : void
      {
         this._baseServings = param1;
      }
      
      public function getServings() : int
      {
         return this.getMasterdServings();
      }
      
      public function getMasterdServings() : int
      {
         return Math.ceil(this._baseServings * CafeModel.masteryData.getCurrentMasteryBonusServing(wodId));
      }
      
      public function getMasteryServingAmount() : int
      {
         return this.getMasterdServings() - this._baseServings;
      }
      
      public function get baseXP() : int
      {
         return this._baseXp;
      }
      
      public function set baseXP(param1:int) : void
      {
         this._baseXp = param1;
      }
      
      public function getXp() : int
      {
         return this.getMasterdXp();
      }
      
      public function getMasterdXp() : int
      {
         return Math.ceil(this._baseXp * CafeModel.masteryData.getCurrentMasteryBonusXP(wodId));
      }
      
      public function getMasteryXPAmount() : int
      {
         return this.getMasterdXp() - this._baseXp;
      }
      
      public function get baseCash() : int
      {
         return this._baseCash;
      }
      
      public function set baseCash(param1:int) : void
      {
         this._baseCash = param1;
      }
      
      public function getCash() : int
      {
         return this.getMasterdCash();
      }
      
      public function getMasterdCash() : int
      {
         return Math.ceil(this._baseCash * CafeModel.masteryData.getCurrentMasteryBonusXP(wodId));
      }
      
      public function getMasteryCashAmount() : int
      {
         return this.getMasterdCash() - this._baseCash;
      }
      
      public function get baseRating() : int
      {
         return this._baseRating;
      }
      
      public function set baseRating(param1:int) : void
      {
         this._baseRating = param1;
      }
      
      public function getRating() : int
      {
         return this.getMasterdRating();
      }
      
      public function getMasterdRating() : int
      {
         return Math.ceil(this._baseRating * CafeModel.masteryData.getCurrentMasteryBonusXP(wodId));
      }
      
      public function getMasteryRatingAmount() : int
      {
         return this.getMasterdRating() - this._baseRating;
      }
   }
}
