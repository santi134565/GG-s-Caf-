package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.components.BasicWodData;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.achievement.BasicAchievementVO;
   import com.goodgamestudios.cafe.world.vo.avatar.FaceAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.HairAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.HatAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.LegsAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.SkinAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.TopAvatarVO;
   import com.goodgamestudios.cafe.world.vo.background.CafeBackgroundVO;
   import com.goodgamestudios.cafe.world.vo.background.MarketplaceBackgroundVO;
   import com.goodgamestudios.cafe.world.vo.background.StaticBackgroundVO;
   import com.goodgamestudios.cafe.world.vo.chair.BackChairVO;
   import com.goodgamestudios.cafe.world.vo.chair.BasicChairVO;
   import com.goodgamestudios.cafe.world.vo.coop.BasicCoopVO;
   import com.goodgamestudios.cafe.world.vo.counter.BasicCounterVO;
   import com.goodgamestudios.cafe.world.vo.currency.LogincashCurrencyVO;
   import com.goodgamestudios.cafe.world.vo.currency.MuffincashCurrencyVO;
   import com.goodgamestudios.cafe.world.vo.cursor.StaticCursorVO;
   import com.goodgamestudios.cafe.world.vo.deco.AdventDecoVO;
   import com.goodgamestudios.cafe.world.vo.deco.AnimatedDecoVO;
   import com.goodgamestudios.cafe.world.vo.deco.BasicDecoVO;
   import com.goodgamestudios.cafe.world.vo.deco.LanguageDecoVO;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.door.BasicDoorVO;
   import com.goodgamestudios.cafe.world.vo.door.BorderDoorVO;
   import com.goodgamestudios.cafe.world.vo.expansion.BasicExpansionVO;
   import com.goodgamestudios.cafe.world.vo.fastfood.BasicFastfoodVO;
   import com.goodgamestudios.cafe.world.vo.fastfood.SmoothieFastfoodVO;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   import com.goodgamestudios.cafe.world.vo.icon.BasicIconVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.cafe.world.vo.moving.BasicMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.HeroMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcbackgroundMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcguestMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcwaiterMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.PlateholderMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.VestedMovingVO;
   import com.goodgamestudios.cafe.world.vo.overlay.ThirstyOverlayVO;
   import com.goodgamestudios.cafe.world.vo.stove.BasicStoveVO;
   import com.goodgamestudios.cafe.world.vo.table.BasicTableVO;
   import com.goodgamestudios.cafe.world.vo.tile.StaticTileVO;
   import com.goodgamestudios.cafe.world.vo.vendingmachine.BasicVendingmachineVO;
   import com.goodgamestudios.cafe.world.vo.vendingmachine.SmoothieVendingmachineVO;
   import com.goodgamestudios.cafe.world.vo.wall.StaticWallVO;
   import com.goodgamestudios.cafe.world.vo.wallobject.AnimatedWallobjectVO;
   import com.goodgamestudios.cafe.world.vo.wallobject.BasicWallobjectVO;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.utils.DictionaryUtil;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class CafeWodData extends BasicWodData
   {
      
      private static const FORCE_EMBED_WORLD_VO_CLASSES:Array = [StaticTileVO,StaticWallVO,StaticBackgroundVO,StaticCursorVO,BasicDecoVO,BasicTableVO,BasicCounterVO,BasicMovingVO,NpcMovingVO,NpcguestMovingVO,NpcwaiterMovingVO,NpcbackgroundMovingVO,VestedMovingVO,BasicIconVO,ThirstyOverlayVO,PlateholderMovingVO,HeroMovingVO,BasicExpansionVO,BasicDoorVO,BorderDoorVO,BasicStoveVO,BasicFridgeVO,BasicWallobjectVO,BasicAchievementVO,BasicChairVO,BackChairVO,AnimatedWallobjectVO,TopAvatarVO,LegsAvatarVO,SkinAvatarVO,HatAvatarVO,FaceAvatarVO,HairAvatarVO,BasicDishVO,BasicIngredientVO,LogincashCurrencyVO,MuffincashCurrencyVO,MarketplaceBackgroundVO,CafeBackgroundVO,LanguageDecoVO,AnimatedDecoVO,BasicCoopVO,BasicFastfoodVO,SmoothieFastfoodVO,BasicVendingmachineVO,SmoothieVendingmachineVO,AdventDecoVO];
       
      
      protected var _voList:Dictionary;
      
      public function CafeWodData(param1:XML)
      {
         this._voList = new Dictionary();
         super(param1);
         this.parseVOFromWODXml();
      }
      
      override protected function parseWodXML() : void
      {
         var _loc1_:XMLList = null;
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         _loc1_ = wodXML.elements();
         _wodXMLList = new Dictionary();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = parseInt(_loc2_.attribute("id"));
            _wodXMLList[_loc3_] = _loc2_;
         }
      }
      
      public function createVObyWOD(param1:int) : VisualVO
      {
         if(!DictionaryUtil.containsKey(_wodXMLList,param1))
         {
            return null;
         }
         var _loc2_:XML = _wodXMLList[param1];
         var _loc3_:String = _loc2_.attribute("n");
         var _loc4_:String = _loc2_.attribute("g");
         var _loc6_:VisualVO;
         var _loc5_:Class;
         (_loc6_ = new (_loc5_ = getDefinitionByName(CafeConstants.CAFE_VO_CLASS_PATH + _loc4_.toLowerCase() + "::" + _loc3_ + _loc4_ + "VO") as Class)()).fillFromParamXML(_loc2_);
         return _loc6_;
      }
      
      private function parseVOFromWODXml() : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Class = null;
         var _loc8_:VisualVO = null;
         var _loc1_:XMLList = wodXML.elements();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = parseInt(_loc2_.attribute("id"));
            _loc4_ = _loc2_.attribute("n");
            _loc5_ = _loc2_.attribute("g");
            _loc6_ = _loc2_.attribute("t");
            (_loc8_ = new (_loc7_ = getDefinitionByName(CafeConstants.CAFE_VO_CLASS_PATH + _loc5_.toLowerCase() + "::" + _loc4_ + _loc5_ + "VO") as Class)()).fillFromParamXML(_loc2_);
            if(!(_loc8_.hasOwnProperty("worldIndex") && !this.voIsForWorld(_loc8_["worldIndex"])))
            {
               this._voList[_loc3_] = _loc8_;
            }
         }
      }
      
      public function buildVoDatas() : void
      {
         CafeModel.ingredientShop.buildIngredientShop(this._voList);
         CafeModel.cookBook.buildCookBook(this._voList);
         CafeModel.dekoShop.buildDekoShop(this._voList);
         CafeModel.coopData.buildCoop(this._voList);
         CafeModel.fastfoodData.buildFastFoodData(this._voList);
      }
      
      private function voIsForWorld(param1:int) : Boolean
      {
         switch(param1)
         {
            case 0:
               return true;
            case 1:
               return this.env.isLocal || GoodgamePartners.NETWORK_GENERAL == this.env.networkId || !this.env.hasNetworkBuddies;
            case 2:
               return this.env.hasNetworkBuddies;
            default:
               return true;
         }
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      public function get voList() : Dictionary
      {
         return this._voList;
      }
   }
}
