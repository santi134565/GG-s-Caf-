package com.goodgamestudios.cafe.world
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.panels.CafeBuddylistPanel;
   import com.goodgamestudios.cafe.world.objects.background.StaticBackground;
   import com.goodgamestudios.cafe.world.objects.chair.BasicChair;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.door.BasicDoor;
   import com.goodgamestudios.cafe.world.objects.door.BorderDoor;
   import com.goodgamestudios.cafe.world.objects.moving.BasicMoving;
   import com.goodgamestudios.cafe.world.objects.moving.HeroMoving;
   import com.goodgamestudios.cafe.world.objects.moving.NpcbackgroundMoving;
   import com.goodgamestudios.cafe.world.objects.moving.NpcguestMoving;
   import com.goodgamestudios.cafe.world.objects.moving.NpcwaiterMoving;
   import com.goodgamestudios.cafe.world.objects.moving.OtherplayerMoving;
   import com.goodgamestudios.cafe.world.objects.moving.PlayerMoving;
   import com.goodgamestudios.cafe.world.objects.moving.VestedMoving;
   import com.goodgamestudios.cafe.world.objects.overlay.StaticOverlay;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import com.goodgamestudios.cafe.world.objects.table.BasicTable;
   import com.goodgamestudios.cafe.world.objects.tile.StaticTile;
   import com.goodgamestudios.cafe.world.objects.vendingmachine.BasicVendingmachine;
   import com.goodgamestudios.cafe.world.objects.wall.StaticWall;
   import com.goodgamestudios.cafe.world.objects.wallobject.BasicWallobject;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.moving.HeroMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.PlayerMovingVO;
   import com.goodgamestudios.cafe.world.vo.overlay.ChatOverlayVO;
   import com.goodgamestudios.cafe.world.vo.overlay.MovingIconOverlayVO;
   import com.goodgamestudios.cafe.world.vo.overlay.MovingOverlayVO;
   import com.goodgamestudios.cafe.world.vo.overlay.StaticIconOverlayVO;
   import com.goodgamestudios.cafe.world.vo.overlay.StaticOverlayVO;
   import com.goodgamestudios.cafe.world.vo.overlay.ThirstyOverlayVO;
   import com.goodgamestudios.isocore.IsoBackground;
   import com.goodgamestudios.isocore.IsoCamera;
   import com.goodgamestudios.isocore.IsoMouse;
   import com.goodgamestudios.isocore.IsoWorld;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.objects.IDraggable;
   import com.goodgamestudios.isocore.objects.IsoMovingObject;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.vo.LevelVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.math.Random;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeIsoWorld extends IsoWorld
   {
      
      public static const CAFE_STATUS_RUN:int = 0;
      
      public static const CAFE_STATUS_DEKO:int = 1;
      
      public static const ACTION_STOVE_COOK:int = 1;
      
      public static const ACTION_STOVE_DELIVERINFO:int = 2;
      
      public static const ACTION_STOVE_DELIVER:int = 3;
      
      public static const ACTION_CLEAN:int = 4;
      
      public static const ACTION_MOVE_PLAYER:int = 5;
      
      public static const ACTION_INSTANT_COOK:int = 6;
      
      public static const ACTION_CLEAN_GOODFOOD:int = 7;
      
      public static const ACTION_REFRESHFOOD:int = 8;
      
      public static const DEKOMODE_START:int = 100;
      
      public static const ACTION_EDITOR_MOVE:int = 101;
      
      public static const ACTION_EDITOR_STORE:int = 102;
      
      public static const ACTION_CAMERA_ZOOM_IN:int = 200;
      
      public static const ACTION_CAMERA_ZOOM_OUT:int = 201;
      
      public static const ACTION_NPC_ACTION:int = 300;
      
      public static const ACTION_NPC_INSERT:int = 0;
      
      public static const ACTION_NPC_WALK_TO_CHAIR:int = 1;
      
      public static const ACTION_NPC_SIT_DOWN:int = 2;
      
      public static const ACTION_NPC_EAT:int = 3;
      
      public static const ACTION_NPC_LEAVE:int = 4;
      
      public static const ACTION_NPC_LEAVE_COMPLETE:int = 41;
      
      public static const ACTION_NPC_WALK_TO_COUNTER:int = 5;
      
      public static const ACTION_NPC_HANDLE_FEED:int = 6;
      
      public static const ACTION_NPC_CLEAN:int = 7;
      
      public static const ACTION_NPC_FASTFOOD:int = 8;
      
      public static const ACTION_NPC_GOTO_VENDING_MACHINE:int = 9;
      
      public static const ACTION_GOTO_SEAT_THEN_VENDINGMACHINE:int = 10;
      
      public static const ACTION_INTERRUPT_AND_GOTO_VENDINGMACHINE:int = 11;
      
      public static const ACTION_JOBUSER_ACTION:int = 400;
      
      public static const ACTION_JOBUSER_CLEANSTART:int = 0;
      
      public static const ACTION_JOBUSER_CLEANEND:int = 1;
      
      public static const ACTION_JOBUSER_DELIVERSTART:int = 2;
      
      public static const ACTION_JOBUSER_DELIVEREND:int = 3;
      
      public static const ACTION_JOBUSER_PICKUPDISH:int = 4;
      
      public static const ACTION_JOBUSER_PICKDOWNDISH:int = 5;
      
      public static const ACTION_JOBUSER_MOVE:int = 6;
      
      public static const ACTION_SEEKING_JOB:int = 500;
      
      public static const ACTION_ERROR_OK:int = 0;
      
      protected static const rotationIsoDir:Array = [[[1],[0]],[[0],[-1]],[[-1],[0]],[[0],[1]]];
       
      
      private const NOF_TRY_TO_FIND_RANDOM_POSITION:int = 50;
      
      private var drawTileStartpos:Point;
      
      private var drawTileEndpos:Point;
      
      private var drawTileWod:int;
      
      public function CafeIsoWorld()
      {
         this.drawTileEndpos = new Point();
         super();
      }
      
      override public function initWorld() : void
      {
         trace("-----------------");
         trace("CafeIsoWorld INIT");
         map = new CafeIsoMap(this);
         super.initWorld();
         camera = new IsoCamera(new Rectangle(0,0,800,600),worldLayer,this);
         if(this.env.hasNetworkBuddies)
         {
            camera.stage_height_mod = -CafeBuddylistPanel.BUDDY_PANEL_HEIGHT;
         }
         trace("-----------------");
      }
      
      override protected function zSortWorld() : void
      {
         var _loc7_:IsoObject = null;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:int = isoObjects.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if((_loc7_ = isoObjects[_loc6_]) is NpcbackgroundMoving)
            {
               _loc4_.push(_loc7_);
            }
            else if(_loc7_ is StaticWall)
            {
               _loc1_.push(_loc7_);
            }
            else if(_loc7_ is BasicDoor || _loc7_ is BorderDoor)
            {
               _loc3_.push(_loc7_);
            }
            else if(_loc7_ is BasicWallobject)
            {
               _loc2_.push(_loc7_);
            }
            else if(_loc7_.isoGridPos && (_loc7_.isoGridPos.x == 0 || _loc7_.isoGridPos.y == 0))
            {
               _loc1_.push(_loc7_);
            }
            else
            {
               _loc3_.push(_loc7_);
            }
            _loc6_++;
         }
         this.sortByIsoDepth(_loc1_);
         this.sortByIsoDepth(_loc2_);
         this.sortByIsoDepth(_loc3_);
         isoObjects = [];
         isoObjects = _loc4_.concat(_loc1_);
         isoObjects = isoObjects.concat(_loc2_);
         isoObjects = isoObjects.concat(_loc3_);
         zSortDisplayList();
      }
      
      private function sortByIsoDepth(param1:Array) : void
      {
         param1.sortOn("isoDepth",Array.NUMERIC);
      }
      
      override public function addDragIsoObject(param1:VisualVO) : void
      {
         var _loc2_:BasicDoor = null;
         var _loc3_:IDraggable = null;
         if(param1.group == CafeConstants.GROUP_DOOR)
         {
            _loc2_ = this.door;
            if(_loc2_.type == param1.type)
            {
               _loc2_.startDrag();
            }
            else
            {
               _loc2_.hide();
               param1.isoPos = _loc2_.isoGridPos;
               _loc3_ = addLevelElement(param1) as IDraggable;
               (_loc3_ as BasicDoor).isNewDoor = true;
               _loc3_.startDrag();
            }
            dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
         }
         else
         {
            super.addDragIsoObject(param1);
         }
      }
      
      override public function addIsoObject(param1:VisualVO) : void
      {
         var _loc2_:BasicDoor = null;
         if(param1.group == CafeConstants.GROUP_DOOR)
         {
            _loc2_ = addLevelElement(param1) as BasicDoor;
            levelData.door = param1;
            map.collisionMap.setBlockedWallObj(_loc2_.isoGridPos.clone());
         }
         else
         {
            super.addIsoObject(param1);
         }
      }
      
      override public function changeWorldStatus(param1:int) : void
      {
         if(param1 != worldStatus)
         {
            super.changeWorldStatus(param1);
            switch(param1)
            {
               case CAFE_STATUS_RUN:
                  if(mouse.selectedObject)
                  {
                     mouse.selectedObject.deSelectObject();
                  }
                  map.collisionMap.setWalkable(this.freeDoorPoint);
                  break;
               case CAFE_STATUS_DEKO:
                  this.myPlayer.hide();
                  this.removeAllNpcs();
                  this.removeDishes();
                  if(this.door)
                  {
                     map.collisionMap.setBlocked(this.freeDoorPoint);
                     this.door.isOpen = false;
                  }
            }
            this.updateToolTips();
         }
      }
      
      public function startDrawTiles(param1:Point) : void
      {
         this.drawTileStartpos = param1;
         this.drawTileEndpos = param1;
         this.moveDrawTiles(param1,true);
      }
      
      public function moveDrawTiles(param1:Point, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Class = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Sprite = null;
         var _loc15_:Point = null;
         if((param2 || !this.drawTileEndpos.equals(param1)) && this.drawTileStartpos)
         {
            _loc3_ = Math.min(this.drawTileStartpos.x,param1.x);
            _loc4_ = Math.max(this.drawTileStartpos.x,param1.x);
            _loc5_ = Math.min(this.drawTileStartpos.y,param1.y);
            _loc6_ = Math.max(this.drawTileStartpos.y,param1.y);
            _loc7_ = this.cafeIsoMouse.iDragObject.wodId;
            if(!(CafeModel.wodData.voList[_loc7_] as ShopVO).isItemAvalibleByEvent())
            {
               _loc10_ = 0;
               _loc11_ = _loc3_;
               while(_loc11_ <= _loc4_)
               {
                  _loc12_ = _loc5_;
                  while(_loc12_ <= _loc6_)
                  {
                     if(map.getFloorWODid(new Point(_loc11_,_loc12_)) != _loc7_)
                     {
                        _loc10_++;
                     }
                     _loc12_++;
                  }
                  _loc11_++;
               }
               if(_loc10_ > CafeModel.inventoryFurniture.getInventoryAmountByWodId(_loc7_))
               {
                  return;
               }
            }
            while(floorBuyTilesLayer.numChildren > 0)
            {
               floorBuyTilesLayer.removeChildAt(0);
            }
            this.drawTileEndpos = param1;
            _loc8_ = getDefinitionByName((this.cafeIsoMouse.iDragObject as StaticTile).visClassName) as Class;
            _loc9_ = _loc3_;
            while(_loc9_ <= _loc4_)
            {
               _loc13_ = _loc5_;
               while(_loc13_ <= _loc6_)
               {
                  _loc14_ = new _loc8_();
                  floorBuyTilesLayer.addChild(_loc14_);
                  _loc15_ = map.grid.gridPosToPixelPos(new Point(_loc9_,_loc13_));
                  _loc14_.x = _loc15_.x;
                  _loc14_.y = _loc15_.y;
                  _loc13_++;
               }
               _loc9_++;
            }
            floorBuyTilesLayer.filters = [new GlowFilter(16777215)];
         }
      }
      
      public function stopDrawTiles() : void
      {
         var _loc1_:int = this.cafeIsoMouse.iDragObject.wodId;
         var _loc2_:int = this.getFloorRegionAmount(this.drawTileStartpos,this.drawTileEndpos,_loc1_);
         var _loc3_:int = Math.max(0,_loc2_ - CafeModel.inventoryFurniture.getInventoryAmountByWodId(_loc1_)) * CafeModel.wodData.voList[_loc1_].itemCash;
         dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
         dispatchEvent(new CafeIsoEvent(CafeIsoEvent.EDITOR_EVENT,[CafeIsoEvent.EDITOR_BUY_FLOOR,this.drawTileStartpos.x,this.drawTileStartpos.y,this.drawTileEndpos.x,this.drawTileEndpos.y,_loc1_,_loc2_,_loc3_]));
         this.cafeIsoMouse.unLockDragObject();
         this.cafeIsoMouse.removeIDragObject();
         this.drawTileStartpos = null;
         this.drawTileEndpos = new Point();
      }
      
      public function clearDrawTiles() : void
      {
         while(floorBuyTilesLayer.numChildren > 0)
         {
            floorBuyTilesLayer.removeChildAt(0);
         }
         this.cafeIsoMouse.unLockDragObject();
         this.cafeIsoMouse.removeIDragObject();
         this.drawTileStartpos = null;
         this.drawTileEndpos = new Point();
      }
      
      public function getFloorRegionAmount(param1:Point, param2:Point, param3:int) : int
      {
         var _loc10_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = Math.min(param1.x,param2.x);
         var _loc6_:int = Math.max(param1.x,param2.x);
         var _loc7_:int = Math.min(param1.y,param2.y);
         var _loc8_:int = Math.max(param1.y,param2.y);
         var _loc9_:int = _loc5_;
         while(_loc9_ <= _loc6_)
         {
            _loc10_ = _loc7_;
            while(_loc10_ <= _loc8_)
            {
               if(map.getFloorWODid(new Point(_loc9_,_loc10_)) != param3)
               {
                  _loc4_++;
               }
               _loc10_++;
            }
            _loc9_++;
         }
         return _loc4_;
      }
      
      private function updateToolTips() : void
      {
         var _loc1_:BasicStove = null;
         for each(_loc1_ in this.getIsoObjectByGroup(CafeConstants.GROUP_STOVE))
         {
            switch(worldStatus)
            {
               case CAFE_STATUS_RUN:
                  _loc1_.addIngeridentTip();
                  break;
               case CAFE_STATUS_DEKO:
                  _loc1_.ingredientTip.hide();
                  break;
            }
         }
      }
      
      override public function updateObjects(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:IsoObject = null;
         var _loc9_:IsoObject = null;
         var _loc10_:BasicCounter = null;
         var _loc11_:BasicChair = null;
         var _loc2_:Array = param1.split("#");
         if(_loc2_[0] != "")
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc5_ = (_loc4_ = _loc2_[_loc3_].split("+")).shift();
               _loc6_ = _loc4_.shift();
               _loc7_ = _loc4_.shift();
               for each(_loc8_ in this.getIsoObjectByGroup(CafeConstants.GROUP_COUNTER))
               {
                  if((_loc10_ = _loc8_ as BasicCounter).counterVO.wodId == _loc7_ && _loc10_.isoGridPos.x == _loc5_ && _loc10_.isoGridPos.y == _loc6_)
                  {
                     _loc10_.counterVO.loadFromParamArray(_loc4_);
                     _loc10_.refreshDish();
                  }
               }
               for each(_loc9_ in this.getIsoObjectByGroup(CafeConstants.GROUP_CHAIR))
               {
                  if((_loc11_ = _loc9_ as BasicChair) && _loc11_.getVisualVO().wodId == _loc7_ && _loc11_.isoGridPos.x == _loc5_ && _loc11_.isoGridPos.y == _loc6_)
                  {
                     _loc11_.getVisualVO().loadFromParamArray(_loc4_);
                     _loc11_.addTableDish();
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function getIsoObjectLuxury() : int
      {
         var _loc3_:IsoObject = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < isoObjects.length)
         {
            _loc3_ = isoObjects[_loc2_] as IsoObject;
            if(_loc3_.getVisualVO() is ShopVO)
            {
               _loc1_ += (_loc3_.getVisualVO() as ShopVO).getLuxury();
            }
            _loc2_++;
         }
         return int(_loc1_ + (map as CafeIsoMap).floorTileLuxury());
      }
      
      override public function buildWorldFromLevelVO(param1:LevelVO) : Boolean
      {
         levelData = param1;
         this.loadBackground();
         map.init(levelData.mapSize,new Point(CafeConstants.ISOTILESIZE_X,CafeConstants.ISOTILESIZE_Y));
         mouse = new CafeIsoMouse(this);
         mouse.switchState(IsoMouse.ISOMOUSE_STATE_SNAP);
         camera.resizeViewPort(stage.stageWidth,stage.stageHeight);
         loadObjects();
         startWorld();
         this.changeWorldStatus(CAFE_STATUS_RUN);
         addEventListener(IsoWorldEvent.WORLD_CHANGE,this.onWorldChange);
         return true;
      }
      
      private function onWorldChange(param1:IsoWorldEvent) : void
      {
         var _loc2_:Array = param1.params;
         switch(_loc2_.shift())
         {
            case IsoWorldEvent.OBJECT_STOP_DRAG:
               dispatchEvent(new CafeIsoEvent(CafeIsoEvent.EDITOR_EVENT,[CafeIsoEvent.EDITOR_MOVE,_loc2_.shift(),_loc2_.shift(),_loc2_.shift(),_loc2_.shift()]));
               break;
            case IsoWorldEvent.NEW_OBJECT:
               dispatchEvent(new CafeIsoEvent(CafeIsoEvent.EDITOR_EVENT,[CafeIsoEvent.EDITOR_BUY,_loc2_.shift(),_loc2_.shift(),_loc2_.shift(),_loc2_.shift()]));
               break;
            case IsoWorldEvent.CHANGE_TILE:
               dispatchEvent(new CafeIsoEvent(CafeIsoEvent.EDITOR_EVENT,[CafeIsoEvent.EDITOR_BUY,_loc2_.shift(),_loc2_.shift(),_loc2_.shift(),_loc2_.shift()]));
               break;
            case IsoWorldEvent.CHANGE_WALL:
               dispatchEvent(new CafeIsoEvent(CafeIsoEvent.EDITOR_EVENT,[CafeIsoEvent.EDITOR_BUY,_loc2_.shift(),_loc2_.shift(),_loc2_.shift(),_loc2_.shift()]));
         }
      }
      
      override public function getIsoObjectByGroup(param1:String) : Array
      {
         var _loc4_:IsoObject = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < isoObjects.length)
         {
            if((_loc4_ = isoObjects[_loc3_] as IsoObject).group == param1)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function countIsoObjectByGroup(param1:String, param2:Boolean = true, param3:String = "") : int
      {
         var _loc6_:IsoObject = null;
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < isoObjects.length)
         {
            if((_loc6_ = isoObjects[_loc5_] as IsoObject).group == param1 && (param3 != "" && _loc6_.name == param3 || param3 == ""))
            {
               _loc4_.push(_loc6_);
            }
            _loc5_++;
         }
         if(param2)
         {
            return _loc4_.length + CafeModel.inventoryFurniture.getInventoryByGroup(param1).length;
         }
         return _loc4_.length;
      }
      
      public function getChairByPoint(param1:Point) : BasicChair
      {
         var _loc3_:IsoObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < isoObjects.length)
         {
            _loc3_ = isoObjects[_loc2_] as IsoObject;
            if(_loc3_.group == CafeConstants.GROUP_CHAIR && _loc3_.name != CafeConstants.NAME_BACKCHAIR && _loc3_.isoGridPos.equals(param1))
            {
               return _loc3_ as BasicChair;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getVendingmachineByPoint(param1:Point) : BasicVendingmachine
      {
         var _loc3_:IsoObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < isoObjects.length)
         {
            _loc3_ = isoObjects[_loc2_] as IsoObject;
            if(_loc3_.group == CafeConstants.GROUP_VENDINGMACHINE && _loc3_.isoGridPos.equals(param1))
            {
               return _loc3_ as BasicVendingmachine;
            }
            _loc2_++;
         }
         return null;
      }
      
      private function loadBackground() : void
      {
         levelData.background.x = 0;
         levelData.background.y = 0;
         _background = addLevelElement(levelData.background) as IsoBackground;
      }
      
      public function updateBackgroundTextFields() : void
      {
         if(_background is StaticBackground)
         {
            (_background as StaticBackground).updateToolTipTextFields();
         }
      }
      
      override public function spawnPlayer(param1:VisualVO) : Boolean
      {
         var _loc2_:IsoMovingObject = map.getOtherPlayerByUserId((param1 as HeroMovingVO).userId);
         if(_loc2_)
         {
            this.removeOtherPlayer((param1 as HeroMovingVO).userId);
         }
         if(this.myPlayer)
         {
            param1.isoPos = this.myPlayer.isoGridPos.clone();
            removeIsoObject(this.myPlayer);
         }
         this.myPlayer = addLevelElement(param1) as HeroMoving;
         this.myPlayer.show();
         zSortThisFrame = true;
         return true;
      }
      
      override public function spawnNpc(param1:VisualVO) : Boolean
      {
         param1.isoPos = this.spwanPoint;
         var _loc2_:IsoMovingObject = addLevelElement(param1) as IsoMovingObject;
         map.npcArray.push(_loc2_);
         _loc2_.hide();
         return true;
      }
      
      public function spawnBackgroundNpc(param1:VisualVO) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1.isoPos = NpcbackgroundMoving.getRandomSpawnpoint(levelData.mapSizeX,levelData.mapSizeY);
         var _loc2_:IsoMovingObject = addLevelElement(param1) as IsoMovingObject;
         map.npcArray.push(_loc2_);
         _loc2_.show();
         return true;
      }
      
      override public function spawnOtherPlayer(param1:VisualVO) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if((param1 as PlayerMovingVO).userId == CafeModel.userData.userID)
         {
            return false;
         }
         var _loc2_:IsoMovingObject = map.getOtherPlayerByPlayerId((param1 as OtherplayerMovingVO).playerId);
         if(_loc2_)
         {
            removeVisualElement(_loc2_);
            map.removeOtherPlayerById((param1 as OtherplayerMovingVO).userId);
         }
         _loc2_ = addLevelElement(param1) as IsoMovingObject;
         map.otherPlayerArray.push(_loc2_);
         _loc2_.show();
         return true;
      }
      
      override public function removeNpc(param1:int) : Boolean
      {
         var _loc2_:IsoMovingObject = map.getNpcById(param1);
         map.removeNpcById(param1);
         removeIsoObject(_loc2_);
         _loc2_ = null;
         return true;
      }
      
      public function removeBackgroundNPC(param1:NpcbackgroundMoving) : void
      {
         map.removeNpcByVE(param1);
         removeIsoObject(param1);
      }
      
      public function renameNpc(param1:Array) : Boolean
      {
         var _loc2_:IsoMovingObject = map.getNpcById(param1[0]) as IsoMovingObject;
         if(_loc2_ is NpcwaiterMoving)
         {
            (_loc2_ as NpcwaiterMoving).rename(param1[1]);
         }
         return true;
      }
      
      private function removeDishes() : void
      {
         var _loc1_:IsoObject = null;
         var _loc2_:BasicTable = null;
         for each(_loc1_ in this.getIsoObjectByGroup(CafeConstants.GROUP_TABLE))
         {
            _loc2_ = _loc1_ as BasicTable;
            _loc2_.removeDish();
         }
      }
      
      public function removeOtherPlayer(param1:int) : void
      {
         var _loc2_:IsoMovingObject = map.getOtherPlayerByUserId(param1);
         if(_loc2_)
         {
            removeVisualElement(_loc2_);
            map.removeOtherPlayerById(param1);
         }
      }
      
      private function removeCurrentHero() : void
      {
         if(this.myPlayer)
         {
            removeVisualElement(this.myPlayer);
            this.myPlayer = null;
         }
      }
      
      override public function doAction(param1:int, param2:Array = null) : void
      {
         var _loc3_:BasicStove = null;
         var _loc4_:BasicCounter = null;
         var _loc5_:VisualElement = null;
         var _loc6_:int = 0;
         var _loc7_:PlayerMoving = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:PlayerMoving = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:NpcwaiterMoving = null;
         var _loc14_:NpcguestMoving = null;
         var _loc15_:VestedMoving = null;
         switch(param1)
         {
            case ACTION_STOVE_COOK:
               _loc3_ = this.getLevelObjectByXY(param2[1],param2[2]) as BasicStove;
               if(_loc3_)
               {
                  _loc3_.stoveActionCook(param2);
               }
               break;
            case ACTION_INSTANT_COOK:
               _loc3_ = this.getLevelObjectByXY(param2[1],param2[2]) as BasicStove;
               if(_loc3_)
               {
                  _loc3_.instaCook();
                  if(CafeTutorialController.getInstance().isActive)
                  {
                     _loc3_.deactivateTimer();
                  }
               }
               break;
            case ACTION_REFRESHFOOD:
               _loc3_ = this.getLevelObjectByXY(param2[1],param2[2]) as BasicStove;
               if(_loc3_)
               {
                  _loc3_.refreshFood(param2);
               }
               break;
            case ACTION_STOVE_DELIVERINFO:
               _loc3_ = this.getLevelObjectByXY(param2[1],param2[2]) as BasicStove;
               if(param2[0] == 0)
               {
                  _loc4_ = this.getLevelObjectByXY(param2[3],param2[4]) as BasicCounter;
                  if(_loc3_)
                  {
                     _loc3_.stoveActionStartServe(param2,_loc4_);
                  }
               }
               else if(param2[0] == BasicStove.STOVE_ERROR_COUNTER_BLOCKED)
               {
                  dispatchEvent(new CafeIsoEvent(CafeIsoEvent.DIALOG_EVENT,[CafeModel.languageData.getTextById("alert_nofreecounter_title"),CafeModel.languageData.getTextById("alert_nofreecounter_copy")]));
                  _loc3_.removeFromWorklist();
               }
               else
               {
                  _loc3_.removeFromWorklist();
               }
               break;
            case ACTION_STOVE_DELIVER:
               _loc3_ = this.getLevelObjectByXY(param2[1],param2[2]) as BasicStove;
               _loc4_ = this.getLevelObjectByXY(param2[3],param2[4]) as BasicCounter;
               if(_loc3_ && _loc4_)
               {
                  _loc3_.stoveActionDeliverEnd(param2);
               }
               break;
            case ACTION_CLEAN:
               if((_loc5_ = this.getLevelObjectByXY(param2[1],param2[2])).getVisualVO().group == CafeConstants.GROUP_STOVE)
               {
                  (_loc5_ as BasicStove).stoveActionClean(param2);
               }
               else if(_loc5_.getVisualVO().group == CafeConstants.GROUP_COUNTER)
               {
                  (_loc5_ as BasicCounter).counterActionClean(param2);
               }
               break;
            case DEKOMODE_START:
               if(this.myPlayer.isWorking)
               {
                  dispatchEvent(new CafeIsoEvent(CafeIsoEvent.DIALOG_EVENT,[CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")]));
               }
               else
               {
                  dispatchEvent(new CafeIsoEvent(CafeIsoEvent.EDITOR_EVENT,[CafeIsoEvent.EDITOR_DEKOMODE_ON,1]));
               }
               break;
            case ACTION_EDITOR_MOVE:
               if(param2.shift() != ACTION_ERROR_OK)
               {
                  if(_loc5_ = this.getLevelObjectByXY(param2[2],param2[3]))
                  {
                     _loc5_.changeIsoPos(new Point(param2[0],param2[1]));
                  }
               }
               break;
            case ACTION_EDITOR_STORE:
               if(param2.shift() == ACTION_ERROR_OK)
               {
                  if(mouse.iDragObject)
                  {
                     removeIsoObject(mouse.iDragObject as VisualElement);
                     mouse.iDragObject = null;
                  }
                  mouse.onMouseUp(null);
               }
               break;
            case ACTION_CAMERA_ZOOM_IN:
               camera.zoom += CafeConstants.CAMERA_ZOOM_STEP;
               break;
            case ACTION_CAMERA_ZOOM_OUT:
               camera.zoom -= CafeConstants.CAMERA_ZOOM_STEP;
               break;
            case ACTION_MOVE_PLAYER:
               if(param2.shift() == ACTION_ERROR_OK)
               {
                  this.myPlayer.startWalkPath();
               }
               else
               {
                  this.myPlayer.clearPath();
               }
               break;
            case ACTION_SEEKING_JOB:
               if((_loc6_ = int(param2[0])) == CafeModel.userData.userID)
               {
                  _loc7_ = this.myPlayer;
               }
               else
               {
                  _loc7_ = map.getOtherPlayerByUserId(_loc6_) as OtherplayerMoving;
               }
               if(_loc7_)
               {
                  _loc7_.updateSeekingJobIcon(int(param2[1]) == 1);
               }
               break;
            case ACTION_JOBUSER_ACTION:
               _loc8_ = int(param2[0]);
               _loc9_ = int(param2[1]);
               if(_loc8_ == CafeModel.userData.userID)
               {
                  _loc10_ = this.myPlayer;
               }
               else
               {
                  _loc10_ = map.getOtherPlayerByUserId(_loc8_) as OtherplayerMoving;
               }
               if(!_loc10_)
               {
                  return;
               }
               switch(_loc9_)
               {
                  case ACTION_JOBUSER_MOVE:
                     _loc10_.walkToFreePos(new Point(param2[2],param2[3]));
                     break;
                  case ACTION_JOBUSER_CLEANSTART:
                     _loc10_.cleanstart(this.getChairByPoint(new Point(param2[2],param2[3])));
                     break;
                  case ACTION_JOBUSER_CLEANEND:
                     _loc10_.cleanend();
                     break;
                  case ACTION_JOBUSER_DELIVERSTART:
                     _loc10_.deliverstart(this.getChairByPoint(new Point(param2[2],param2[3])));
                     break;
                  case ACTION_JOBUSER_DELIVEREND:
                     _loc10_.deliverend();
                     break;
                  case ACTION_JOBUSER_PICKUPDISH:
                     if(_loc4_ = this.getLevelObjectByXY(int(param2[2]),int(param2[3])) as BasicCounter)
                     {
                        _loc10_.pickupdish(_loc4_);
                     }
                     break;
                  case ACTION_JOBUSER_PICKDOWNDISH:
                     if(_loc4_ = this.getLevelObjectByXY(int(param2[2]),int(param2[3])) as BasicCounter)
                     {
                        _loc10_.pickdowndish(_loc4_);
                     }
               }
               break;
            case ACTION_NPC_ACTION:
               _loc11_ = int(param2[0]);
               _loc12_ = int(param2[1]);
               switch(_loc12_)
               {
                  case ACTION_GOTO_SEAT_THEN_VENDINGMACHINE:
                     if(_loc14_ = map.getNpcById(_loc11_) as NpcguestMoving)
                     {
                        _loc14_.clearPath();
                     }
                  case ACTION_INTERRUPT_AND_GOTO_VENDINGMACHINE:
                  case ACTION_NPC_GOTO_VENDING_MACHINE:
                     if(_loc14_ = map.getNpcById(_loc11_) as NpcguestMoving)
                     {
                        _loc14_.onWalkToVendingmachine();
                     }
                     break;
                  case ACTION_NPC_FASTFOOD:
                     if(_loc14_ = map.getNpcById(_loc11_) as NpcguestMoving)
                     {
                        _loc14_.fastfoodAction(getIsoObjectByPoint(new Point(int(param2[2]),int(param2[3]))));
                     }
                     break;
                  case ACTION_NPC_CLEAN:
                     if(_loc13_ = map.getNpcById(_loc11_) as NpcwaiterMoving)
                     {
                        _loc13_.clean(this.getChairByPoint(new Point(int(param2[2]),int(param2[3]))));
                     }
                     break;
                  case ACTION_NPC_WALK_TO_COUNTER:
                     _loc13_ = map.getNpcById(_loc11_) as NpcwaiterMoving;
                     _loc4_ = this.getLevelObjectByXY(int(param2[2]),int(param2[3])) as BasicCounter;
                     if(!_loc13_)
                     {
                        break;
                     }
                     if(_loc4_)
                     {
                        _loc13_.walkToCounter(_loc4_);
                     }
                     else if(_loc13_.isHidden)
                     {
                        _loc13_.show();
                        _loc13_.walkToFreePos(this.freeDoorPoint);
                     }
                     break;
                  case ACTION_NPC_HANDLE_FEED:
                     if(_loc13_ = map.getNpcById(_loc11_) as NpcwaiterMoving)
                     {
                        _loc13_.servToTable(this.getChairByPoint(new Point(int(param2[2]),int(param2[3]))));
                     }
                     break;
                  case ACTION_NPC_INSERT:
                     if((_loc15_ = map.getNpcById(_loc11_) as VestedMoving).isHidden)
                     {
                        _loc15_.show();
                        _loc15_.walkToFreePos(this.freeDoorPoint);
                     }
                     break;
                  case ACTION_NPC_WALK_TO_CHAIR:
                     if(_loc14_ = map.getNpcById(_loc11_) as NpcguestMoving)
                     {
                        _loc14_.walkToChair(this.getChairByPoint(new Point(int(param2[2]),int(param2[3]))));
                     }
                     break;
                  case ACTION_NPC_SIT_DOWN:
                     if(_loc14_ = map.getNpcById(_loc11_) as NpcguestMoving)
                     {
                        _loc14_.sitDown(this.getChairByPoint(new Point(int(param2[2]),int(param2[3]))));
                     }
                     break;
                  case ACTION_NPC_EAT:
                     if(_loc14_ = map.getNpcById(_loc11_) as NpcguestMoving)
                     {
                        _loc14_.eat(this.getChairByPoint(new Point(int(param2[2]),int(param2[3]))));
                     }
                     break;
                  case ACTION_NPC_LEAVE:
                     if(_loc14_ = map.getNpcById(_loc11_) as NpcguestMoving)
                     {
                        _loc14_.leave();
                     }
                     break;
                  case ACTION_NPC_LEAVE_COMPLETE:
                     this.removeNpc(_loc11_);
               }
         }
      }
      
      public function getLevelObjectByXY(param1:int, param2:int) : IsoObject
      {
         var _loc5_:IsoObject = null;
         var _loc3_:Point = new Point(param1,param2);
         var _loc4_:int = 0;
         while(_loc4_ < isoObjects.length)
         {
            if((_loc5_ = isoObjects[_loc4_] as IsoObject).getVisualVO().isoPos.equals(_loc3_))
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      private function getLevelObjectVOByXY(param1:int, param2:int) : VisualVO
      {
         var _loc5_:VisualVO = null;
         var _loc3_:Point = new Point(param1,param2);
         var _loc4_:int = 0;
         while(_loc4_ < levelData.objects.length)
         {
            if((_loc5_ = levelData.objects[_loc4_] as VisualVO).isoPos.equals(_loc3_))
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function addBoniBox(param1:VisualElement, param2:String, param3:String, param4:Object, param5:String, param6:int = 0, param7:int = 0) : VisualElement
      {
         var _loc8_:MovingOverlayVO = null;
         if(!param1 || !param1.disp)
         {
            return null;
         }
         switch(param2)
         {
            case MovingOverlayVO.OVERLAY_TYPE_WITH_ICON:
               (_loc8_ = new MovingIconOverlayVO()).x = param1.visualX;
               _loc8_.y = param1.visualY;
               _loc8_.timeDelay = param7;
               if(param1 is BasicMoving)
               {
                  _loc8_.x += (param1 as BasicMoving).overlayPosition.x;
                  _loc8_.y += (param1 as BasicMoving).overlayPosition.y;
               }
               _loc8_.text = param3 + (param4 is String ? param4 as String : int(param4).toString()) + " " + param5;
               if(param6 != 0)
               {
                  (_loc8_ as MovingIconOverlayVO).iconWodId = param6;
               }
               return addLevelElement(_loc8_);
            case StaticOverlayVO.OVERLAY_TYPE_WITH_WAITINGICON:
               (_loc8_ = new StaticIconOverlayVO()).x = param1.visualX;
               _loc8_.y = param1.visualY;
               if(param1 is BasicMoving)
               {
                  _loc8_.x += (param1 as BasicMoving).overlayPosition.x;
                  _loc8_.y += (param1 as BasicMoving).overlayPosition.y;
               }
               _loc8_.text = param3 + (param4 is String ? param4 as String : int(param4).toString()) + " " + param5;
               if(param6 != 0)
               {
                  (_loc8_ as StaticIconOverlayVO).iconWodId = param6;
               }
               return addLevelElement(_loc8_);
            default:
               return null;
         }
      }
      
      public function removeBoniBox(param1:VisualElement) : void
      {
         if(param1 == null)
         {
            return;
         }
         removeVisualElement(param1);
         param1 = null;
      }
      
      public function removeInfoBox(param1:VisualElement) : void
      {
         if(param1 == null)
         {
            return;
         }
         removeVisualElement(param1);
         param1 = null;
      }
      
      public function addInfoBox(param1:VisualElement, param2:String, param3:Array = null, param4:int = 0) : StaticOverlay
      {
         var _loc5_:StaticOverlayVO = null;
         var _loc6_:VisualElement = null;
         if(param1 == null)
         {
            return null;
         }
         switch(param2)
         {
            case StaticOverlayVO.OVERLAY_TYPE_THIRSTY:
               _loc5_ = new ThirstyOverlayVO();
               if(param1 is BasicMoving)
               {
                  _loc5_.x += (param1 as BasicMoving).overlayPosition.x;
                  _loc5_.y += (param1 as BasicMoving).overlayPosition.y;
                  (_loc5_ as ThirstyOverlayVO).target = param1;
               }
               break;
            case StaticOverlayVO.OVERLAY_TYPE_INFOTEXT:
               (_loc5_ = new StaticOverlayVO()).text = param3.shift();
               if(param1 is BasicMoving)
               {
                  _loc5_.x += (param1 as BasicMoving).overlayPosition.x;
                  _loc5_.y += (param1 as BasicMoving).overlayPosition.y;
               }
               break;
            case StaticOverlayVO.OVERLAY_TYPE_SPEECH_BALLOON:
               ((_loc5_ = new ChatOverlayVO()) as ChatOverlayVO).target = param1;
               break;
            case StaticOverlayVO.OVERLAY_TYPE_WITH_SEEKINGJOBICON:
               _loc5_ = new StaticIconOverlayVO();
               if(param1 is BasicMoving)
               {
                  _loc5_.x += (param1 as BasicMoving).overlayPosition.x;
                  _loc5_.y += (param1 as BasicMoving).overlayPosition.y;
               }
               if(param4 != 0)
               {
                  (_loc5_ as StaticIconOverlayVO).iconWodId = param4;
               }
         }
         var _loc7_:Class;
         (_loc6_ = new (_loc7_ = getDefinitionByName(this.objectClassPath + _loc5_.group.toLowerCase() + "::" + _loc5_.name + _loc5_.group) as Class)()).initialize(_loc5_,this);
         if(_loc6_.isMutable)
         {
            allMutableReferences.push(_loc6_);
         }
         else
         {
            allImmutableReferences.push(_loc6_);
         }
         _loc6_.addDispToLayer(param1.disp);
         return _loc6_ as StaticOverlay;
      }
      
      private function get cafeIsoMouse() : CafeIsoMouse
      {
         return mouse as CafeIsoMouse;
      }
      
      public function get spwanPoint() : Point
      {
         return levelData.door.isoPos.clone();
      }
      
      public function get randomFreeVendingMachine() : BasicVendingmachine
      {
         var _loc2_:IsoObject = null;
         var _loc1_:Array = [];
         for each(_loc2_ in isoObjects)
         {
            if(_loc2_ is BasicVendingmachine && (_loc2_ as BasicVendingmachine).currentStatus != BasicVendingmachine.VENDING_STATUS_EMPTY)
            {
               _loc1_.push(_loc2_);
            }
         }
         if(_loc1_.length < 1)
         {
            for each(_loc2_ in isoObjects)
            {
               if(_loc2_ is BasicVendingmachine)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_[Random.integer(0,_loc1_.length)];
      }
      
      public function get freeDoorPoint() : Point
      {
         var _loc1_:Point = null;
         if(levelData.door && levelData.door.isoPos)
         {
            _loc1_ = levelData.door.isoPos.clone();
            if(_loc1_.x == 0)
            {
               ++_loc1_.x;
            }
            if(_loc1_.y == 0)
            {
               ++_loc1_.y;
            }
            return _loc1_;
         }
         return null;
      }
      
      public function get cafeWorldType() : int
      {
         return levelData.worldType;
      }
      
      override public function get voClassPath() : String
      {
         return CafeConstants.CAFE_VO_CLASS_PATH;
      }
      
      override public function get objectClassPath() : String
      {
         return CafeConstants.CAFE_OBJECT_CLASS_PATH;
      }
      
      public function get myPlayer() : HeroMoving
      {
         return map.currentHero as HeroMoving;
      }
      
      public function set myPlayer(param1:HeroMoving) : void
      {
         map.currentHero = param1;
      }
      
      public function get door() : BasicDoor
      {
         var _loc2_:IsoObject = null;
         var _loc1_:Array = this.getIsoObjectByGroup(CafeConstants.GROUP_DOOR);
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.getVisualVO().name != "Border")
            {
               return _loc2_ as BasicDoor;
            }
         }
         return null;
      }
      
      override public function destroyWorld() : void
      {
         if(_background)
         {
            _background.removeDispFromWorld();
         }
         removeEventListener(IsoWorldEvent.WORLD_CHANGE,this.onWorldChange);
         CafeModel.sessionData.regBonus = false;
         this.removeAllObjects();
         this.removeAllNpcs();
         super.destroyWorld();
         (map as CafeIsoMap).destroyMap();
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      private function removeAllNpcs() : void
      {
         var _loc1_:IsoMovingObject = null;
         for each(_loc1_ in map.npcArray)
         {
            this.removeNpc((_loc1_.getVisualVO() as NpcMovingVO).npcId);
         }
         map.npcArray = [];
      }
      
      public function getIsoDirByIsoRotation(param1:int) : Point
      {
         return new Point(int(rotationIsoDir[param1][0]),int(rotationIsoDir[param1][1]));
      }
      
      private function removeAllObjects() : void
      {
         var _loc2_:IsoObject = null;
         var _loc3_:IsoObject = null;
         var _loc4_:VisualElement = null;
         var _loc5_:VisualElement = null;
         var _loc1_:Array = [];
         for each(_loc2_ in isoObjects)
         {
            _loc1_.push(_loc2_);
         }
         for each(_loc3_ in _loc1_)
         {
            removeIsoObject(_loc3_);
            _loc3_ = null;
         }
         _loc1_ = [];
         for each(_loc4_ in levelObjects)
         {
            _loc1_.push(_loc4_);
         }
         for each(_loc5_ in _loc1_)
         {
            removeVisualElement(_loc5_);
         }
      }
   }
}
