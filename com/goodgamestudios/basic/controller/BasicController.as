package com.goodgamestudios.basic.controller
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.commands.BasicCommandVO;
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.constants.CommonGameStates;
   import com.goodgamestudios.constants.PaymentConstants;
   import com.goodgamestudios.marketing.google.CampaignUtils;
   import com.goodgamestudios.tracking.FirstInstanceTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   
   public final class BasicController extends EventDispatcher
   {
      
      public static const COMMAND_INIT_SERVERCOMMANDS:String = "COMMAND_INIT_SERVERCOMMANDS";
      
      public static const COMMAND_EXTENSION_RESPONSE:String = "COMMAND_EXTENSION_RESPONSE";
      
      public static const COMMAND_LOGIN:String = "COMMAND_LOGIN";
      
      public static const COMMAND_LOGOUT:String = "COMMAND_LOGOUT";
      
      public static const COMMAND_CONNECT_CLIENT:String = "COMMAND_CONNECT_CLIENT";
      
      public static const COMMAND_CONNECTION_LOST:String = "COMMAND_CONNECTION_LOST";
      
      public static const COMMAND_CONNECTION_FAILED:String = "COMMAND_CONNECTION_FAILED";
      
      public static const COMMAND_CONNECTION_TIMEOUT:String = "COMMAND_CONNECTION_TIMEOUT";
      
      public static const COMMAND_JOINED_ROOM:String = "COMMAND_JOINED_ROOM";
      
      public static const COMMAND_INITALIZE_CONTROLLER:String = "COMMAND_INITALIZE_CONTROLLER";
      
      public static const COMMAND_REGISTER_USER:String = "COMMAND_REGISTER_USER";
      
      public static const COMMAND_RECONNECT:String = "COMMAND_RECONNECT";
      
      public static const COMMAND_OPEN_FORUM:String = "COMMAND_OPEN_FORUM";
      
      public static const COMMAND_DESTROY_GAME:String = "DESTROY_GAME";
      
      public static const COMMAND_PREPARE_RECONNECT:String = "COMMAND_PREPARE_RECONNECT";
      
      public static const COMMAND_SHOW_REGISTER_DIALOG:String = "COMMAND_SHOW_REGISTER_DIALOG";
      
      public static const COMMAND_LOGIN_JSON:String = "COMMAND_LOGIN_JSON";
      
      public static const COMMAND_REGISTER_USER_JSON:String = "COMMAND_REGISTER_USER_JSON";
      
      public static const COMMAND_INVITE_FRIEND:String = "COMMAND_INVITE_FRIEND";
      
      public static const COMMAND_INVITE_FRIEND_JSON:String = "COMMAND_INVITE_FRIEND_JSON";
      
      public static const COMMAND_INIT_ABTEST:String = "COMMAND_INIT_ABTEST";
      
      public static const COMMAND_INIT_SERVERLIST:String = "COMMAND_INIT_SERVERLIST";
      
      public static var commandDict:Dictionary = new Dictionary();
      
      protected static var basicController:BasicController;
       
      
      public var paymentHash:String;
      
      public var cryptedForumHash:String;
      
      protected var _soundController:BasicSoundController;
      
      protected var waitForServerMessage:Array;
      
      private var enviromentGlobalClass:Class;
      
      public function BasicController(param1:Class)
      {
         this.waitForServerMessage = [];
         super();
         this.enviromentGlobalClass = param1;
         if(basicController)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : BasicController
      {
         if(!basicController)
         {
            throw new Error("Controller not initialized yet!");
         }
         return basicController;
      }
      
      public static function init(param1:Class) : void
      {
         basicController = new BasicController(param1);
      }
      
      public static function get hasBeenInitialized() : Boolean
      {
         return basicController != null;
      }
      
      public final function get soundController() : BasicSoundController
      {
         return this._soundController;
      }
      
      public final function set soundController(param1:BasicSoundController) : void
      {
         this._soundController = param1;
      }
      
      public function onRegistered(param1:BasicUserEvent) : void
      {
         if(this.env.campainVars.isValid())
         {
            CampaignUtils.sendRegisterEvent(this.env.gameId,this.env.campainVars.partnerId);
         }
         var _loc2_:FirstInstanceTrackingEvent = TrackingCache.getInstance().getEvent(FirstInstanceTrackingEvent.EVENT_ID) as FirstInstanceTrackingEvent;
         _loc2_.registered = "1";
         if(BasicTutorialController.isInitialized() && BasicTutorialController.getInstance().tutCompleted)
         {
            this.env.gameState = CommonGameStates.REGISTERED_AND_PLAYING;
         }
      }
      
      public function refreshSocketListener() : void
      {
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECT_SUCCESS))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_SUCCESS,this.onConnectSuccess);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECT_FAILED))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_FAILED,this.onConnectFailed);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECT_TIMEOUT))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_TIMEOUT,this.onConnectTimeout);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.JOINED_ROOM))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.JOINED_ROOM,this.onJoinedRoom);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.EXTENSION_RESPONSE))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.EXTENSION_RESPONSE,this.onExtensionResponse);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECTION_LOST))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECTION_LOST,this.onConnectionLost);
         }
      }
      
      public final function connectClient() : void
      {
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_SUCCESS,this.onConnectSuccess);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_FAILED,this.onConnectFailed);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_TIMEOUT,this.onConnectTimeout);
         CommandController.instance.executeCommand(COMMAND_CONNECT_CLIENT);
      }
      
      public function sendServerMessageVOAndWait(param1:BasicCommandVO, param2:String = "") : void
      {
         this.waitForServerMessage.push(param1.getCmdId());
         BasicModel.smartfoxClient.sendCommandVO(param1);
      }
      
      public function waitForMessage(param1:String) : void
      {
         this.waitForServerMessage.push(param1);
      }
      
      private function onConnectTimeout(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(COMMAND_CONNECTION_TIMEOUT);
      }
      
      private function onConnectFailed(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(COMMAND_CONNECTION_FAILED);
      }
      
      private function onConnectSuccess(param1:SmartfoxEvent) : void
      {
         BasicModel.smartfoxClient.removeEventListener(SmartfoxEvent.CONNECT_SUCCESS,this.onConnectSuccess);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.JOINED_ROOM,this.onJoinedRoom);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.EXTENSION_RESPONSE,this.onExtensionResponse);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECTION_LOST,this.onConnectionLost);
      }
      
      private function onConnectionLost(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(COMMAND_CONNECTION_LOST);
      }
      
      private function onJoinedRoom(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_JOINED_ROOM,param1);
      }
      
      public final function onReconnect() : void
      {
         BasicDialogHandler.getInstance().destroy();
         this.paymentHash = null;
      }
      
      private function onExtensionResponse(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_EXTENSION_RESPONSE,param1);
      }
      
      public final function serverMessageArrived(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(this.waitForServerMessage.indexOf(param1) >= 0)
         {
            this.layoutManager.checkWaitingAnimState(param1);
            _loc2_ = new Array();
            _loc3_ = 0;
            while(_loc3_ < this.waitForServerMessage.length)
            {
               if(this.waitForServerMessage[_loc3_] != param1)
               {
                  _loc2_.push(this.waitForServerMessage[_loc3_]);
               }
               _loc3_++;
            }
            this.waitForServerMessage = _loc2_;
         }
      }
      
      public final function showLoggedinTimeIntervalMessage(param1:BasicUserEvent) : void
      {
         if(param1.params && param1.params.length == 2)
         {
            this.layoutManager.showDialog(CommonDialogNames.StandardOkDialog_NAME,new BasicStandardOkDialogProperties(param1.params.shift(),param1.params.shift()));
         }
      }
      
      public final function saveSoundSettings() : void
      {
         BasicModel.localData.saveSoundSettings([this.soundController.isMusicMuted,1,this.soundController.isEffectsMuted,1]);
      }
      
      public final function loginJson(param1:Object) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN_JSON,param1);
      }
      
      public final function registerJSON(param1:String, param2:String, param3:Object) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_REGISTER_USER_JSON,[param1,param2,param3]);
      }
      
      public final function onClickMoreMoney(param1:Array) : void
      {
         if(BasicModel.userData.isGuest())
         {
            this.layoutManager.showDialog(CommonDialogNames.StandardYesNoDialog_NAME,new BasicStandardYesNoDialogProperties(BasicModel.languageData.getTextById("alert_addgold_title"),BasicModel.languageData.getTextById("alert_addgold_copy"),this.onStartRegisterDialog,null,null,BasicModel.languageData.getTextById("panelwin_login_register"),BasicModel.languageData.getTextById("btn_text_cancle")));
         }
         else
         {
            this.addExtraGold();
         }
      }
      
      public final function onStartRegisterDialog(param1:Array) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_SHOW_REGISTER_DIALOG);
      }
      
      public final function addExtraGold() : void
      {
         this.layoutManager.revertFullscreen();
         if(this.env.requestPayByJS)
         {
            if(!ExternalInterface.available)
            {
               return;
            }
            try
            {
               ExternalInterface.call("requestPayment");
            }
            catch(error:SecurityError)
            {
            }
         }
         else
         {
            this.onOpenPayment();
         }
      }
      
      public final function onOpenPayment() : void
      {
         var urlRequest:URLRequest = null;
         try
         {
            urlRequest = PaymentConstants.getPaymentURLRequest(this.env.language,this.env.gameId,this.env.networkId,this.env.instanceId,this.paymentHash);
            navigateToURL(urlRequest,"goodgamestudios");
         }
         catch(e:Error)
         {
         }
      }
      
      public final function onOpenSuperReward(param1:Array) : void
      {
         var urlRequest:URLRequest = null;
         var params:Array = param1;
         try
         {
            urlRequest = PaymentConstants.getEarnCreditsURLRequest(this.env.earnCredits,this.env.language,this.env.gameId,this.env.networkId,this.env.instanceId,this.paymentHash,params.shift());
            navigateToURL(urlRequest,"goodgamestudios");
         }
         catch(e:Error)
         {
         }
      }
      
      public final function inviteFriend(param1:Array) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_INVITE_FRIEND,param1);
      }
      
      public final function inviteFriendJSON(param1:Array) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_INVITE_FRIEND_JSON,param1);
      }
      
      private function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
      
      public final function sendServerMessageAndWait(param1:String, param2:Array, param3:String) : void
      {
         this.waitForServerMessage.push(param3);
         BasicModel.smartfoxClient.sendMessage(param1,param2);
      }
      
      public final function sendCommandVOAndWait(param1:BasicCommandVO) : void
      {
         this.waitForServerMessage.push(param1.getCmdId());
         BasicModel.smartfoxClient.sendCommandVO(param1);
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new this.enviromentGlobalClass();
      }
   }
}
