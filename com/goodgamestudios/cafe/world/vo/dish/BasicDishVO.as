package com.goodgamestudios.cafe.world.vo.dish
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.utils.Dictionary;
   
   public class BasicDishVO extends VisualVO
   {
      
      public static const GFX_FRAME_PREPARE:int = 1;
      
      public static const GFX_FRAME_COOKFIRSTHALF:int = 2;
      
      public static const GFX_FRAME_COOKSECONDHALF:int = 3;
      
      public static const GFX_FRAME_READY:int = 4;
      
      public static const GFX_FRAME_ROTTEN:int = 5;
      
      public static const GFX_FRAME_EATHALF:int = 6;
      
      public static const GFX_FRAME_EATFULL:int = 7;
       
      
      private const MIN_FANCY_SUBTRAHEND:int = 0;
      
      private const MAX_FANCY_SUBTRAHEND:int = 19;
      
      private var _baseXp:int;
      
      private var _baseServings:int;
      
      private var _baseDuration:int;
      
      private var _fancy:Boolean;
      
      public var dishcategory:int = 0;
      
      public var isPremium:Boolean = false;
      
      public var incomePerServing:int;
      
      public var masteryCount:int = 0;
      
      public var level:int;
      
      public var requirements:Array;
      
      public var amount:int;
      
      public var fancyRequirement:RequirementVO;
      
      public var events:Array;
      
      public function BasicDishVO()
      {
         super();
      }
      
      public function checkFancyRequirements(param1:Dictionary) : void
      {
         var _loc4_:RequirementVO = null;
         var _loc5_:BasicIngredientVO = null;
         this.isPremium = false;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.requirements.length)
         {
            _loc4_ = this.requirements[_loc3_];
            if((_loc5_ = param1[_loc4_.wodId] as BasicIngredientVO).itemGold > 0)
            {
               this.isPremium = true;
            }
            if(_loc5_.category == "fancy")
            {
               this.fancyRequirement = _loc4_;
            }
            else
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         this.requirements = _loc2_;
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         var _loc5_:Array = null;
         var _loc6_:RequirementVO = null;
         super.fillFromParamXML(param1);
         this._fancy = false;
         this._baseXp = parseInt(param1.attribute("xp"));
         this._baseServings = parseInt(param1.attribute("servings"));
         this._baseDuration = parseInt(param1.attribute("duration"));
         this.incomePerServing = parseInt(param1.attribute("incomePerServing"));
         this.level = parseInt(param1.attribute("level"));
         this.dishcategory = parseInt(param1.attribute("dishcategory"));
         var _loc2_:String = param1.attribute("events");
         this.events = _loc2_.split("+");
         var _loc3_:Array = param1.attribute("requirements").split("#");
         this.requirements = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_].split("+");
            _loc6_ = new RequirementVO(int(_loc5_.shift()),int(_loc5_.shift()));
            this.requirements.push(_loc6_);
            _loc4_++;
         }
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
         if(this._fancy)
         {
            return this.getMasterdServings() + this.getFancyServingAmount();
         }
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
      
      public function getFancyServingAmount() : int
      {
         var _loc1_:int = Math.max(this.MIN_FANCY_SUBTRAHEND,Math.min(this.MAX_FANCY_SUBTRAHEND,int(this.getDuration() / 60 / 3)));
         return this.getMasterdServings() * (CafeConstants.fancyFactorServings - _loc1_) / 100;
      }
      
      public function set fancy(param1:Boolean) : void
      {
         this._fancy = param1;
      }
      
      public function get fancy() : Boolean
      {
         return this._fancy;
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
         if(this._fancy)
         {
            return this.getMasterdXp() + this.getFancyXpAmount();
         }
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
      
      public function getFancyXpAmount() : int
      {
         var _loc1_:int = Math.max(this.MIN_FANCY_SUBTRAHEND,Math.min(this.MAX_FANCY_SUBTRAHEND,int(this.getDuration() / 60 / 3)));
         return this.getMasterdXp() * (CafeConstants.fancyFactorXp - _loc1_) / 100;
      }
      
      public function get rottenDuration() : int
      {
         return Math.max(CafeConstants.MIN_DISH_READY_TIME,this._baseDuration);
      }
      
      public function set rottenDuration(param1:int) : void
      {
      }
      
      public function get baseDuration() : int
      {
         return this._baseDuration;
      }
      
      public function set baseDuration(param1:int) : void
      {
         this._baseDuration = param1;
      }
      
      public function getDuration() : int
      {
         return Math.floor(this._baseDuration * CafeModel.masteryData.getCurrentMasteryBonusTime(wodId));
      }
      
      public function getMasteryTimeAmount() : int
      {
         return this.getDuration() - this._baseDuration;
      }
      
      override public function isItemAvalibleByEvent() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(_loc1_ in this.events)
         {
            for each(_loc2_ in CafeModel.sessionData.currentEvents)
            {
               if(_loc1_ == _loc2_)
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}
