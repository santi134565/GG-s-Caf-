package com.goodgamestudios.isocore
{
   import com.goodgamestudios.input.Input;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.map.IsoMap;
   import com.goodgamestudios.isocore.objects.IDraggable;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.objects.IsoStaticObject;
   import com.goodgamestudios.isocore.vo.LevelVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.Sprite;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class IsoWorld extends Sprite implements IIsoWorld
   {
       
      
      private var _map:IsoMap;
      
      private var _controlLock:Boolean = false;
      
      private var _updateCamera:Boolean = false;
      
      private var _mouse:IsoMouse;
      
      protected var _background:IsoBackground;
      
      private var _running:Boolean = false;
      
      private var _pause:Boolean = false;
      
      private var _lastUpdate:Number;
      
      private var _levelObjects:Array;
      
      private var _camera:IsoCamera;
      
      private var _isoObjects:Array;
      
      private var _worldStatus:int = -1;
      
      public var allMutableReferences:Array;
      
      public var allImmutableReferences:Array;
      
      private var _worldLayer:Sprite;
      
      private var _backgroundLayer:Sprite;
      
      private var _floorLayer:Sprite;
      
      private var _floorTileLayer:Sprite;
      
      protected var _floorBuyTilesLayer:Sprite;
      
      private var _objectLayer:Sprite;
      
      private var _toolTipLayer:Sprite;
      
      private var _input:Input;
      
      private var _zSortThisFrame:Boolean = false;
      
      private var _levelData:LevelVO;
      
      public function IsoWorld()
      {
         this._levelObjects = [];
         this._isoObjects = [];
         this.allMutableReferences = [];
         this.allImmutableReferences = [];
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      public function get floorBuyTilesLayer() : Sprite
      {
         return this._floorBuyTilesLayer;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.scaleMode = StageScaleMode.NO_SCALE;
         this.initWorld();
         stage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      public function initWorld() : void
      {
         this.addLayer();
      }
      
      public function doAction(param1:int, param2:Array = null) : void
      {
      }
      
      public function updateObjects(param1:String) : void
      {
      }
      
      private function pauseWorld() : void
      {
         this._pause = true;
      }
      
      private function unPauseWorld() : void
      {
         this._lastUpdate = getTimer();
         this._pause = false;
      }
      
      public function startWorld() : void
      {
         addEventListener(Event.ENTER_FRAME,this.update);
         this._running = true;
      }
      
      public function stopWorld() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.update);
         this._running = false;
      }
      
      public function destroyWorld() : void
      {
         if(stage)
         {
            stage.removeEventListener(Event.RESIZE,this.onResize);
         }
         removeEventListener(Event.RENDER,this.onRender);
         this.stopWorld();
         if(this._mouse)
         {
            this._mouse.deactivate();
         }
      }
      
      public function getIsoObjectByGroup(param1:String) : Array
      {
         return null;
      }
      
      private function update(param1:Event = null) : void
      {
         this.handleInput();
         if(this._pause)
         {
            return;
         }
         addEventListener(Event.RENDER,this.onRender);
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function onRender(param1:Event) : void
      {
         removeEventListener(Event.RENDER,this.onRender);
         var _loc2_:int = getTimer();
         this.updateDisplay(_loc2_);
         this._lastUpdate = _loc2_;
      }
      
      public function updateDisplay(param1:Number) : void
      {
         this.updateLayerElements(param1,this.allMutableReferences);
         if(this._zSortThisFrame)
         {
            this.zSortWorld();
            this._zSortThisFrame = false;
         }
      }
      
      private function updateLayerElements(param1:Number, param2:Array) : int
      {
         var _loc3_:VisualElement = null;
         var _loc4_:int = 0;
         for each(_loc3_ in param2)
         {
            _loc3_.update(param1);
            if(_loc3_.isDead(param1))
            {
               this.removeVisualElement(_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function changeWorldStatus(param1:int) : void
      {
         if(this._worldStatus != param1)
         {
            this._worldStatus = param1;
            dispatchEvent(new IsoWorldEvent(IsoWorldEvent.SWITCH_WORLD_STATE));
         }
      }
      
      private function handleInput() : void
      {
      }
      
      public function addDragIsoObject(param1:VisualVO) : void
      {
         var _loc2_:IDraggable = this.addLevelElement(param1) as IDraggable;
         _loc2_.startDrag();
      }
      
      public function addDragTile(param1:VisualVO) : void
      {
         var _loc2_:IDraggable = this.addLevelElement(param1) as IDraggable;
         _loc2_.startDrag();
      }
      
      public function removeIsoObject(param1:VisualElement) : void
      {
         if(param1 is IsoObject)
         {
            (param1 as IsoObject).remove();
            this.levelData.removeObject(param1.getVisualVO());
         }
         this.removeVisualElement(param1);
         param1 = null;
      }
      
      public function addIsoObject(param1:VisualVO) : void
      {
         var _loc2_:IsoStaticObject = this.addLevelElement(param1) as IsoStaticObject;
         if(!_loc2_.isWalkable)
         {
            this.map.collisionMap.setBlocked(_loc2_.isoGridPos);
         }
      }
      
      public function addLevelElement(param1:VisualVO) : VisualElement
      {
         var _loc2_:VisualElement = null;
         var _loc3_:Class = getDefinitionByName(this.objectClassPath + param1.group.toLowerCase() + "::" + param1.name + param1.group) as Class;
         _loc2_ = new _loc3_();
         _loc2_.initialize(param1,this);
         this.addVisualElement(_loc2_);
         if(_loc2_ is IsoObject)
         {
            this._isoObjects.push(_loc2_);
            param1.isOnIsoMap = true;
            _loc2_.isIsoObject = true;
         }
         else
         {
            this._levelObjects.push(_loc2_);
         }
         if(_loc2_.isMutable)
         {
            this.allMutableReferences.push(_loc2_);
         }
         else
         {
            this.allImmutableReferences.push(_loc2_);
         }
         return _loc2_;
      }
      
      public function addVisualElement(param1:VisualElement) : void
      {
         var _loc2_:String = param1.getVisualVO().group;
         switch(_loc2_)
         {
            case "Background":
               param1.addDispToLayer(this._backgroundLayer);
               break;
            case "Tile":
               param1.addDispToLayer(this._floorTileLayer);
               break;
            case "Cursor":
               param1.addDispToLayer(this._floorLayer);
               break;
            default:
               param1.addDispToLayer(this._objectLayer);
         }
         this.zSortThisFrame = true;
      }
      
      public function levelDataUpdate() : void
      {
         this.map.resizeMap();
         var _loc1_:int = 0;
         while(_loc1_ < this.levelData.objects.length)
         {
            if(!this.levelData.objects[_loc1_].isOnIsoMap)
            {
               this.addLevelElement(this.levelData.objects[_loc1_]);
            }
            _loc1_++;
         }
         this.map.initCamera();
         this._camera.zoomToMax();
      }
      
      protected function loadObjects() : void
      {
         var _loc3_:VisualVO = null;
         var _loc4_:IsoObject = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.levelData.objects.length)
         {
            _loc3_ = this.levelData.objects[_loc1_] as VisualVO;
            this.addLevelElement(_loc3_);
            _loc1_++;
         }
         this.map.updateCollisionMap();
         this.zSortThisFrame = true;
         var _loc2_:int = 0;
         while(_loc2_ < this.isoObjects.length)
         {
            (_loc4_ = this.isoObjects[_loc2_] as IsoObject).handleObjectDependencies();
            _loc2_++;
         }
      }
      
      public function removeVisualElement(param1:VisualElement) : void
      {
         if(param1)
         {
            param1.removeDispFromWorld();
            this.removeObject(param1);
            param1 = null;
         }
      }
      
      private function removeObject(param1:VisualElement) : void
      {
         if(param1.isIsoObject)
         {
            this._isoObjects.splice(this.getIndexByElement(param1,this._isoObjects),1);
         }
         else
         {
            this._levelObjects.splice(this.getIndexByElement(param1,this._levelObjects),1);
         }
         if(param1.isMutable)
         {
            this.allMutableReferences.splice(this.getIndexByElement(param1,this.allMutableReferences),1);
         }
         else
         {
            this.allImmutableReferences.splice(this.getIndexByElement(param1,this.allImmutableReferences),1);
         }
      }
      
      public function getIsoObjectByPoint(param1:Point) : IsoObject
      {
         var _loc3_:IsoObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.isoObjects.length)
         {
            _loc3_ = this.isoObjects[_loc2_] as IsoObject;
            if(_loc3_.isoGridPos)
            {
               if(_loc3_.isoGridPos.equals(param1))
               {
                  return _loc3_;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getIndexByElement(param1:VisualElement, param2:Array) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            if(param2[_loc3_] == param1)
            {
               break;
            }
            _loc3_++;
         }
         return _loc3_;
      }
      
      public function buildWorldFromLevelVO(param1:LevelVO) : Boolean
      {
         return false;
      }
      
      public function spawnPlayer(param1:VisualVO) : Boolean
      {
         return false;
      }
      
      public function spawnOtherPlayer(param1:VisualVO) : Boolean
      {
         return false;
      }
      
      public function spawnNpc(param1:VisualVO) : Boolean
      {
         return false;
      }
      
      public function removeNpc(param1:int) : Boolean
      {
         return false;
      }
      
      protected function zSortWorld() : void
      {
         this._isoObjects.sortOn("isoDepth",Array.NUMERIC);
         this.zSortDisplayList();
      }
      
      protected function zSortDisplayList() : void
      {
         var _loc3_:Sprite = null;
         var _loc1_:int = this._isoObjects.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._isoObjects[_loc2_].disp;
            if(this._objectLayer.contains(_loc3_))
            {
               if(this._objectLayer.getChildIndex(_loc3_) != _loc2_)
               {
                  this._objectLayer.setChildIndex(_loc3_,_loc2_);
               }
            }
            else
            {
               trace("IsoTileEngine.isoZSort: nicht in isoTilesMc " + _loc3_);
            }
            _loc2_++;
         }
      }
      
      protected function addLayer() : void
      {
         this._worldLayer = new Sprite();
         addChild(this._worldLayer);
         this._backgroundLayer = new Sprite();
         this._backgroundLayer.cacheAsBitmap = true;
         this._worldLayer.addChild(this._backgroundLayer);
         this._floorLayer = new Sprite();
         this._worldLayer.addChild(this._floorLayer);
         this._floorTileLayer = new Sprite();
         this._floorLayer.addChild(this._floorTileLayer);
         this._floorBuyTilesLayer = new Sprite();
         this._floorLayer.addChild(this._floorBuyTilesLayer);
         this._objectLayer = new Sprite();
         this._worldLayer.addChild(this._objectLayer);
         this._toolTipLayer = new Sprite();
         this._toolTipLayer.mouseChildren = false;
         this._toolTipLayer.mouseEnabled = false;
         this._worldLayer.addChild(this._toolTipLayer);
      }
      
      public function onResize(param1:Event) : void
      {
         if(stage)
         {
            this._camera.resizeViewPort(stage.stageWidth,stage.stageHeight);
         }
      }
      
      public function get voClassPath() : String
      {
         return "";
      }
      
      public function get objectClassPath() : String
      {
         return "";
      }
      
      public function get map() : IsoMap
      {
         return this._map;
      }
      
      public function get mouse() : IsoMouse
      {
         return this._mouse;
      }
      
      public function get camera() : IsoCamera
      {
         return this._camera;
      }
      
      public function set map(param1:IsoMap) : void
      {
         this._map = param1;
      }
      
      public function set mouse(param1:IsoMouse) : void
      {
         this._mouse = param1;
      }
      
      public function set camera(param1:IsoCamera) : void
      {
         this._camera = param1;
      }
      
      public function get isoObjects() : Array
      {
         return this._isoObjects;
      }
      
      public function set isoObjects(param1:Array) : void
      {
         this._isoObjects = param1;
      }
      
      public function get input() : Input
      {
         return this._input;
      }
      
      public function set zSortThisFrame(param1:Boolean) : void
      {
         this._zSortThisFrame = param1;
      }
      
      public function get backgroundLayer() : Sprite
      {
         return this._backgroundLayer;
      }
      
      public function get worldLayer() : Sprite
      {
         return this._worldLayer;
      }
      
      public function get floorLayer() : Sprite
      {
         return this._floorLayer;
      }
      
      public function get floorTileLayer() : Sprite
      {
         return this._floorTileLayer;
      }
      
      public function get objectLayer() : Sprite
      {
         return this._objectLayer;
      }
      
      public function get toolTipLayer() : Sprite
      {
         return this._toolTipLayer;
      }
      
      public function get worldStatus() : int
      {
         return this._worldStatus;
      }
      
      public function get levelObjects() : Array
      {
         return this._levelObjects;
      }
      
      public function get levelData() : LevelVO
      {
         return this._levelData;
      }
      
      public function set levelData(param1:LevelVO) : void
      {
         this._levelData = param1;
      }
      
      public function get lastUpdateTimestamp() : Number
      {
         return this._lastUpdate;
      }
      
      public function get isRunning() : Boolean
      {
         return this._running;
      }
   }
}
