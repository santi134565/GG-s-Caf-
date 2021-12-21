package com.goodgamestudios.basic
{
   import com.goodgamestudios.abTesting.ABTestController;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitABTestCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitServerListCommand;
   import com.goodgamestudios.basic.event.BasicFirstVisitEvent;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicLoaderData;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.basic.view.firstVisit.ExtraScreenMovieClip;
   import com.goodgamestudios.basic.vo.ServerVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.constants.CommonGameStates;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.cookie.AccountCookie;
   import com.goodgamestudios.loading.LoaderObject;
   import com.goodgamestudios.logging.GoodgameLogger;
   import com.goodgamestudios.marketing.google.CampaignVars;
   import com.goodgamestudios.tracking.ConnectionTrackingEvent;
   import com.goodgamestudios.tracking.FirstInstanceTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import com.goodgamestudios.utils.ExternalInterfaceUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.net.URLLoaderDataFormat;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class BasicFrameOne extends MovieClip
   {
      
      private static const logger:ILogger = Log.getLogger("BasicFrameOne.as");
       
      
      protected var preloaderView:BasicBackgroundComponent;
      
      protected var preloaderUpdateTimer:Timer;
      
      protected var firstVisitSreen:ExtraScreenMovieClip;
      
      private var sessionStartTime:Number;
      
      private var appLogger:GoodgameLogger;
      
      private var networkCookie:SharedObject;
      
      public function BasicFrameOne()
      {
         this.preloaderUpdateTimer = new Timer(100);
         super();
         Security.allowDomain("*");
         this.sessionStartTime = getTimer();
         this.initPreClientCommands();
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      protected function initPreClientCommands() : void
      {
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_ABTEST,BasicInitABTestCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_SERVERLIST,BasicInitServerListCommand);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         this.env.isTest = this.loaderInfo.url.indexOf(BasicConstants.CACHEBREAKER_TEST_FOLDER) != -1;
         this.env.isLocal = this.loaderInfo.url.indexOf(BasicConstants.LOCALE_URL) == 0;
         this.env.initBaseUrl(this.loaderInfo.url);
         if(this.env.isLocal || this.env.isTest)
         {
            if(this.env.isLoggingActive)
            {
               this.appLogger = new GoodgameLogger();
            }
         }
         var _loc2_:Object = ExternalInterfaceUtils.getUrlVariables();
         this.env.campainVars = new CampaignVars(_loc2_);
         this.env.networkId = !!stage.loaderInfo.parameters.network ? int(int(stage.loaderInfo.parameters.network)) : int(GoodgamePartners.NETWORK_GENERAL);
         this.env.flashVarLanguage = !!stage.loaderInfo.parameters.lang ? String(stage.loaderInfo.parameters.lang) : "";
         this.env.instanceId = !!stage.loaderInfo.parameters.instance ? int(int(stage.loaderInfo.parameters.instance)) : 0;
         this.env.accessKey = !!stage.loaderInfo.parameters.key ? stage.loaderInfo.parameters.key : "";
         this.env.gender = !!stage.loaderInfo.parameters.gender ? stage.loaderInfo.parameters.gender : "";
         this.env.displayName = !!stage.loaderInfo.parameters.displayName ? stage.loaderInfo.parameters.displayName : "";
         this.env.pln = !!stage.loaderInfo.parameters.pln ? stage.loaderInfo.parameters.pln : "";
         this.env.sig = !!stage.loaderInfo.parameters.sig ? stage.loaderInfo.parameters.sig : "";
         if(this.env.isLocal)
         {
            this.env.distributorId = "0";
            this.env.referrer = "localhost";
         }
         else
         {
            this.env.isFirstVisit = this.isCookieEmpty(SharedObject.getLocal(this.env.cookieName,"/"));
            if(this.env.isFirstVisit && this.env.networkId == GoodgamePartners.NETWORK_DEFAULT)
            {
               ExternalInterfaceUtils.addWindowEventCallback("onbeforeunload",this.onBeforeUnloadWindow);
               logger.debug("first visit of client!");
            }
         }
         BasicModel.basicLoaderData = new BasicLoaderData();
         BasicModel.basicLoaderData.appLoader.loadingQueueElementStarted.add(this.handleNewLoadingElementStarted);
         BasicModel.basicLoaderData.assetLoader.loadingQueueElementStarted.add(this.handleNewLoadingElementStarted);
         BasicModel.basicLoaderData.appLoader.loadingQueueElementFinished.add(this.handleLoadingElementFinished);
         BasicModel.basicLoaderData.assetLoader.loadingQueueElementFinished.add(this.handleLoadingElementFinished);
         BasicModel.basicLoaderData.appLoader.addSWFLoader(BasicConstants.ACCOUNT_COOKIE_LOADER,this.env.accountCookieUrl,null,null,this.onAccountCookieComplete);
         this.getCookies();
      }
      
      private function onBeforeUnloadWindow(param1:Event = null) : String
      {
         var _loc2_:FirstInstanceTrackingEvent = null;
         if(TrackingCache.getInstance().isInitialized)
         {
            _loc2_ = TrackingCache.getInstance().getEvent(FirstInstanceTrackingEvent.EVENT_ID) as FirstInstanceTrackingEvent;
            _loc2_.gameState = this.env.gameState;
            _loc2_.registered = "0";
            _loc2_.sessionLength = ((getTimer() - this.sessionStartTime) / 1000).toFixed();
            _loc2_.tutorialLength = "0";
            TrackingCache.getInstance().sendEvent(FirstInstanceTrackingEvent.EVENT_ID);
         }
         return "Please try again later!";
      }
      
      private function getCookies() : void
      {
         this.networkCookie = SharedObject.getLocal(this.env.cookieName,"/");
         if(this.networkCookie.data.language)
         {
            this.env.language = this.networkCookie.data.language as String;
            if(this.env.availableLanguages.indexOf(this.env.language) == -1)
            {
               this.env.language == this.env.standardLanguage;
            }
         }
         else
         {
            this.env.language = null;
         }
      }
      
      private function onAccountCookieComplete() : void
      {
         var cookieObject:Object = null;
         var accountCookie:AccountCookie = null;
         try
         {
            cookieObject = BasicModel.basicLoaderData.appLoader.getLoaderData("accountCookie") as Object;
            accountCookie = new AccountCookie(cookieObject.getSharedObject("GGSAccount"));
            this.env.accountId = accountCookie.accountId;
         }
         catch(e:Error)
         {
            logger.fatal("Reading account cookie failed: " + e.message);
         }
         TrackingCache.getInstance().init(this.env.gameId,this.env.networkId,this.env.referrer,Capabilities.language,this.env.accountId);
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.NETWORK_INFO_LOADER,this.env.networkInfoUrl,URLLoaderDataFormat.BINARY,this.onNetworkInfoLoaded);
         this.env.gameState = CommonGameStates.LOAD_NETWORK;
      }
      
      private function onNetworkInfoLoaded() : void
      {
         var _loc1_:XML = XML(BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.NETWORK_INFO_LOADER));
         var _loc2_:XMLList = _loc1_["instances"].children();
         this.env.defaultInstanceId = parseInt(_loc1_.general.defaultinstance.text());
         this.env.testConnectIP = _loc1_.testserver.testserver.text();
         this.env.testConnectPort = _loc1_.testserver.testport.text();
         this.env.testSmartfoxZone = _loc1_.testserver.testzone.text();
         CommandController.instance.executeCommand(BasicController.COMMAND_INIT_SERVERLIST,{"serverInstances":_loc2_});
         this.env.allowedfullscreen = _loc1_.general.allowedfullscreen == "true" ? true : false;
         this.env.networknameString = _loc1_.general.networkname.text();
         this.env.loginIsKeyBased = _loc1_.general.usekeybaselogin == "true" ? true : false;
         this.env.hasNetworkBuddies = _loc1_.general.networkbuddies == "true" ? true : false;
         this.env.enableFeedMessages = _loc1_.general.enablefeedmessages == "true" ? true : false;
         this.env.enableLonelyCow = _loc1_.general.enablelonelycow == "true" ? true : false;
         this.env.requestPayByJS = _loc1_.general.requestpaybyjs == "true" ? true : false;
         this.env.networkNewsByJS = _loc1_.general.networknewsbyjs == "true" ? true : false;
         this.env.earnCredits = parseInt(_loc1_.general.earncredits);
         this.env.useexternallinks = _loc1_.general.useexternallinks == "true" ? true : false;
         this.env.invitefriends = _loc1_.general.invitefriends == "true" ? true : false;
         this.env.maxUsernameLength = parseInt(_loc1_.general.maxusernamelength.text());
         this.env.usePayment = _loc1_.general.usepayment == "true" ? true : false;
         this.env.showVersion = _loc1_.general.showversion == "true" ? true : false;
         if(this.env.useABTest)
         {
            this.loadABTestConfig();
         }
         else
         {
            this.loadLangProps();
         }
      }
      
      private function loadABTestConfig() : void
      {
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.AB_CONFIG_LOADER,this.env.abTestConfigURL,URLLoaderDataFormat.BINARY,this.onABConfigLoaded);
         this.env.gameState = CommonGameStates.LOAD_AB_TEST_CONFIG;
      }
      
      private function onABConfigLoaded() : void
      {
         var _loc2_:int = 0;
         var _loc1_:XML = XML(BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.AB_CONFIG_LOADER));
         if(this.networkCookie.data.userID)
         {
            _loc2_ = int(this.networkCookie.data.userID);
         }
         else
         {
            _loc2_ = -1;
         }
         ABTestController.instance.initialize(_loc1_,this.env.gameId,this.env.instanceId,this.env.networkId,_loc2_);
         this.loadLangProps();
         CommandController.instance.executeCommand(BasicController.COMMAND_INIT_ABTEST);
      }
      
      private function loadLangProps() : void
      {
         this.createView();
         if(!this.preloaderView)
         {
            logger.fatal("no preloaderview defined in concrete project");
         }
         this.preloaderView.showProgressBar();
         addChild(this.preloaderView.disp);
         this.preloaderUpdateTimer.addEventListener(TimerEvent.TIMER,this.onUpdatePreloaderView);
         this.preloaderUpdateTimer.start();
         this.preloaderView.showVersion();
         this.preloaderView.updatePosition();
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.LANGUAGE_PROP_LOADER,this.env.languagePropertiesUrl,URLLoaderDataFormat.BINARY,this.onLanguagePropertiesLoaded);
         this.env.gameState = CommonGameStates.LOAD_LANG_PROPS;
      }
      
      private function getInstanceByLanguage() : int
      {
         var _loc2_:ServerVO = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.env.sfsServerList)
         {
            if(this.env.language == _loc2_.defaultLanguage)
            {
               _loc1_ = _loc2_.instanceId;
            }
         }
         return _loc1_;
      }
      
      private function selectInstance(param1:int) : Boolean
      {
         var _loc2_:ServerVO = null;
         for each(_loc2_ in this.env.sfsServerList)
         {
            if(_loc2_.instanceId == param1)
            {
               this.env.instanceId = param1;
               this.env.connectIP = _loc2_.ip;
               this.env.connectPort = _loc2_.port;
               this.env.smartfoxZone = _loc2_.extension;
               this.env.defaultLanguage = _loc2_.defaultLanguage;
               return true;
            }
         }
         throw new Error("Unknown Instance: Check NetworkXML and flashvar params");
      }
      
      private function onLanguagePropertiesLoaded() : void
      {
         var _loc7_:Array = null;
         this.env.langVersionDict = new Dictionary();
         var _loc1_:String = BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.LANGUAGE_PROP_LOADER).toString();
         var _loc2_:RegExp = /.*=([0-9]+)/ig;
         var _loc3_:Array = _loc1_.match(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc7_ = _loc3_[_loc4_].toString().split("=");
            this.env.langVersionDict[_loc7_[0]] = _loc7_[1];
            _loc4_++;
         }
         var _loc5_:String = Capabilities.language.replace("-","_");
         var _loc6_:String = this.env.language;
         if(this.env.language == null)
         {
            if(this.env.flashVarLanguage != "")
            {
               this.env.language = this.env.availableLanguages.indexOf(this.env.flashVarLanguage) > -1 ? this.env.flashVarLanguage : this.env.standardLanguage;
            }
            else
            {
               this.env.language = this.env.availableLanguages.indexOf(_loc5_) > -1 ? _loc5_ : this.env.standardLanguage;
            }
         }
         if(this.env.instanceId == 0)
         {
            this.env.instanceId = this.getInstanceByLanguage();
            if(this.env.instanceId == 0)
            {
               this.selectInstance(this.env.defaultInstanceId);
            }
            else
            {
               this.selectInstance(this.env.instanceId);
            }
         }
         else
         {
            this.env.forceInstanceConnect = true;
            this.selectInstance(this.env.instanceId);
         }
         if(this.env.defaultLanguage != "default" && !_loc6_)
         {
            this.env.language = this.env.availableLanguages.indexOf(this.env.defaultLanguage) > -1 ? this.env.defaultLanguage : this.env.standardLanguage;
         }
         this.initLanguage();
         BasicModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLComplete);
         this.env.gameState = CommonGameStates.LOAD_LANG;
      }
      
      protected function initLanguage() : void
      {
      }
      
      private function onLanguageXMLComplete(param1:LanguageDataEvent) : void
      {
         BasicModel.languageData.removeEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLComplete);
         BasicModel.basicLoaderData.appLoader.loadingQueueFirstTimeFinished.add(this.loadingQueueAppLoaderFinished);
         this.showFirstScreen();
         if(this.loaderInfo.bytesLoaded != this.loaderInfo.bytesTotal)
         {
            logger.debug("the loader of BasicFrameOne is not completed at the moment!");
            BasicModel.basicLoaderData.appLoader.addLoaderInfoObject(BasicConstants.BASIC_FRAME_ONE_LOADER,this.loaderInfo,this.onComplete);
         }
         else
         {
            this.onComplete();
         }
         this.env.gameState = CommonGameStates.LOAD_GAME;
      }
      
      protected function showFirstScreen() : void
      {
      }
      
      protected function initFirstVisitScreen(param1:ExtraScreenMovieClip) : void
      {
         this.firstVisitSreen = param1;
         this.firstVisitSreen.addEventListener(BasicFirstVisitEvent.AVATARCREATION_FINISHED,this.onFirstVisitAvatarCreationFinished);
         addChild(this.firstVisitSreen.disp);
         setChildIndex(this.preloaderView.disp,0);
         this.preloaderView.hideProgressBar();
      }
      
      protected function onFirstVisitAvatarCreationFinished(param1:BasicFirstVisitEvent) : void
      {
         removeChild(this.firstVisitSreen.disp);
         this.firstVisitSreen.removeEventListener(BasicFirstVisitEvent.AVATARCREATION_FINISHED,this.onFirstVisitAvatarCreationFinished);
         this.firstVisitSreen = null;
         if(BasicModel.basicLoaderData.appLoader.isComplete)
         {
            this.goToSecondFrame();
         }
         else
         {
            this.preloaderView.showProgressBar();
         }
      }
      
      protected function loadingQueueAppLoaderFinished(param1:String) : void
      {
         if(!this.firstVisitSreen)
         {
            this.goToSecondFrame();
         }
      }
      
      protected function loadAssets() : void
      {
         this.env.gameState = CommonGameStates.LOAD_ASSETS;
         var _loc1_:int = 1;
         while(_loc1_ <= this.env.numOfItemLibs)
         {
            BasicModel.basicLoaderData.assetLoader.addSWFLoader("itemLib" + _loc1_,this.env.getItemSwfUrl(_loc1_));
            _loc1_++;
         }
      }
      
      protected final function isCookieEmpty(param1:SharedObject) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = param1.data;
         for(_loc2_ in _loc4_)
         {
            return false;
         }
         return true;
      }
      
      protected function createView() : void
      {
      }
      
      protected function get mainGameClassName() : String
      {
         return "com.goodgamestudios.basic.BasicGame";
      }
      
      protected function onUpdatePreloaderView(param1:TimerEvent) : void
      {
         var _loc2_:Number = NaN;
         if(BasicModel.basicLoaderData.appLoader.isLoading || BasicModel.basicLoaderData.assetLoader.isLoading)
         {
            _loc2_ = 0;
            if(BasicModel.basicLoaderData.assetLoader.isLoading)
            {
               _loc2_ = BasicModel.basicLoaderData.assetLoader.getProgressOfActualSubloader();
            }
            else if(BasicModel.basicLoaderData.appLoader.isLoading)
            {
               _loc2_ = BasicModel.basicLoaderData.appLoader.getProgressOfActualSubloader();
            }
            if(this.preloaderView)
            {
               this.preloaderView.updateLoadingProgress(Math.round(_loc2_ * 100));
            }
         }
      }
      
      protected function handleNewLoadingElementStarted(param1:String, param2:String) : void
      {
         var _loc3_:LoaderObject = null;
         logger.debug("new loading element started " + param1 + " " + param2);
         if(this.preloaderView && this.preloaderView.disp)
         {
            if(param1 == BasicModel.basicLoaderData.assetLoader.loaderID)
            {
               _loc3_ = BasicModel.basicLoaderData.assetLoader.getLoaderObject(param2);
            }
            else
            {
               _loc3_ = BasicModel.basicLoaderData.appLoader.getLoaderObject(param2);
            }
            if(_loc3_)
            {
               if(_loc3_.totalBytes > BasicConstants.MAX_FILESIZE_REALTIMELOADING)
               {
                  this.preloaderUpdateTimer.stop();
                  this.preloaderUpdateTimer.removeEventListener(TimerEvent.TIMER,this.onUpdatePreloaderView);
                  this.preloaderView.startProgressBar();
               }
               else
               {
                  this.preloaderView.stopProgressBar();
                  if(!this.preloaderUpdateTimer.running)
                  {
                     this.preloaderUpdateTimer.addEventListener(TimerEvent.TIMER,this.onUpdatePreloaderView);
                     this.preloaderUpdateTimer.start();
                  }
                  this.preloaderView.updateLoadingText(param2);
               }
            }
         }
      }
      
      protected function handleLoadingElementFinished(param1:String, param2:String) : void
      {
         if(this.preloaderView)
         {
            this.preloaderView.updateLoadingProgress(100);
         }
      }
      
      protected function goToSecondFrame() : void
      {
         var GameClass:Class = null;
         var event:ConnectionTrackingEvent = null;
         var game:DisplayObject = null;
         try
         {
            nextFrame();
            GameClass = Class(getDefinitionByName(this.mainGameClassName));
            if(GameClass)
            {
               event = TrackingCache.getInstance().getEvent(ConnectionTrackingEvent.EVENT_ID) as ConnectionTrackingEvent;
               if(event != null)
               {
                  event.downloadRate = BasicModel.basicLoaderData.appLoader.calculateDataRate();
               }
               else
               {
                  logger.fatal("cannot retrive ConnectionTrackingEvent");
               }
               this.loadAssets();
               game = new GameClass(this.preloaderView) as DisplayObject;
               addChild(game);
            }
         }
         catch(e:Error)
         {
            env.gameState = CommonGameStates.LOAD_GAME;
            logger.fatal(e.message);
         }
      }
      
      protected function onComplete(param1:Event = null) : void
      {
         var savedCookie:SharedObject = null;
         var event:Event = param1;
         this.loadXMLs();
         if(this.loaderInfo.url == this.env.cookieSaverUrl)
         {
            try
            {
               savedCookie = (this.loaderInfo.content as Object).getSharedObject("Goodgame" + this.env.gameTitle);
               this.copyCookie(savedCookie);
            }
            catch(e:Error)
            {
               logger.fatal("Reading saved cookie failed: " + e.message);
            }
         }
      }
      
      protected function loadXMLs() : void
      {
      }
      
      protected function copyCookie(param1:SharedObject) : void
      {
         var _loc2_:SharedObject = null;
         var _loc3_:* = null;
         if(param1)
         {
            _loc2_ = SharedObject.getLocal(this.env.cookieName,"/");
            for(_loc3_ in param1.data)
            {
               _loc2_.data[_loc3_] = param1.data[_loc3_];
            }
            _loc2_.flush();
         }
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnviromentGlobalsHandler.globals;
      }
   }
}
