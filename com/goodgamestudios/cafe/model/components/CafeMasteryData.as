package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeMasteryCompleteDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMasteryCompleteDialogProperties;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.utils.DictionaryUtil;
   import flash.utils.Dictionary;
   
   public class CafeMasteryData
   {
      
      private static const LEVEL_SERVING_BONUS:int = 1;
      
      private static const LEVEL_XP_BONUS:int = 2;
      
      private static const LEVEL_TIME_BONUS:int = 3;
       
      
      public function CafeMasteryData()
      {
         super();
      }
      
      public function initMasteryDishes(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:VisualVO = null;
         var _loc5_:Array = null;
         var _loc6_:BasicDishVO = null;
         var _loc2_:Dictionary = new Dictionary();
         for each(_loc3_ in param1)
         {
            if((_loc5_ = _loc3_.split("+")).length > 1)
            {
               _loc2_[_loc5_.shift()] = _loc5_.shift();
            }
         }
         for each(_loc4_ in CafeModel.wodData.voList)
         {
            if(_loc4_.group == CafeConstants.GROUP_DISH)
            {
               _loc6_ = _loc4_ as BasicDishVO;
               if(DictionaryUtil.containsKey(_loc2_,_loc6_.wodId))
               {
                  _loc6_.masteryCount = _loc2_[_loc6_.wodId];
               }
               else
               {
                  _loc6_.masteryCount = 0;
               }
            }
         }
      }
      
      public function increaseMastery(param1:int, param2:int = 1) : void
      {
         var _loc3_:int = this.getMasteryLevel(param1);
         (CafeModel.wodData.voList[param1] as BasicDishVO).masteryCount += param2;
         var _loc4_:int = this.getMasteryLevel(param1);
         if(_loc3_ != _loc4_ && !this.env.enableLonelyCow)
         {
            this.layoutManager.showDialog(CafeMasteryCompleteDialog.NAME,new CafeMasteryCompleteDialogProperties(param1));
         }
      }
      
      public function getMasteryLevel(param1:int) : int
      {
         var _loc2_:int = this.getMasteryCount(param1);
         if(_loc2_ >= this.getCountByLevel(param1,3))
         {
            return 3;
         }
         if(_loc2_ >= this.getCountByLevel(param1,2))
         {
            return 2;
         }
         if(_loc2_ >= this.getCountByLevel(param1,1))
         {
            return 1;
         }
         return 0;
      }
      
      private function getMasteryCount(param1:int) : int
      {
         return (CafeModel.wodData.voList[param1] as BasicDishVO).masteryCount;
      }
      
      private function getCountByLevel(param1:int, param2:int) : int
      {
         var _loc3_:Number = (CafeModel.wodData.voList[param1] as BasicDishVO).baseDuration / 60;
         var _loc4_:Number = Math.min(24,_loc3_ * Math.ceil(0.5 / _loc3_) * 3);
         var _loc5_:Array;
         (_loc5_ = []).push(0);
         switch(param1)
         {
            case 1201:
               _loc5_.push(120);
               _loc5_.push(600);
               _loc5_.push(1560);
               break;
            case 1204:
               _loc5_.push(48);
               _loc5_.push(240);
               _loc5_.push(624);
               break;
            default:
               _loc5_.push(Math.round(_loc4_ / _loc3_ * CafeConstants.masteryDaysLV1 * CafeConstants.masteryStoveCount));
               _loc5_.push(Math.round(_loc4_ / _loc3_ * CafeConstants.masteryDaysLV2 * CafeConstants.masteryStoveCount));
               _loc5_.push(Math.round(_loc4_ / _loc3_ * CafeConstants.masteryDaysLV3 * CafeConstants.masteryStoveCount));
         }
         return _loc5_[param2];
      }
      
      public function getNextLevelRange(param1:int, param2:int) : int
      {
         return this.getCountByLevel(param1,param2 + 1) - this.getCountByLevel(param1,param2);
      }
      
      public function getCountTilLevel(param1:int, param2:int) : int
      {
         var _loc3_:int = this.getMasteryCount(param1);
         var _loc4_:int = this.getCountByLevel(param1,param2);
         if(param2 < 4)
         {
            return _loc4_ - _loc3_;
         }
         return -1;
      }
      
      public function getCurrentMasteryBonusServing(param1:int) : Number
      {
         if(this.getMasteryLevel(param1) >= LEVEL_SERVING_BONUS)
         {
            return CafeConstants.masteryBonusServing;
         }
         return 1;
      }
      
      public function getCurrentMasteryBonusXP(param1:int) : Number
      {
         if(this.getMasteryLevel(param1) >= LEVEL_XP_BONUS)
         {
            return CafeConstants.masteryBonusXP;
         }
         return 1;
      }
      
      public function getCurrentMasteryBonusTime(param1:int) : Number
      {
         if(this.getMasteryLevel(param1) >= LEVEL_TIME_BONUS)
         {
            return CafeConstants.masteryBonusTime;
         }
         return 1;
      }
      
      private function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
