package com.goodgamestudios.cafe.world.vo.coop
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   
   public class BasicCoopVO extends VisualVO
   {
       
      
      public var maxMember:int;
      
      public var maxLevel:int;
      
      public var cash:int;
      
      public var xp:int;
      
      public var gold:int;
      
      public var duration:Number;
      
      public var requirements:Array;
      
      public var finishLevel:int = -1;
      
      public var coopInstanceID:int = -1;
      
      public var runtime:Number;
      
      public var extendCount:int;
      
      public var coopPlayer:Array;
      
      public var events:Array;
      
      public function BasicCoopVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         var _loc5_:Array = null;
         var _loc6_:CoopRequirementVO = null;
         super.fillFromParamXML(param1);
         this.maxMember = parseInt(param1.attribute("maxMember"));
         this.maxLevel = parseInt(param1.attribute("maxLevel"));
         this.cash = parseInt(param1.attribute("chips"));
         this.xp = parseInt(param1.attribute("xp"));
         this.gold = parseInt(param1.attribute("gold"));
         this.duration = parseInt(param1.attribute("duration")) * 60;
         var _loc2_:String = param1.attribute("events");
         this.events = _loc2_.split("+");
         var _loc3_:Array = param1.attribute("dishes").split("#");
         this.requirements = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_].split("+");
            _loc6_ = new CoopRequirementVO(int(_loc5_.shift()),int(_loc5_.shift()));
            this.requirements.push(_loc6_);
            _loc4_++;
         }
      }
      
      private function get timeleft() : Number
      {
         return this.duration + this.extendCount * CafeConstants.coopExpansionHoures * 3600;
      }
      
      public function timeleftBronze() : Number
      {
         return this.timeleft - this.runtime;
      }
      
      public function timeleftSilver() : Number
      {
         return this.timeleft * CafeConstants.coopTimeToSilver - this.runtime;
      }
      
      public function timeleftGold() : Number
      {
         return this.timeleft * CafeConstants.coopTimeToGold - this.runtime;
      }
      
      public function progress() : Number
      {
         var _loc3_:CoopRequirementVO = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in this.requirements)
         {
            _loc4_ = (CafeModel.wodData.voList[_loc3_.dishWodId] as BasicDishVO).baseServings;
            _loc1_ += _loc4_ * _loc3_.amountRequired;
            _loc2_ += _loc4_ * _loc3_.amountDone;
         }
         return _loc2_ / _loc1_;
      }
      
      public function rewardCash(param1:int) : int
      {
         return this.cash * CafeConstants.coopRewardFactors[param1];
      }
      
      public function rewardGold(param1:int) : int
      {
         if(param1 == 0 && CafeModel.userData.userLevel <= this.maxLevel)
         {
            return this.gold;
         }
         return 0;
      }
      
      public function rewardXP(param1:int) : int
      {
         var _loc2_:int = CafeModel.userData.userLevel;
         var _loc3_:Number = CafeConstants.coopRewardFactors[param1];
         return this.xp * (_loc2_ / 3) * _loc3_;
      }
      
      public function isSpecialEvent() : Boolean
      {
         var _loc1_:int = 0;
         for each(_loc1_ in this.events)
         {
            if(_loc1_ != 0)
            {
               return true;
            }
         }
         return false;
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
