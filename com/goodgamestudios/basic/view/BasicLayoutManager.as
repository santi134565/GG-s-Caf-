package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.dialogs.BasicDialog;
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.panels.BasicPanel;
   import com.goodgamestudios.basic.view.screens.BasicScreen;
   import com.goodgamestudios.constants.CommonGameStates;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.utils.MouseWheel;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class BasicLayoutManager extends Sprite
   {
      
      public static const STATE_PRELOAD_INIT:int = -1;
      
      public static const STATE_PRELOAD_CONNECTED:int = 0;
      
      public static const STATE_CONNECT:int = 1;
      
      public static const STATE_LOGIN:int = 2;
      
      public static const STATE_AVATAR_CREATION:int = 3;
      
      public static const STATE_LOAD_ITEMS:int = 4;
      
      public static const STATE_REGISTRATION:int = 5;
      
      public static const QUALITY_HIGH:int = 0;
      
      public static const QUALITY_MEDIUM:int = 1;
      
      public static const QUALITY_LOW:int = 2;
      
      protected static var layoutManager:BasicLayoutManager;
       
      
      protected var backgroundLayer:Sprite;
      
      protected var _backgroundComponent:BasicBackgroundComponent;
      
      protected var screenLayer:Sprite;
      
      protected var adminLayer:Sprite;
      
      protected var dialogLayer:Sprite;
      
      protected var panelLayer:Sprite;
      
      protected var tutorialLayer:Sprite;
      
      protected var tooltipLayer:Sprite;
      
      protected var mouseLayer:Sprite;
      
      protected var panels:Dictionary;
      
      protected var screens:Dictionary;
      
      protected var dialogs:Array;
      
      protected var _currentState:int;
      
      private var _initialized:Boolean;
      
      private var mouseWheel:MouseWheel;
      
      private var stats:Stats;
      
      private var animatedDisplayObjects:Array;
      
      private var animatedFlashUIComponents:Array;
      
      public var customCursor:BasicCustomCursor;
      
      public var dragManager:BasicDragManager;
      
      public function BasicLayoutManager()
      {
         this.animatedDisplayObjects = [];
         this.animatedFlashUIComponents = [];
         super();
         this._initialized = false;
         if(layoutManager)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : BasicLayoutManager
      {
         if(!layoutManager)
         {
            throw new Error("LayoutManager is not initialized!");
         }
         return layoutManager;
      }
      
      protected function onMouseUp(param1:Event) : void
      {
         if(this.dragManager)
         {
            this.dragManager.stopDragging();
         }
      }
      
      public function initialize(param1:BasicBackgroundComponent) : void
      {
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this.dialogs = new Array();
         this.panels = new Dictionary();
         this.screens = new Dictionary();
         this._currentState = 0;
         this.adminLayer = new Sprite();
         this.screenLayer = new Sprite();
         this.panelLayer = new Sprite();
         this.dialogLayer = new Sprite();
         this.tutorialLayer = new Sprite();
         this.tooltipLayer = new Sprite();
         this.mouseLayer = new Sprite();
         this.mouseLayer.mouseChildren = false;
         this.mouseLayer.mouseEnabled = false;
         this.backgroundLayer = new Sprite();
         this._backgroundComponent = param1;
         if(this._backgroundComponent)
         {
            (this._backgroundComponent.disp as Sprite).mouseEnabled = true;
            (this._backgroundComponent.disp as Sprite).mouseChildren = true;
            this.backgroundLayer.addChild(this._backgroundComponent.disp);
            if(this._backgroundComponent.customCursor)
            {
               this.customCursor = this._backgroundComponent.customCursor;
               this.mouseLayer.addChild(this.customCursor.disp);
            }
         }
         this._initialized = true;
      }
      
      public function get initialized() : Boolean
      {
         return this._initialized;
      }
      
      public function set state(param1:int) : void
      {
         switch(param1)
         {
            case STATE_LOAD_ITEMS:
               this.hideAllDialogs();
               this.hideAllPanels();
               this.showBackgroundLayer();
               this._backgroundComponent.showProgressBar();
               this.env.gameState = CommonGameStates.LOAD_ASSETS;
               break;
            case STATE_CONNECT:
               this.hideAllDialogs();
               this.hideAllPanels();
               this.showBackgroundLayer();
               break;
            case STATE_LOGIN:
               this.hideAllPanels();
               this.showBackgroundLayer();
               this.env.gameState = CommonGameStates.LOGIN_SCREEN;
         }
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         var _loc2_:AnimatedDisplayObject = null;
         var _loc3_:AnimatedFlashUIComponent = null;
         for each(_loc2_ in this.animatedDisplayObjects)
         {
            _loc2_.playForward();
         }
         for each(_loc3_ in this.animatedFlashUIComponents)
         {
            _loc3_.onEnterFrameUpdate();
         }
      }
      
      public function addAniDo(param1:AnimatedDisplayObject) : void
      {
         this.animatedDisplayObjects.push(param1);
      }
      
      public function addAnimFlashUIComponent(param1:AnimatedFlashUIComponent) : void
      {
         this.animatedFlashUIComponents.push(param1);
      }
      
      public function removeAniDo(param1:AnimatedDisplayObject) : void
      {
         var _loc3_:AnimatedDisplayObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.animatedDisplayObjects.length)
         {
            _loc3_ = this.animatedDisplayObjects[_loc2_] as AnimatedDisplayObject;
            if(_loc3_ == param1)
            {
               this.animatedDisplayObjects.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      public function removeAnimFlashUIComponent(param1:FlashUIComponent) : void
      {
         var _loc3_:FlashUIComponent = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.animatedFlashUIComponents.length)
         {
            _loc3_ = this.animatedFlashUIComponents[_loc2_] as FlashUIComponent;
            if(_loc3_ == param1)
            {
               this.animatedFlashUIComponents.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.mouseWheel = new MouseWheel(stage);
      }
      
      public function changeQualityLevel(param1:int) : void
      {
         switch(param1)
         {
            case QUALITY_HIGH:
            default:
               layoutManager.stage.quality = StageQuality.BEST;
               break;
            case QUALITY_MEDIUM:
               layoutManager.stage.quality = StageQuality.MEDIUM;
               break;
            case QUALITY_LOW:
               layoutManager.stage.quality = StageQuality.LOW;
         }
      }
      
      private function getDialogIndex(param1:String) : int
      {
         var _loc3_:BasicDialog = null;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.dialogs.length)
         {
            _loc3_ = this.dialogs[_loc2_];
            _loc4_ = getQualifiedClassName(_loc3_);
            _loc4_ = _loc4_.slice(_loc4_.indexOf("::") + 2,_loc4_.length);
            if(param1 == _loc4_)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function showDialog(param1:String, param2:BasicDialogProperties = null) : void
      {
         var _loc3_:BasicDialog = null;
         var _loc4_:int = 0;
         _loc3_ = this.createFlashComponent(param1) as BasicDialog;
         if(_loc3_.isUnique)
         {
            if((_loc4_ = this.getDialogIndex(param1)) >= 0)
            {
               _loc3_ = this.dialogs[_loc4_];
            }
            else
            {
               this.dialogs.push(_loc3_);
            }
            _loc3_.setProperties(param2);
            if(_loc3_.disp.parent != this.dialogLayer)
            {
               this.dialogLayer.addChild(_loc3_.disp);
            }
            this.dialogLayer.setChildIndex(_loc3_.disp,this.dialogLayer.numChildren - 1);
         }
         else
         {
            _loc3_.setProperties(param2);
            this.dialogLayer.addChild(_loc3_.disp);
            this.dialogs.push(_loc3_);
         }
         _loc3_.show();
      }
      
      public function showAdminDialog(param1:String, param2:BasicDialogProperties = null) : void
      {
         var _loc3_:BasicDialog = null;
         var _loc4_:int = 0;
         _loc3_ = this.createFlashComponent(param1) as BasicDialog;
         if(_loc3_.isUnique)
         {
            if((_loc4_ = this.getDialogIndex(param1)) >= 0)
            {
               _loc3_ = this.dialogs[_loc4_];
            }
            _loc3_.setProperties(param2);
            if(_loc3_.disp.parent != this.adminLayer)
            {
               this.adminLayer.addChild(_loc3_.disp);
            }
            this.adminLayer.setChildIndex(_loc3_.disp,this.adminLayer.numChildren - 1);
         }
         else
         {
            _loc3_.setProperties(param2);
            this.dialogLayer.addChild(_loc3_.disp);
         }
         this.dialogs.push(_loc3_);
         _loc3_.show();
      }
      
      public function hideAllDialogs() : void
      {
         var _loc1_:BasicDialog = null;
         for each(_loc1_ in this.dialogs)
         {
            _loc1_.hide();
         }
      }
      
      public function hideDialog(param1:Class) : void
      {
         var _loc2_:BasicDialog = null;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ is param1)
            {
               _loc2_.hide();
            }
         }
      }
      
      public function clearAllDialogs() : void
      {
         var _loc1_:BasicDialog = null;
         for each(_loc1_ in this.dialogs)
         {
            _loc1_.hide();
            _loc1_.destroy();
            if(_loc1_.disp && _loc1_.disp.parent == this.dialogLayer)
            {
               this.dialogLayer.removeChild(_loc1_.disp);
            }
            if(_loc1_.disp && _loc1_.disp.parent == this.adminLayer)
            {
               this.adminLayer.removeChild(_loc1_.disp);
            }
         }
         this.dialogs = new Array();
      }
      
      public function showScreen(param1:String, param2:BasicDialogProperties = null) : BasicScreen
      {
         var _loc3_:BasicScreen = null;
         if(this.screens[param1])
         {
            _loc3_ = this.screens[param1] as BasicScreen;
            _loc3_.setProperties(param2);
         }
         else
         {
            _loc3_ = this.createFlashComponent(param1) as BasicScreen;
            this.screens[param1] = _loc3_;
            _loc3_.setProperties(param2);
            this.screenLayer.addChild(_loc3_.disp);
         }
         _loc3_.show();
         return _loc3_;
      }
      
      public function hideScreen(param1:String) : void
      {
         var _loc2_:BasicScreen = null;
         if(this.screens[param1])
         {
            _loc2_ = this.screens[param1] as BasicScreen;
            _loc2_.hide();
         }
      }
      
      public function hideAllScreens() : void
      {
         var _loc1_:BasicScreen = null;
         for each(_loc1_ in this.screens)
         {
            if(_loc1_.isVisible())
            {
               _loc1_.hide();
            }
         }
      }
      
      public function onTopScreen(param1:String) : void
      {
         var _loc2_:BasicScreen = null;
         if(this.screens[param1])
         {
            _loc2_ = this.screens[param1] as BasicScreen;
            this.screenLayer.setChildIndex(_loc2_.disp,this.screenLayer.numChildren - 1);
         }
      }
      
      public function clearAllScreens() : void
      {
         var _loc1_:BasicScreen = null;
         for each(_loc1_ in this.screens)
         {
            _loc1_.hide();
            _loc1_.destroy();
            this.screenLayer.removeChild(_loc1_.disp);
         }
         this.screens = new Dictionary();
      }
      
      public function showPanel(param1:String, param2:BasicDialogProperties = null) : void
      {
         var _loc3_:BasicPanel = null;
         if(this.panels[param1])
         {
            _loc3_ = this.panels[param1] as BasicPanel;
         }
         else
         {
            _loc3_ = this.createFlashComponent(param1) as BasicPanel;
            this.panels[param1] = _loc3_;
            _loc3_.setProperties(param2);
            this.panelLayer.addChild(_loc3_.disp);
            _loc3_.disp.visible = false;
         }
         if(!_loc3_.isVisible())
         {
            _loc3_.show();
         }
      }
      
      public function hidePanel(param1:String) : void
      {
         var _loc2_:BasicPanel = null;
         if(this.panels[param1])
         {
            _loc2_ = this.panels[param1] as BasicPanel;
            _loc2_.hide();
         }
      }
      
      public function clearAllPanels() : void
      {
         var _loc1_:BasicPanel = null;
         for each(_loc1_ in this.panels)
         {
            _loc1_.hide();
            _loc1_.destroy();
            this.panelLayer.removeChild(_loc1_.disp);
         }
         this.panels = new Dictionary();
      }
      
      public function hideAllPanels() : void
      {
         var _loc1_:BasicPanel = null;
         for each(_loc1_ in this.panels)
         {
            _loc1_.hide();
         }
      }
      
      public function lockPanel(param1:String) : void
      {
         var _loc2_:BasicPanel = null;
         if(this.panels[param1])
         {
            _loc2_ = this.panels[param1] as BasicPanel;
            _loc2_.lockPanel();
         }
      }
      
      public function unLockPanel(param1:String) : void
      {
         var _loc2_:BasicPanel = null;
         if(this.panels[param1])
         {
            _loc2_ = this.panels[param1] as BasicPanel;
            _loc2_.unLockPanel();
         }
      }
      
      public function existsDialog(param1:Class) : Boolean
      {
         var _loc2_:BasicDialog = null;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ && _loc2_ is param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isPanelVisible(param1:Class) : Boolean
      {
         var _loc2_:BasicPanel = null;
         for each(_loc2_ in this.panels)
         {
            if(_loc2_ && _loc2_ is param1)
            {
               return _loc2_.isVisible();
            }
         }
         return false;
      }
      
      public function isDialogVisible(param1:Class) : Boolean
      {
         var _loc2_:BasicDialog = null;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ && _loc2_ is param1)
            {
               return _loc2_.isVisible();
            }
         }
         return false;
      }
      
      public function get numVisibleDialogs() : int
      {
         var _loc2_:BasicDialog = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ && _loc2_.isVisible())
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function clearAllLayoutContent() : void
      {
         this.clearAllPanels();
         this.clearAllDialogs();
         this.clearAllScreens();
      }
      
      protected function createFlashComponent(param1:String) : FlashUIComponent
      {
         return null;
      }
      
      public function checkWaitingAnimState(param1:String) : void
      {
         var _loc2_:BasicDialog = null;
         var _loc3_:BasicPanel = null;
         var _loc4_:BasicScreen = null;
         for each(_loc2_ in this.dialogs)
         {
            _loc2_.checkWaitingAnimState(param1);
         }
         for each(_loc3_ in this.panels)
         {
            _loc3_.checkWaitingAnimState(param1);
         }
         for each(_loc4_ in this.screens)
         {
            _loc4_.checkWaitingAnimState(param1);
         }
      }
      
      public function toggleFullscreen() : void
      {
         if(stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
         else
         {
            try
            {
               stage.displayState = StageDisplayState.FULL_SCREEN;
            }
            catch(error:Error)
            {
               showDialog(CommonDialogNames.StandardOkDialog_NAME,new BasicStandardOkDialogProperties(BasicModel.languageData.getTextById("fullscreenerror_msg_title"),BasicModel.languageData.getTextById("fullscreenerror_msg_copy")));
            }
         }
      }
      
      public function revertFullscreen() : void
      {
         if(stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
      }
      
      public function showFPS() : void
      {
         this.stats = new Stats();
         this.adminLayer.addChild(this.stats);
      }
      
      public function hideFPS() : void
      {
         this.adminLayer.removeChild(this.stats);
         this.stats = null;
      }
      
      public function isFPSshown() : Boolean
      {
         return this.stats != null;
      }
      
      public function onEndProgressbar() : void
      {
         this._backgroundComponent.hideProgressBar();
      }
      
      public function onStartProgressbar() : void
      {
         this._backgroundComponent.show();
         this._backgroundComponent.showProgressBar();
      }
      
      public function get inGameState() : Boolean
      {
         return this._currentState >= 10;
      }
      
      public function get outGameState() : Boolean
      {
         return this._currentState < 10;
      }
      
      public function get currentState() : int
      {
         return this._currentState;
      }
      
      public function showBackgroundLayer() : void
      {
         this._backgroundComponent.show();
      }
      
      public function showServerAndClientVersion() : void
      {
         this._backgroundComponent.showVersion();
      }
      
      public function hideBackgroundLayer() : void
      {
         this._backgroundComponent.hide();
      }
      
      public function get scaleFactor() : Number
      {
         return (this._backgroundComponent as BasicBackgroundComponent).scaleFactor;
      }
      
      public function get gameNullPoint() : Number
      {
         return (this._backgroundComponent as BasicBackgroundComponent).gameNullPoint;
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return null;
      }
   }
}
