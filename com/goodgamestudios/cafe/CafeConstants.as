package com.goodgamestudios.cafe
{
   import com.goodgamestudios.cafe.world.objects.background.CafeBackground;
   import com.goodgamestudios.cafe.world.objects.background.MarketplaceBackground;
   import com.goodgamestudios.cafe.world.objects.background.StaticBackground;
   import com.goodgamestudios.cafe.world.objects.chair.BasicChair;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.cursor.StaticCursor;
   import com.goodgamestudios.cafe.world.objects.deco.AdventDeco;
   import com.goodgamestudios.cafe.world.objects.deco.AnimatedDeco;
   import com.goodgamestudios.cafe.world.objects.deco.BasicDeco;
   import com.goodgamestudios.cafe.world.objects.deco.LanguageDeco;
   import com.goodgamestudios.cafe.world.objects.door.BasicDoor;
   import com.goodgamestudios.cafe.world.objects.door.BorderDoor;
   import com.goodgamestudios.cafe.world.objects.fridge.BasicFridge;
   import com.goodgamestudios.cafe.world.objects.moving.HeroMoving;
   import com.goodgamestudios.cafe.world.objects.moving.NpcbackgroundMoving;
   import com.goodgamestudios.cafe.world.objects.moving.NpcguestMoving;
   import com.goodgamestudios.cafe.world.objects.moving.NpcwaiterMoving;
   import com.goodgamestudios.cafe.world.objects.moving.OtherplayerMoving;
   import com.goodgamestudios.cafe.world.objects.overlay.MovingIconOverlay;
   import com.goodgamestudios.cafe.world.objects.overlay.StaticIconOverlay;
   import com.goodgamestudios.cafe.world.objects.overlay.ThirstyOverlay;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import com.goodgamestudios.cafe.world.objects.table.BasicTable;
   import com.goodgamestudios.cafe.world.objects.tile.StaticTile;
   import com.goodgamestudios.cafe.world.objects.vendingmachine.BasicVendingmachine;
   import com.goodgamestudios.cafe.world.objects.vendingmachine.SmoothieVendingmachine;
   import com.goodgamestudios.cafe.world.objects.wall.StaticWall;
   import com.goodgamestudios.cafe.world.objects.wallobject.AnimatedWallobject;
   import com.goodgamestudios.cafe.world.objects.wallobject.BasicWallobject;
   import com.goodgamestudios.isocore.vo.LevelVO;
   import com.goodgamestudios.isocore.vo.VOHelper;
   
   public class CafeConstants
   {
      
      public static const LOGGEDIN_MESSAGE_TIME_INTERVAL:int = 60000 * 60 * 2;
      
      public static const MAXGIFTS:int = 99;
      
      public static const CAMERA_ZOOM_STEP:Number = 0.2;
      
      public static const NEW_SHOPITEM_LEFTTIME:Number = 14 * 24 * 60 * 60;
      
      public static const EVENT_HALLOWEEN:String = "2";
      
      public static const EVENT_CHRISTMAS:String = "3";
      
      public static const EVENT_EASTER:String = "5";
      
      public static const WODID_STOVE:int = 252;
      
      public static const WODID_COUNTER:int = 301;
      
      public static const WODID_FRIDGE:int = 351;
      
      public static const WODID_WAITER:int = 1602;
      
      public static const WODID_CASH:int = 1901;
      
      public static const WODID_GOLD:int = 1902;
      
      public static const WODID_RATEUP:int = 1903;
      
      public static const WODID_RATEDOWN:int = 1904;
      
      public static const WODID_XP:int = 1905;
      
      public static const WODID_MUFFINCASH:int = 1910;
      
      public static const WODID_SERVINGACHIEVEMENT:int = 2007;
      
      public static const WODID_WAITINGICON:int = 1907;
      
      public static const WODID_SEEKINGJOBICON:int = 1908;
      
      public static const WODID_COCKTAILCHERRY:int = 1450;
      
      public static const URL_FORUM:String = "http://forum.goodgamestudios.com/cafe/";
      
      public static const DE_URL_FORUM:String = "http://forum.goodgamestudios.com/de/";
      
      public static const EN_URL_FORUM:String = "http://forum.goodgamestudios.com/en/";
      
      public static const EN_FORUM_ID_FAQ:String = "46";
      
      public static const DE_FORUM_ID_FAQ:String = "59";
      
      public static const EN_FORUM_ID_NEWS:String = "41";
      
      public static const DE_FORUM_ID_NEWS:String = "41";
      
      public static const EN_FORUM_ID_BUGREPORT:String = "47";
      
      public static const DE_FORUM_ID_BUGREPORT:String = "60";
      
      public static const MEINVZ_URL_GROUP_INSTANCE1:String = "http://www.meinvz.net/Groups/Overview/bf2a1bcf8b0c63cf";
      
      public static const MEINVZ_URL_GROUP_INSTANCE2:String = "http://www.meinvz.net/Groups/Overview/ebbd6a4c5b3aa75c";
      
      public static const SCHUELERVZ_URL_GROUP_INSTANCE1:String = "http://www.schuelervz.net/Groups/Overview/2393c3ced20e2f98";
      
      public static const SCHUELERVZ_URL_GROUP_INSTANCE2:String = "http://www.schuelervz.net/Groups/Overview/30b9a0027e930727";
      
      public static const NK_URL_GROUP_INSTANCE1:String = "http://nk.pl/#grupy/61829";
      
      public static const CAFE_VO_CLASS_PATH:String = "com.goodgamestudios.cafe.world.vo.";
      
      public static const CAFE_OBJECT_CLASS_PATH:String = "com.goodgamestudios.cafe.world.objects.";
      
      public static const CAFE_WORLD_TYPE_MYCAFE:int = 0;
      
      public static const CAFE_WORLD_TYPE_MARKETPLACE:int = 1;
      
      public static const CAFE_WORLD_TYPE_OTHERPLAYERCAFE:int = 2;
      
      public static const ISOTILESIZE_X:int = 80;
      
      public static const ISOTILESIZE_Y:int = 40;
      
      public static const DEPTH_DOOR_LEFT_OPEN:Number = 1.6;
      
      public static const DEPTH_DOOR_RIGHT_OPEN:Number = -0.1;
      
      public static const DEPTH_DOOR_LEFT_CLOSED:Number = 0.4;
      
      public static const DEPTH_DOOR_RIGHT_CLOSED:Number = 0.1;
      
      public static const DEPTH_DOOR_BORDER_LEFT:Number = 0.6;
      
      public static const DEPTH_DOOR_BORDER_RIGHT:Number = 0.1;
      
      public static const DEPTH_HERO:Number = 0.3;
      
      public static const DEPTH_OTHERPLAYER:Number = 0.2;
      
      public static const DEPTH_WALL_LEFT:Number = 0;
      
      public static const DEPTH_WALL_RIGHT:Number = -1;
      
      public static const DEPTH_WALL_DRAG:Number = 1.7;
      
      public static const DEPTH_WALLOBJECT:Number = 0.35;
      
      public static const GROUP_STOVE:String = "Stove";
      
      public static const GROUP_COUNTER:String = "Counter";
      
      public static const GROUP_DOOR:String = "Door";
      
      public static const GROUP_WALL:String = "Wall";
      
      public static const GROUP_TABLE:String = "Table";
      
      public static const GROUP_WALLOBJECT:String = "Wallobject";
      
      public static const GROUP_CHAIR:String = "Chair";
      
      public static const GROUP_DECO:String = "Deco";
      
      public static const GROUP_TILE:String = "Tile";
      
      public static const GROUP_FRIDGE:String = "Fridge";
      
      public static const GROUP_EXPANSION:String = "Expansion";
      
      public static const GROUP_AVATAR:String = "Avatar";
      
      public static const NAME_BACKCHAIR:String = "Back";
      
      public static const GROUP_MOVING:String = "Moving";
      
      public static const GROUP_BACKGROUND:String = "Background";
      
      public static const GROUP_INGREDIENT:String = "Ingredient";
      
      public static const GROUP_CURRENCY:String = "Currency";
      
      public static const GROUP_DISH:String = "Dish";
      
      public static const GROUP_FASTFOOD:String = "Fastfood";
      
      public static const GROUP_VENDINGMACHINE:String = "Vendingmachine";
      
      public static const NAME_SMOOTHIE:String = "Smoothie";
      
      public static const COOP_FINISHLEVEL_GOLD:int = 0;
      
      public static const COOP_FINISHLEVEL_SILVER:int = 1;
      
      public static const COOP_FINISHLEVEL_BRONZE:int = 2;
      
      public static const COOP_FINISHLEVEL_FAIL:int = 3;
      
      public static const MIN_DISH_READY_TIME:int = 60;
      
      public static const MIN_COOKING_TIME:Number = 0.5;
      
      public static const LEVEL_FOR_HIGHSCORE:int = 2;
      
      public static const LEVEL_FOR_PERSONAL:int = 3;
      
      public static const LEVEL_FOR_MARKETPLACE:int = 4;
      
      public static const LEVEL_FOR_COOPS:int = 5;
      
      public static const LEVEL_FOR_PRESENTS:int = 7;
      
      public static const LEVEL_FOR_WHEELOFFORTUNE:int = 9;
      
      public static const LEVEL_FOR_MUFFINMAN:int = 10;
      
      public static const LEVEL_FOR_JOBS:int = 4;
      
      public static const LEVEL_FOR_ADDFRIEND:int = 4;
      
      public static const LEVEL_FOR_EXPANSIONS:int = 5;
      
      public static const LEVEL_FOR_INSTANTCOOKING:int = 5;
      
      public static const LEVEL_FOR_VENDINGMACHINE:int = 6;
      
      public static const LEVEL_FOR_FANCYS:int = 7;
      
      public static const LEVEL_FOR_INSTANTDIALOG:int = 8;
      
      public static const LEVEL_FOR_PREMIUMDECO:int = 8;
      
      public static const LEVEL_FOR_PREMIUMDISH:int = 9;
      
      private static var _cleanCostCash:int;
      
      private static var _staffPrice:int;
      
      private static var _sellFactorGold:Number;
      
      private static var _sellFactorCash:Number;
      
      private static var _timeFactor:int = 1;
      
      private static var _rating_guest_unhappy:int;
      
      private static var _rating_guest_happy:int;
      
      private static var _courierPrice:int;
      
      private static var _maxCourierSize:int;
      
      private static var _instantCookHourPerGold:int;
      
      private static var _serverTimeStamp:Number;
      
      private static var _workTimeLeft:Number;
      
      private static var _jobsPerDay:int;
      
      private static var _jobRefillGold:int;
      
      private static var _fancyFactorXp:int;
      
      private static var _fancyFactorServings:int;
      
      private static var _coopExpansionHoures:int;
      
      private static var _coopExpansionGold:int;
      
      private static var _coopTimeToGold:Number;
      
      private static var _coopTimeToSilver:Number;
      
      private static var _coopRewardFactorGold:Number;
      
      private static var _coopRewardFactorSilver:Number;
      
      private static var _coopRewardFactors:Array;
      
      private static var _refreshFoodCost:int;
      
      private static var _masteryDaysLV1:Number;
      
      private static var _masteryDaysLV2:Number;
      
      private static var _masteryDaysLV3:Number;
      
      private static var _masteryStoveCount:int;
      
      private static var _masteryBonusServing:Number;
      
      private static var _masteryBonusXP:Number;
      
      private static var _masteryBonusTime:Number;
      
      private static var _emailVerificationGold:int;
      
      private static const FORCE_EMBED_LANGUAGE_CLASSES:Array = [language_de,language_pl,language_en,language_zh_CN,language_ja,language_cs,language_da,language_fi,language_hu,language_it,language_no,language_sv,language_ko,language_es,language_fr,language_nl,language_pt,language_ru,language_tr,language_ar,language_el,language_zh_TW];
      
      private static const FORCE_EMBED_WORLD_CLASSES:Array = [AnimatedWallobject,AnimatedDeco,LanguageDeco,StaticTile,StaticWall,BasicWallobject,StaticBackground,MarketplaceBackground,StaticCursor,BasicChair,BasicStove,BorderDoor,BasicDeco,BasicDoor,BasicTable,BasicFridge,BasicCounter,HeroMoving,OtherplayerMoving,NpcguestMoving,NpcwaiterMoving,NpcbackgroundMoving,MovingIconOverlay,StaticIconOverlay,AdventDeco,CafeBackground,BasicVendingmachine,SmoothieVendingmachine,ThirstyOverlay];
      
      private static const TEMP_FOR_IMPORT:Array = [VOHelper,LevelVO];
       
      
      public function CafeConstants()
      {
         super();
      }
      
      public static function setServerBalancingConstants(param1:Array) : void
      {
         _cleanCostCash = param1.shift();
         _staffPrice = param1.shift();
         _sellFactorCash = param1.shift() / 100;
         _sellFactorGold = param1.shift() / 100;
         _timeFactor = param1.shift();
         _rating_guest_happy = param1.shift();
         _rating_guest_unhappy = param1.shift();
         _courierPrice = param1.shift();
         _maxCourierSize = param1.shift();
         _instantCookHourPerGold = param1.shift();
         _serverTimeStamp = param1.shift();
         _jobsPerDay = param1.shift();
         _jobRefillGold = param1.shift();
         _workTimeLeft = param1.shift();
         _fancyFactorServings = 20;
         _fancyFactorXp = 20;
         _coopExpansionHoures = param1.shift();
         _coopExpansionGold = param1.shift();
         _coopTimeToGold = param1.shift();
         _coopTimeToSilver = param1.shift();
         _coopRewardFactorGold = param1.shift();
         _coopRewardFactorSilver = param1.shift();
         _refreshFoodCost = param1.shift();
         _masteryDaysLV1 = param1.shift();
         _masteryDaysLV2 = param1.shift();
         _masteryDaysLV3 = param1.shift();
         _masteryStoveCount = param1.shift();
         _masteryBonusServing = param1.shift();
         _masteryBonusXP = param1.shift();
         _masteryBonusTime = param1.shift();
         _emailVerificationGold = param1.shift();
         _coopRewardFactors = [CafeConstants.coopRewardFactorGold,CafeConstants.coopRewardFactorSilver,1,0];
      }
      
      public static function get emailVerificationGold() : int
      {
         return _emailVerificationGold;
      }
      
      public static function get coopExpansionHoures() : int
      {
         return _coopExpansionHoures;
      }
      
      public static function get coopExpansionGold() : int
      {
         return _coopExpansionGold;
      }
      
      public static function get coopTimeToGold() : Number
      {
         return _coopTimeToGold;
      }
      
      public static function get coopTimeToSilver() : Number
      {
         return _coopTimeToSilver;
      }
      
      public static function get coopRewardFactorGold() : Number
      {
         return _coopRewardFactorGold;
      }
      
      public static function get coopRewardFactorSilver() : Number
      {
         return _coopRewardFactorSilver;
      }
      
      public static function get coopRewardFactors() : Array
      {
         return _coopRewardFactors;
      }
      
      public static function get fancyFactorXp() : int
      {
         return _fancyFactorXp;
      }
      
      public static function get fancyFactorServings() : int
      {
         return _fancyFactorServings;
      }
      
      public static function get jobsPerDay() : int
      {
         return _jobsPerDay;
      }
      
      public static function get jobRefillGold() : int
      {
         return _jobRefillGold;
      }
      
      public static function get workTimeLeft() : Number
      {
         return _workTimeLeft;
      }
      
      public static function get cleanCostCash() : int
      {
         return _cleanCostCash;
      }
      
      public static function get staffPrice() : int
      {
         return _staffPrice;
      }
      
      public static function get sellFactorGold() : Number
      {
         return _sellFactorGold;
      }
      
      public static function get sellFactorCash() : Number
      {
         return _sellFactorCash;
      }
      
      public static function get timeFactor() : int
      {
         return _timeFactor;
      }
      
      public static function get rating_guest_unhappy() : int
      {
         return _rating_guest_unhappy;
      }
      
      public static function get rating_guest_happy() : int
      {
         return _rating_guest_happy;
      }
      
      public static function get courierPrice() : int
      {
         return _courierPrice;
      }
      
      public static function get maxCourierSize() : int
      {
         return _maxCourierSize;
      }
      
      public static function get instantCookHourPerGold() : int
      {
         return _instantCookHourPerGold;
      }
      
      public static function get serverTimeStamp() : Number
      {
         return _serverTimeStamp;
      }
      
      public static function get refreshFoodCost() : int
      {
         return _refreshFoodCost;
      }
      
      public static function set refreshFoodCost(param1:int) : void
      {
         _refreshFoodCost = param1;
      }
      
      public static function get masteryDaysLV1() : Number
      {
         return _masteryDaysLV1;
      }
      
      public static function get masteryDaysLV2() : Number
      {
         return _masteryDaysLV2;
      }
      
      public static function get masteryDaysLV3() : Number
      {
         return _masteryDaysLV3;
      }
      
      public static function get masteryStoveCount() : int
      {
         return _masteryStoveCount;
      }
      
      public static function get masteryBonusServing() : Number
      {
         return _masteryBonusServing;
      }
      
      public static function get masteryBonusXP() : Number
      {
         return _masteryBonusXP;
      }
      
      public static function get masteryBonusTime() : Number
      {
         return _masteryBonusTime;
      }
   }
}
