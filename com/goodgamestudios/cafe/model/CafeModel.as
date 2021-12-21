package com.goodgamestudios.cafe.model
{
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicAssetData;
   import com.goodgamestudios.basic.model.components.BasicLanguageData;
   import com.goodgamestudios.cafe.model.components.CafeAchievementData;
   import com.goodgamestudios.cafe.model.components.CafeBuddyList;
   import com.goodgamestudios.cafe.model.components.CafeCookBook;
   import com.goodgamestudios.cafe.model.components.CafeCoopData;
   import com.goodgamestudios.cafe.model.components.CafeDekoShop;
   import com.goodgamestudios.cafe.model.components.CafeFastFoodData;
   import com.goodgamestudios.cafe.model.components.CafeGiftList;
   import com.goodgamestudios.cafe.model.components.CafeIngredientShop;
   import com.goodgamestudios.cafe.model.components.CafeInventoryFridge;
   import com.goodgamestudios.cafe.model.components.CafeInventoryFurniture;
   import com.goodgamestudios.cafe.model.components.CafeLevelData;
   import com.goodgamestudios.cafe.model.components.CafeMasteryData;
   import com.goodgamestudios.cafe.model.components.CafeNpcData;
   import com.goodgamestudios.cafe.model.components.CafeNpcStaffData;
   import com.goodgamestudios.cafe.model.components.CafeOtherUserData;
   import com.goodgamestudios.cafe.model.components.CafeSessionData;
   import com.goodgamestudios.cafe.model.components.CafeSharedObject;
   import com.goodgamestudios.cafe.model.components.CafeSmartfoxClient;
   import com.goodgamestudios.cafe.model.components.CafeSocialData;
   import com.goodgamestudios.cafe.model.components.CafeUserData;
   import com.goodgamestudios.cafe.model.components.CafeWodData;
   
   public class CafeModel extends BasicModel
   {
      
      public static var wodData:CafeWodData;
      
      public static var levelData:CafeLevelData;
      
      public static var cookBook:CafeCookBook;
      
      public static var coopData:CafeCoopData;
      
      public static var dekoShop:CafeDekoShop;
      
      public static var inventoryFridge:CafeInventoryFridge;
      
      public static var inventoryFurniture:CafeInventoryFurniture;
      
      public static var ingredientShop:CafeIngredientShop;
      
      public static var npcData:CafeNpcData;
      
      public static var npcStaffData:CafeNpcStaffData;
      
      public static var otherUserData:CafeOtherUserData;
      
      public static var buddyList:CafeBuddyList;
      
      public static var giftList:CafeGiftList;
      
      public static var masteryData:CafeMasteryData;
      
      public static var fastfoodData:CafeFastFoodData;
       
      
      public function CafeModel()
      {
         super();
      }
      
      public static function get sessionData() : CafeSessionData
      {
         return _sessionData as CafeSessionData;
      }
      
      public static function set sessionData(param1:CafeSessionData) : void
      {
         _sessionData = param1;
      }
      
      public static function get smartfoxClient() : CafeSmartfoxClient
      {
         return _smartfoxClient as CafeSmartfoxClient;
      }
      
      public static function set smartfoxClient(param1:CafeSmartfoxClient) : void
      {
         _smartfoxClient = param1;
      }
      
      public static function get assetData() : BasicAssetData
      {
         return _assetData;
      }
      
      public static function set assetData(param1:BasicAssetData) : void
      {
         _assetData = param1;
      }
      
      public static function get userData() : CafeUserData
      {
         return _userData as CafeUserData;
      }
      
      public static function set userData(param1:CafeUserData) : void
      {
         _userData = param1;
      }
      
      public static function get socialData() : CafeSocialData
      {
         return _socialData as CafeSocialData;
      }
      
      public static function set socialData(param1:CafeSocialData) : void
      {
         _socialData = param1;
      }
      
      public static function get languageData() : BasicLanguageData
      {
         return _languageData as BasicLanguageData;
      }
      
      public static function set languageData(param1:BasicLanguageData) : void
      {
         _languageData = param1;
      }
      
      public static function get achievementData() : CafeAchievementData
      {
         return _achievementData as CafeAchievementData;
      }
      
      public static function set achievementData(param1:CafeAchievementData) : void
      {
         _achievementData = param1;
      }
      
      public static function get localData() : CafeSharedObject
      {
         return _localData as CafeSharedObject;
      }
      
      public static function set localData(param1:CafeSharedObject) : void
      {
         _localData = param1;
      }
      
      public static function updateModelData() : void
      {
         npcData.update();
      }
   }
}
