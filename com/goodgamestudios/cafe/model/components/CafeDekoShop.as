package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.chair.BasicChairVO;
   import com.goodgamestudios.cafe.world.vo.counter.BasicCounterVO;
   import com.goodgamestudios.cafe.world.vo.deco.BasicDecoVO;
   import com.goodgamestudios.cafe.world.vo.door.BasicDoorVO;
   import com.goodgamestudios.cafe.world.vo.expansion.BasicExpansionVO;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   import com.goodgamestudios.cafe.world.vo.stove.BasicStoveVO;
   import com.goodgamestudios.cafe.world.vo.table.BasicTableVO;
   import com.goodgamestudios.cafe.world.vo.tile.StaticTileVO;
   import com.goodgamestudios.cafe.world.vo.vendingmachine.BasicVendingmachineVO;
   import com.goodgamestudios.cafe.world.vo.wall.StaticWallVO;
   import com.goodgamestudios.cafe.world.vo.wallobject.BasicWallobjectVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.utils.Dictionary;
   
   public class CafeDekoShop
   {
      
      public static const OPEN_FOR_STANDARD:int = 0;
      
      public static const OPEN_FOR_VENDINGMACHINES:int = 1;
       
      
      public var openFor:int = 0;
      
      private var _deco:Vector.<BasicDecoVO>;
      
      private var _chair:Vector.<BasicChairVO>;
      
      private var _table:Vector.<BasicTableVO>;
      
      private var _wall:Vector.<StaticWallVO>;
      
      private var _tile:Vector.<StaticTileVO>;
      
      private var _door:Vector.<BasicDoorVO>;
      
      private var _expansion:Vector.<BasicExpansionVO>;
      
      private var _wallobject:Vector.<BasicWallobjectVO>;
      
      private var _counter:Vector.<BasicCounterVO>;
      
      private var _fridge:Vector.<BasicFridgeVO>;
      
      private var _stove:Vector.<BasicStoveVO>;
      
      private var _vendingmachine:Vector.<BasicVendingmachineVO>;
      
      public function CafeDekoShop()
      {
         super();
      }
      
      public function buildDekoShop(param1:Dictionary) : void
      {
         var _loc2_:VisualVO = null;
         this._deco = new Vector.<BasicDecoVO>();
         this._chair = new Vector.<BasicChairVO>();
         this._table = new Vector.<BasicTableVO>();
         this._wall = new Vector.<StaticWallVO>();
         this._tile = new Vector.<StaticTileVO>();
         this._door = new Vector.<BasicDoorVO>();
         this._expansion = new Vector.<BasicExpansionVO>();
         this._wallobject = new Vector.<BasicWallobjectVO>();
         this._counter = new Vector.<BasicCounterVO>();
         this._fridge = new Vector.<BasicFridgeVO>();
         this._stove = new Vector.<BasicStoveVO>();
         this._vendingmachine = new Vector.<BasicVendingmachineVO>();
         for each(_loc2_ in param1)
         {
            if(_loc2_.group == CafeConstants.GROUP_DECO)
            {
               this._deco.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_CHAIR)
            {
               this._chair.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_TABLE)
            {
               this._table.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_WALL)
            {
               this._wall.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_TILE)
            {
               this._tile.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_DOOR)
            {
               this._door.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_COUNTER)
            {
               this._counter.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_FRIDGE)
            {
               this._fridge.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_STOVE)
            {
               this._stove.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_EXPANSION)
            {
               this._expansion.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_WALLOBJECT)
            {
               this._wallobject.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
            if(_loc2_.group == CafeConstants.GROUP_VENDINGMACHINE)
            {
               this._vendingmachine.push(CafeModel.wodData.createVObyWOD(_loc2_.wodId));
            }
         }
      }
      
      public function get deco() : Vector.<BasicDecoVO>
      {
         return this._deco.sort(this.sortByLevelMoney);
      }
      
      public function get chair() : Vector.<BasicChairVO>
      {
         return this._chair.sort(this.sortByLevelMoney);
      }
      
      public function get table() : Vector.<BasicTableVO>
      {
         return this._table.sort(this.sortByLevelMoney);
      }
      
      public function get wall() : Vector.<StaticWallVO>
      {
         return this._wall.sort(this.sortByLevelMoney);
      }
      
      public function get tile() : Vector.<StaticTileVO>
      {
         return this._tile.sort(this.sortByLevelMoney);
      }
      
      public function get door() : Vector.<BasicDoorVO>
      {
         return this._door.sort(this.sortByLevelMoney);
      }
      
      public function get counter() : Vector.<BasicCounterVO>
      {
         return this._counter.sort(this.sortByLevelMoney);
      }
      
      public function get fridge() : Vector.<BasicFridgeVO>
      {
         return this._fridge.sort(this.sortByLevelMoney);
      }
      
      public function get stove() : Vector.<BasicStoveVO>
      {
         return this._stove.sort(this.sortByLevelMoney);
      }
      
      public function get expansion() : Vector.<BasicExpansionVO>
      {
         return this._expansion.sort(this.sortByLevelMoney);
      }
      
      public function get wallobject() : Vector.<BasicWallobjectVO>
      {
         return this._wallobject.sort(this.sortByLevelMoney);
      }
      
      public function get vendingmachine() : Vector.<BasicVendingmachineVO>
      {
         return this._vendingmachine;
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
         return 0;
      }
   }
}
