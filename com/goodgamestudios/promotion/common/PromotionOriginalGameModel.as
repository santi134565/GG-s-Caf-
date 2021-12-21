package com.goodgamestudios.promotion.common
{
   import flash.utils.Dictionary;
   
   public class PromotionOriginalGameModel implements IPromotionOriginalGameModel
   {
      
      private static var _instance:PromotionOriginalGameModel;
       
      
      private var _originalGamesMap:Dictionary;
      
      public function PromotionOriginalGameModel()
      {
         super();
      }
      
      public static function get instance() : PromotionOriginalGameModel
      {
         if(!_instance)
         {
            _instance = new PromotionOriginalGameModel();
         }
         return _instance;
      }
      
      public function init() : void
      {
         _originalGamesMap = new Dictionary();
         var _loc2_:PromotionOriginalGameVO = new PromotionOriginalGameVO();
         _loc2_.id = 7;
         _loc2_.name = "Disco";
         _loc2_.gameFolder = "nightclub";
         _loc2_.gameCacheBreaker = "NightClubCacheBreakerSwf";
         var _loc6_:PromotionOriginalGameVO;
         (_loc6_ = new PromotionOriginalGameVO()).id = 5;
         _loc6_.name = "Cafe";
         _loc6_.gameFolder = "cafe";
         _loc6_.gameCacheBreaker = "CafeCacheBreakerSwf";
         var _loc4_:PromotionOriginalGameVO;
         (_loc4_ = new PromotionOriginalGameVO()).id = 12;
         _loc4_.name = "Empire";
         _loc4_.gameFolder = "castle";
         _loc4_.gameCacheBreaker = "CastleCacheBreakerSwf";
         _loc4_.subdomain = "data";
         var _loc5_:PromotionOriginalGameVO;
         (_loc5_ = new PromotionOriginalGameVO()).id = 3;
         _loc5_.name = "Farmer";
         _loc5_.gameFolder = "farm";
         _loc5_.gameCacheBreaker = "FarmLoader2";
         var _loc3_:PromotionOriginalGameVO = new PromotionOriginalGameVO();
         _loc3_.id = 10;
         _loc3_.name = "Fashion";
         _loc3_.gameFolder = "fashion";
         _loc3_.gameCacheBreaker = "FashionCacheBreakerSwf";
         var _loc1_:PromotionOriginalGameVO = new PromotionOriginalGameVO();
         _loc1_.id = 4;
         _loc1_.name = "Gangster";
         _loc1_.gameFolder = "mafia";
         _loc1_.gameCacheBreaker = "MafiaCacheBreakerSwf";
         _loc1_.subdomain = "data";
         var _loc7_:PromotionOriginalGameVO;
         (_loc7_ = new PromotionOriginalGameVO()).id = 1;
         _loc7_.name = "Poker";
         _loc7_.gameFolder = "poker";
         _loc7_.gameCacheBreaker = "PokerCacheBreakerSwf";
         _loc7_.subdomain = "data";
         var _loc9_:PromotionOriginalGameVO;
         (_loc9_ = new PromotionOriginalGameVO()).id = 14;
         _loc9_.name = "Galaxy";
         _loc9_.gameFolder = "galaxy";
         _loc9_.gameCacheBreaker = "GalaxyCacheBreakerSwf";
         _loc9_.subdomain = "data";
         var _loc8_:PromotionOriginalGameVO;
         (_loc8_ = new PromotionOriginalGameVO()).id = 2;
         _loc8_.name = "JumpJupiter";
         _loc8_.gameFolder = "game";
         _loc8_.gameCacheBreaker = "TopRunMVCClient-1.5-b303";
         _loc8_.subdomain = "data";
         _originalGamesMap[_loc2_.id] = _loc2_;
         _originalGamesMap[_loc6_.id] = _loc6_;
         _originalGamesMap[_loc4_.id] = _loc4_;
         _originalGamesMap[_loc5_.id] = _loc5_;
         _originalGamesMap[_loc3_.id] = _loc3_;
         _originalGamesMap[_loc1_.id] = _loc1_;
         _originalGamesMap[_loc7_.id] = _loc7_;
         _originalGamesMap[_loc9_.id] = _loc9_;
         _originalGamesMap[_loc8_.id] = _loc8_;
      }
      
      public function getOriginalGameVOById(gameId:int) : PromotionOriginalGameVO
      {
         return _originalGamesMap[gameId];
      }
   }
}
