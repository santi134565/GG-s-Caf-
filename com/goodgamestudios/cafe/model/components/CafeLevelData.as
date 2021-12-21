package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeShowBonusDialogCommand;
   import com.goodgamestudios.cafe.event.CafeLevelEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeBonusDialogProperties;
   import com.goodgamestudios.cafe.world.vo.expansion.BasicExpansionVO;
   import com.goodgamestudios.cafe.world.vo.tile.StaticTileVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.isocore.vo.LevelVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.geom.Point;
   
   public class CafeLevelData
   {
       
      
      public var levelVO:LevelVO;
      
      public var levelLuxury:int;
      
      public function CafeLevelData()
      {
         super();
      }
      
      public function resizeMap(param1:int, param2:int, param3:int) : void
      {
         var _loc8_:VisualVO = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         this.levelVO.expansion = CafeModel.wodData.createVObyWOD(param1);
         var _loc4_:int = (this.levelVO.expansion as BasicExpansionVO).sizeX;
         var _loc5_:int = (this.levelVO.expansion as BasicExpansionVO).sizeY;
         this.levelVO.expansionId = (this.levelVO.expansion as BasicExpansionVO).expansionId;
         this.levelVO.mapSize = new Point(_loc4_,_loc5_);
         var _loc6_:int = this.levelVO.floorTiles[0].length;
         var _loc7_:int = this.levelVO.floorTiles.length;
         if(_loc4_ > _loc6_ && _loc5_ > _loc7_)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc5_)
            {
               if(_loc9_ > _loc7_ - 1)
               {
                  this.levelVO.floorTiles[_loc9_] = [];
               }
               _loc10_ = 0;
               while(_loc10_ < _loc4_)
               {
                  if(_loc9_ > _loc7_ - 1 || _loc10_ > _loc6_ - 1)
                  {
                     if(_loc9_ == 0 || _loc10_ == 0)
                     {
                        this.parseTile(param3,_loc10_,_loc9_);
                     }
                     else
                     {
                        this.parseTile(param2,_loc10_,_loc9_);
                     }
                  }
                  _loc10_++;
               }
               _loc9_++;
            }
            BasicController.getInstance().dispatchEvent(new CafeLevelEvent(CafeLevelEvent.SIZE_CHANGE,[_loc4_,_loc5_]));
            BasicController.getInstance().dispatchEvent(new CafeUserEvent(CafeUserEvent.BONUS,[CafeBonusDialogProperties.TYPE_EXPAND]));
            CommandController.instance.executeCommand(CafeShowBonusDialogCommand.COMMAND_NAME,[CafeBonusDialogProperties.TYPE_EXPAND]);
         }
      }
      
      private function parseTile(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:VisualVO;
         (_loc4_ = CafeModel.wodData.createVObyWOD(param1)).isoPos = new Point(param2,param3);
         if(_loc4_.group == CafeConstants.GROUP_WALL)
         {
            this.levelVO.objects.push(_loc4_);
            (_loc4_ = CafeModel.wodData.createVObyWOD(3)).isoPos = new Point(param2,param3);
         }
         this.levelVO.floorTiles[param3][param2] = _loc4_;
      }
      
      public function buildNewLevel(param1:Array) : void
      {
         var _loc4_:StaticTileVO = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:VisualVO = null;
         this.levelVO = new LevelVO();
         this.levelVO.ownerUserID = param1.shift();
         this.levelVO.ownerPlayerID = param1.shift();
         param1.shift();
         param1.shift();
         this.levelVO.ownerName = param1.shift();
         if(this.levelVO.ownerUserID == CafeModel.userData.userID && this.levelVO.ownerPlayerID == CafeModel.userData.playerID)
         {
            this.levelVO.worldType = CafeConstants.CAFE_WORLD_TYPE_MYCAFE;
         }
         else if(this.levelVO.ownerUserID < 0 && this.levelVO.ownerPlayerID < 0)
         {
            this.levelVO.worldType = CafeConstants.CAFE_WORLD_TYPE_MARKETPLACE;
         }
         else
         {
            this.levelVO.worldType = CafeConstants.CAFE_WORLD_TYPE_OTHERPLAYERCAFE;
         }
         this.levelVO.rating = param1.shift();
         this.levelLuxury = param1.shift();
         this.levelVO.expansionId = param1.shift();
         this.levelVO.mapSizeX = param1.shift();
         this.levelVO.mapSizeY = param1.shift();
         this.levelVO.mapSize = new Point(this.levelVO.mapSizeX,this.levelVO.mapSizeY);
         this.levelVO.background = CafeModel.wodData.createVObyWOD(param1.shift());
         var _loc2_:String = param1.shift();
         var _loc3_:Array = _loc2_.split("+");
         this.levelVO.floorTiles = [];
         this.levelVO.objects = [];
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc9_ = Math.floor(_loc6_ / this.levelVO.mapSize.x);
            _loc10_ = _loc6_ - _loc9_ * this.levelVO.mapSize.y;
            if(this.levelVO.floorTiles.length < _loc9_ + 1)
            {
               this.levelVO.floorTiles[_loc9_] = [];
            }
            this.parseTile(_loc3_[_loc6_],_loc10_,_loc9_);
            _loc6_++;
         }
         var _loc8_:Array;
         var _loc7_:String;
         if((_loc8_ = (_loc7_ = param1.shift()).split("#"))[0] != "")
         {
            _loc11_ = 0;
            while(_loc11_ < _loc8_.length)
            {
               _loc13_ = (_loc12_ = _loc8_[_loc11_].split("+")).shift();
               _loc14_ = _loc12_.shift();
               _loc15_ = _loc12_.shift();
               if(!(_loc16_ = CafeModel.wodData.createVObyWOD(_loc15_)))
               {
                  trace("BUG! mapObject is null with wodId " + _loc15_);
               }
               else
               {
                  _loc16_.isoPos = new Point(_loc13_,_loc14_);
                  _loc16_.loadFromParamArray(_loc12_);
                  this.levelVO.objects.push(_loc16_);
                  if(_loc16_.group == CafeConstants.GROUP_DOOR)
                  {
                     this.levelVO.door = _loc16_;
                  }
               }
               _loc11_++;
            }
         }
         BasicController.getInstance().dispatchEvent(new CafeLevelEvent(CafeLevelEvent.INIT_LEVELDATA));
      }
      
      public function isOwnerByUserId(param1:int) : Boolean
      {
         if(this.levelVO.ownerUserID == param1)
         {
            return true;
         }
         return false;
      }
      
      public function changeRanking(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(param1 && param1.length == 1)
         {
            _loc2_ = int(param1[0]);
         }
         this.levelVO.rating += _loc2_;
         if(this.levelVO.rating < 10)
         {
            this.levelVO.rating = 10;
         }
         if(this.levelVO.rating > 1000)
         {
            this.levelVO.rating = 1000;
         }
         var _loc3_:int = Math.min(int((1 + 0.05 * this.levelLuxury) * 10),500);
         if(this.levelVO.rating < _loc3_)
         {
            this.levelVO.rating = _loc3_;
         }
         BasicController.getInstance().dispatchEvent(new CafeLevelEvent(CafeLevelEvent.RATING_CHANGE));
      }
      
      public function checkLevelLuxury(param1:int) : void
      {
         if(param1 != this.levelLuxury)
         {
            this.levelLuxury = param1;
            BasicController.getInstance().dispatchEvent(new CafeLevelEvent(CafeLevelEvent.LUXUS_CHANGE));
         }
      }
   }
}
