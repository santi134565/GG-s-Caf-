package com.goodgamestudios.cafe
{
   import com.goodgamestudios.basic.BasicConstants;
   import com.goodgamestudios.basic.BasicGame;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectClientCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectionFailedCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectionLostCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectionTimeoutCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicDestroyGameCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicExtensionResponseCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInviteFriendCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInviteFriendJsonCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicJoinedRoomCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicLoginJsonCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicLogoutCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicOpenForumCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicPrepareReconnectCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicReconnectCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicRegisterJsonCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicShowRegisterDialogCommand;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicAssetData;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeInitServerCommandsCommand;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeInitializeControllerCommand;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeInviteFriendCommand;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeLoginCommand;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeOnCoopFinishedCommand;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeRegisterUserCommand;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeShowBonusDialogCommand;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeShowPayCheckDialogCommand;
   import com.goodgamestudios.cafe.model.CafeModel;
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
   import com.goodgamestudios.cafe.view.CafeLanguageFontManager;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.utils.ZipUtil;
   import flash.utils.ByteArray;
   
   public class CafeGame extends BasicGame
   {
       
      
      private var _itemXML:XML;
      
      private var _lvlxpXML:XML;
      
      private var _achievementXML:XML;
      
      public function CafeGame(param1:BasicBackgroundComponent)
      {
         super(param1);
      }
      
      override protected function initializeGame() : void
      {
         this.initModel();
         this.initView();
         this.initController();
         CafeModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECTION_LOST,this.onConnectionLost,false,-1);
      }
      
      override protected function registerCommands() : void
      {
         BasicController.init(CafeEnvironmentGlobals);
         CommandController.instance.registerCommand(BasicController.COMMAND_EXTENSION_RESPONSE,BasicExtensionResponseCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_SERVERCOMMANDS,CafeInitServerCommandsCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_LOGIN,CafeLoginCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_LOGOUT,BasicLogoutCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_LOST,BasicConnectionLostCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INITALIZE_CONTROLLER,CafeInitializeControllerCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_REGISTER_USER,CafeRegisterUserCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_RECONNECT,BasicReconnectCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_OPEN_FORUM,BasicOpenForumCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_DESTROY_GAME,BasicDestroyGameCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_SHOW_REGISTER_DIALOG,BasicShowRegisterDialogCommand);
         CommandController.instance.registerCommand(CafeOnCoopFinishedCommand.COMMAND_NAME,CafeOnCoopFinishedCommand);
         CommandController.instance.registerCommand(CafeShowBonusDialogCommand.COMMAND_NAME,CafeShowBonusDialogCommand);
         CommandController.instance.registerCommand(CafeShowPayCheckDialogCommand.COMMAND_NAME,CafeShowPayCheckDialogCommand);
         CommandController.instance.registerCommand(CafeInviteFriendCommand.COMMAND_NAME,CafeInviteFriendCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECT_CLIENT,BasicConnectClientCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_JOINED_ROOM,BasicJoinedRoomCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_FAILED,BasicConnectionFailedCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_TIMEOUT,BasicConnectionTimeoutCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_PREPARE_RECONNECT,BasicPrepareReconnectCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_LOGIN_JSON,BasicLoginJsonCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_REGISTER_USER_JSON,BasicRegisterJsonCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INVITE_FRIEND,BasicInviteFriendCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INVITE_FRIEND_JSON,BasicInviteFriendJsonCommand);
      }
      
      private function initModel() : void
      {
         var _loc1_:Object = BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.ITEM_XML_LOADER);
         this._itemXML = XML(ZipUtil.unzip(_loc1_ as ByteArray));
         var _loc2_:Object = BasicModel.basicLoaderData.appLoader.getLoaderData("levelxpXML");
         this._lvlxpXML = XML(ZipUtil.unzip(_loc2_ as ByteArray));
         var _loc3_:Object = BasicModel.basicLoaderData.appLoader.getLoaderData("achievementXML");
         this._achievementXML = XML(ZipUtil.unzip(_loc3_ as ByteArray));
         CafeModel.assetData = new BasicAssetData();
         CafeModel.smartfoxClient = new CafeSmartfoxClient();
         CafeModel.cookBook = new CafeCookBook();
         CafeModel.dekoShop = new CafeDekoShop();
         CafeModel.fastfoodData = new CafeFastFoodData();
         CafeModel.coopData = new CafeCoopData();
         CafeModel.ingredientShop = new CafeIngredientShop();
         CafeModel.sessionData = new CafeSessionData();
         CafeModel.userData = new CafeUserData();
         CafeModel.userData.levelXpXML = this._lvlxpXML;
         CafeModel.wodData = new CafeWodData(this._itemXML);
         CafeModel.wodData.buildVoDatas();
         CafeModel.achievementData = new CafeAchievementData(this._achievementXML);
         CafeModel.levelData = new CafeLevelData();
         CafeModel.inventoryFridge = new CafeInventoryFridge();
         CafeModel.inventoryFurniture = new CafeInventoryFurniture();
         CafeModel.npcData = new CafeNpcData();
         CafeModel.npcStaffData = new CafeNpcStaffData();
         CafeModel.otherUserData = new CafeOtherUserData();
         CafeModel.localData = new CafeSharedObject();
         CafeModel.buddyList = new CafeBuddyList(stage.loaderInfo.parameters.buddylist);
         CafeModel.giftList = new CafeGiftList();
         CafeModel.socialData = new CafeSocialData();
         CafeModel.masteryData = new CafeMasteryData();
      }
      
      private function initController() : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_INITALIZE_CONTROLLER);
         CafeTutorialController.getInstance();
      }
      
      private function initView() : void
      {
         var _loc1_:CafeLayoutManager = CafeLayoutManager.getInstance();
         _loc1_.initialize(preloaderView);
         addChild(_loc1_);
         _loc1_.changeQualityLevel(CafeModel.localData.readQuality());
         CafeLanguageFontManager.getInstance().initFontSwf();
      }
      
      protected function onConnectionLost(param1:SmartfoxEvent) : void
      {
         this.reInitializeGame();
      }
      
      private function reInitializeGame() : void
      {
         CafeModel.buddyList.reset();
         CafeModel.giftList.reset();
         CafeModel.levelData.levelVO = null;
         CafeModel.sessionData.resetSpecialOffers();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
