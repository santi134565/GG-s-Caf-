package com.goodgamestudios.cafe.model.components
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicAchievementData;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.event.CafeAchievementEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.achievement.AchievementRequirementVO;
   import com.goodgamestudios.cafe.world.vo.achievement.BasicAchievementVO;
   import com.goodgamestudios.cafe.world.vo.achievement.SocialAchievementVO;
   import com.goodgamestudios.cafe.world.vo.currency.CashCurrencyVO;
   import com.goodgamestudios.cafe.world.vo.currency.GoldCurrencyVO;
   import com.goodgamestudios.cafe.world.vo.currency.XpCurrencyVO;
   import flash.utils.Dictionary;
   
   public class CafeAchievementData extends BasicAchievementData
   {
       
      
      private var achievements:Dictionary;
      
      public function CafeAchievementData(param1:XML)
      {
         super(param1);
         this.parseFromXml();
      }
      
      private function parseFromXml() : void
      {
         var _loc2_:XML = null;
         var _loc3_:BasicAchievementVO = null;
         var _loc4_:AchievementRequirementVO = null;
         this.achievements = new Dictionary();
         var _loc1_:XMLList = achievementXML.elements();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = this.getAchievementById(parseInt(_loc2_.attribute("a")),parseInt(_loc2_.attribute("w")));
            _loc3_.amount = 0;
            (_loc4_ = new AchievementRequirementVO()).cash = parseInt(_loc2_.attribute("ch"));
            _loc4_.gold = parseInt(_loc2_.attribute("g"));
            _loc4_.count = parseInt(_loc2_.attribute("r"));
            _loc4_.xp = parseInt(_loc2_.attribute("x"));
            _loc4_.ingredientWodid = -1;
            _loc3_.levelDict[parseInt(_loc2_.attribute("l"))] = _loc4_;
            this.achievements[_loc3_.achievementId] = _loc3_;
         }
      }
      
      public function parseAchievementList(param1:Array) : void
      {
         var _loc2_:Array = null;
         this.resetAllAchievements();
         if(param1[0])
         {
            _loc2_ = param1[0].split("#");
            while(_loc2_.length > 0 && _loc2_[0] != "")
            {
               this.setAmountById(_loc2_.shift().split("+"));
            }
         }
         BasicController.getInstance().dispatchEvent(new CafeAchievementEvent(CafeAchievementEvent.CHANGE_AMOUNT));
      }
      
      private function resetAllAchievements() : void
      {
         var _loc1_:* = null;
         var _loc2_:BasicAchievementVO = null;
         for(_loc1_ in this.achievements)
         {
            _loc2_ = this.achievements[_loc1_];
            _loc2_.amount = 0;
         }
      }
      
      public function get achievementArray() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.achievements)
         {
            if(!(this.achievements[_loc2_] is SocialAchievementVO && !this.env.hasNetworkBuddies))
            {
               _loc1_.push(this.achievements[_loc2_]);
            }
         }
         return _loc1_;
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      public function getAchievementName(param1:int) : String
      {
         var _loc2_:BasicAchievementVO = this.getAchievementById(param1);
         if(_loc2_)
         {
            return _loc2_.getVisClassName();
         }
         return "";
      }
      
      private function getAchievementById(param1:int, param2:int = -1) : BasicAchievementVO
      {
         var _loc3_:BasicAchievementVO = null;
         if(DictionaryUtil.containsKey(this.achievements,param1))
         {
            return this.achievements[param1];
         }
         _loc3_ = CafeModel.wodData.createVObyWOD(param2) as BasicAchievementVO;
         _loc3_.achievementId = param1;
         return _loc3_;
      }
      
      public function getWodIdById(param1:int) : int
      {
         var _loc2_:BasicAchievementVO = this.getAchievementById(param1);
         if(_loc2_)
         {
            return _loc2_.wodId;
         }
         return -1;
      }
      
      private function setAmountById(param1:Array) : void
      {
         var _loc2_:int = param1[0];
         var _loc3_:int = param1[1];
         var _loc4_:BasicAchievementVO;
         (_loc4_ = this.getAchievementById(_loc2_)).amount = _loc3_;
      }
      
      public function getLevelByAmount(param1:int) : int
      {
         var _loc4_:* = null;
         var _loc2_:int = -1;
         var _loc3_:BasicAchievementVO = this.getAchievementById(param1);
         for(_loc4_ in _loc3_.levelDict)
         {
            if(_loc3_.levelDict[_loc4_].count <= _loc3_.amount && int(_loc4_) > _loc2_)
            {
               _loc2_ = int(_loc4_);
            }
         }
         return _loc2_ + 1;
      }
      
      public function getNextLevelCount(param1:BasicAchievementVO, param2:int) : int
      {
         if(DictionaryUtil.containsKey(param1.levelDict,param2))
         {
            return param1.levelDict[param2].count;
         }
         return 0;
      }
      
      public function getAmountToNextLevelInPercent(param1:BasicAchievementVO, param2:int) : Number
      {
         var _loc4_:int = 0;
         var _loc3_:int = !!DictionaryUtil.containsKey(param1.levelDict,param2 - 1) ? int(param1.levelDict[param2 - 1].count) : 0;
         if(DictionaryUtil.containsKey(param1.levelDict,param2))
         {
            return ((_loc4_ = param1.levelDict[param2].count - _loc3_) - (param1.levelDict[param2].count - param1.amount)) / _loc4_;
         }
         return 1;
      }
      
      public function getBonusElementsById(param1:int, param2:int) : Array
      {
         var _loc8_:XpCurrencyVO = null;
         var _loc3_:Array = new Array();
         var _loc5_:AchievementRequirementVO;
         var _loc4_:BasicAchievementVO;
         if(!(_loc5_ = (_loc4_ = this.getAchievementById(param1)).levelDict[param2]))
         {
            return _loc3_;
         }
         var _loc6_:CashCurrencyVO = CafeModel.wodData.createVObyWOD(CafeConstants.WODID_CASH) as CashCurrencyVO;
         var _loc7_:GoldCurrencyVO = CafeModel.wodData.createVObyWOD(CafeConstants.WODID_GOLD) as GoldCurrencyVO;
         if(_loc5_.cash > 0)
         {
            _loc6_.amount = _loc5_.cash;
            _loc3_.push(_loc6_);
         }
         if(_loc5_.gold > 0)
         {
            _loc7_.amount = _loc5_.gold;
            _loc3_.push(_loc7_);
         }
         CafeModel.userData.changeUserMoney(_loc6_.amount,_loc7_.amount);
         if(_loc5_.xp > 0)
         {
            (_loc8_ = CafeModel.wodData.createVObyWOD(CafeConstants.WODID_XP) as XpCurrencyVO).amount = _loc5_.xp;
            _loc3_.push(_loc8_);
            CafeModel.userData.changeUserXp(_loc8_.amount);
         }
         return _loc3_;
      }
   }
}
