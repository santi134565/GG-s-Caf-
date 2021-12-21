package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.objects.vendingmachine.SmoothieVendingmachine;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.fastfood.BasicFastfoodVO;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.utils.Dictionary;
   
   public class CafeFastFoodData
   {
       
      
      private var _fastfood:Vector.<BasicFastfoodVO>;
      
      private var _smoothies:Vector.<BasicFastfoodVO>;
      
      private var _smoothieMaker:SmoothieVendingmachine;
      
      private var _ownFastFood:Vector.<BasicFastfoodVO>;
      
      private var _ownSmoothies:Vector.<BasicFastfoodVO>;
      
      public function CafeFastFoodData()
      {
         super();
      }
      
      public function buildFastFoodData(param1:Dictionary) : void
      {
         var _loc2_:VisualVO = null;
         this._fastfood = new Vector.<BasicFastfoodVO>();
         this._smoothies = new Vector.<BasicFastfoodVO>();
         this._ownFastFood = new Vector.<BasicFastfoodVO>();
         this._ownSmoothies = new Vector.<BasicFastfoodVO>();
         for each(_loc2_ in param1)
         {
            if(_loc2_.group == CafeConstants.GROUP_FASTFOOD)
            {
               if(_loc2_.name == CafeConstants.NAME_SMOOTHIE)
               {
                  this._smoothies.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
               }
               this._fastfood.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
         }
      }
      
      public function get fastfood() : Vector.<BasicFastfoodVO>
      {
         return this._fastfood.sort(this.sortByLevelMoney);
      }
      
      public function get smoothies() : Vector.<BasicFastfoodVO>
      {
         return this._smoothies.sort(this.sortByLevelMoney);
      }
      
      public function get smoothieMaker() : SmoothieVendingmachine
      {
         var _loc1_:IsoObject = null;
         if(this._smoothieMaker)
         {
            return this._smoothieMaker;
         }
         for each(_loc1_ in CafeLayoutManager.getInstance().isoScreen.isoWorld.isoObjects)
         {
            if(_loc1_ && _loc1_ is SmoothieVendingmachine)
            {
               this._smoothieMaker = _loc1_ as SmoothieVendingmachine;
               return this._smoothieMaker;
            }
         }
         return null;
      }
      
      private function sortByLevelMoney(param1:ShopVO, param2:ShopVO) : Number
      {
         if(param1.itemLevel < param2.itemLevel)
         {
            return -1;
         }
         if(param1.itemLevel > param2.itemLevel)
         {
            return 1;
         }
         if(param1.itemGold < param2.itemGold)
         {
            return -1;
         }
         if(param1.itemGold > param2.itemGold)
         {
            return 1;
         }
         if(param1.itemCash < param2.itemCash)
         {
            return -1;
         }
         if(param1.itemCash > param2.itemCash)
         {
            return 1;
         }
         if(param1.wodId < param2.wodId)
         {
            return -1;
         }
         if(param1.wodId > param2.wodId)
         {
            return 1;
         }
         return 0;
      }
   }
}
