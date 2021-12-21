package com.goodgamestudios.cafe.world
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.world.objects.CafeInteractiveFloorObject;
   import com.goodgamestudios.cafe.world.objects.door.BasicDoor;
   import com.goodgamestudios.cafe.world.objects.wall.StaticWall;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.isocore.IIsoWorld;
   import com.goodgamestudios.isocore.map.IsoMap;
   import com.goodgamestudios.isocore.map.MapHelper;
   import com.goodgamestudios.isocore.objects.IsoMovingObject;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.objects.WallObject;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.geom.Point;
   
   public class CafeIsoMap extends IsoMap
   {
       
      
      private var _selectedItem:CafeInteractiveFloorObject;
      
      public function CafeIsoMap(param1:IIsoWorld)
      {
         super(param1);
      }
      
      override public function updateCollisionMap() : void
      {
         var _loc1_:IsoObject = null;
         var _loc2_:BasicDoor = null;
         super.updateCollisionMap();
         for each(_loc1_ in world.isoObjects)
         {
            if(_loc1_.group == CafeConstants.GROUP_WALLOBJECT || _loc1_.group == CafeConstants.GROUP_DOOR)
            {
               if(!_loc1_.isWalkable)
               {
                  (_loc1_ as WallObject).setBlockedTiles();
               }
            }
         }
         _loc2_ = this.getDoor();
         if(_loc2_)
         {
            if(world.worldStatus == CafeIsoWorld.CAFE_STATUS_DEKO)
            {
               collisionMap.setBlocked(_loc2_.motionTile);
            }
            collisionMap.setBlocked(_loc2_.frontTile(_loc2_.isoGridPos));
         }
      }
      
      public function changeWall(param1:Point, param2:VisualVO) : void
      {
         var _loc4_:BasicDoor = null;
         var _loc3_:WallObject = this.getWall(param1) as WallObject;
         if(_loc3_)
         {
            param2.isoPos = param1;
            if(_loc4_ = this.getDoor())
            {
               _loc4_.removeDoorMask();
            }
            world.removeIsoObject(_loc3_);
            _loc3_ = null;
            world.addIsoObject(param2);
            if(_loc4_)
            {
               _loc4_.setDoorMask();
            }
         }
      }
      
      public function getDoor() : BasicDoor
      {
         var _loc1_:IsoObject = null;
         for each(_loc1_ in _world.isoObjects)
         {
            if(_loc1_.getVisualVO().group == CafeConstants.GROUP_DOOR)
            {
               return _loc1_ as BasicDoor;
            }
         }
         return null;
      }
      
      public function getWall(param1:Point) : StaticWall
      {
         var _loc2_:IsoObject = null;
         for each(_loc2_ in _world.isoObjects)
         {
            if(_loc2_.isoGridPos.equals(param1))
            {
               if(_loc2_.getVisualVO().group == CafeConstants.GROUP_WALL)
               {
                  return _loc2_ as StaticWall;
               }
            }
         }
         return null;
      }
      
      public function getWallWodId(param1:Point) : int
      {
         var _loc2_:IsoObject = null;
         for each(_loc2_ in _world.isoObjects)
         {
            if(_loc2_.isoGridPos.equals(param1))
            {
               if(_loc2_.getVisualVO().group == CafeConstants.GROUP_WALL)
               {
                  return _loc2_.getVisualVO().wodId;
               }
            }
         }
         return -1;
      }
      
      public function getNpcByXY(param1:Point) : IsoMovingObject
      {
         var _loc2_:IsoMovingObject = null;
         for each(_loc2_ in npcArray)
         {
            if((_loc2_.getVisualVO() as Object).posX == param1.x && (_loc2_.getVisualVO() as Object).posY == param1.y)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      override public function isOnPlayMap(param1:Point) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.x > 0 && param1.y > 0)
         {
            if(MapHelper.isXYonMap(param1,_mapSize))
            {
               return true;
            }
         }
         return false;
      }
      
      public function floorTileLuxury() : int
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < _floorTilesVO.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _floorTilesVO[_loc2_].length)
            {
               _loc1_ += (_floorTilesVO[_loc2_][_loc3_] as ShopVO).getLuxury();
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get selectedItem() : CafeInteractiveFloorObject
      {
         return this._selectedItem;
      }
      
      public function set selectedItem(param1:CafeInteractiveFloorObject) : void
      {
         this._selectedItem = param1;
      }
      
      public function destroyMap() : void
      {
         super.removeMap();
         _collisionMap = null;
      }
   }
}
