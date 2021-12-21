package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.math.MathBase;
   import com.goodgamestudios.utils.IntPoint;
   import flash.geom.Point;
   
   public class NpcbackgroundMoving extends PlateholderMoving
   {
      
      private static const SPAWN_POINT_XOFFSET:int = 9;
      
      private static const SPAWN_POINT_YOFFSET:int = 9;
      
      private static const SPAWN_POINT_BACKCURVE_X:int = 0;
      
      private static const SPAWN_POINT_BACKCURVE_Y:int = -6;
      
      private static const SPAWN_POINT_SHORTWAY:int = 0;
      
      private static const SPAWN_POINT_LONGWAY:int = -6;
       
      
      public function NpcbackgroundMoving()
      {
         super();
         _speed = 40;
         isClickable = false;
      }
      
      public static function getRandomSpawnpoint(param1:int, param2:int) : Point
      {
         var _loc3_:Array = new Array();
         _loc3_.push(new Point(param1 + SPAWN_POINT_XOFFSET,SPAWN_POINT_SHORTWAY));
         _loc3_.push(new Point(SPAWN_POINT_SHORTWAY,param2 + SPAWN_POINT_YOFFSET));
         _loc3_.push(new Point(param1 + SPAWN_POINT_XOFFSET,SPAWN_POINT_LONGWAY));
         _loc3_.push(new Point(SPAWN_POINT_LONGWAY,param1 + SPAWN_POINT_XOFFSET));
         _loc3_.push(new Point(-(param1 + SPAWN_POINT_XOFFSET),SPAWN_POINT_BACKCURVE_Y));
         _loc3_.push(new Point(SPAWN_POINT_BACKCURVE_X,-(param1 + SPAWN_POINT_XOFFSET)));
         return _loc3_[MathBase.random(0,_loc3_.length - 1)];
      }
      
      override protected function setLogicState(param1:int) : void
      {
         if(param1 == LOGIC_ACTION_ENDPATH)
         {
            (world as CafeIsoWorld).removeBackgroundNPC(this);
         }
      }
      
      override protected function createVisualRep() : Boolean
      {
         var _loc1_:Boolean = super.createVisualRep();
         this.onWalk();
         return _loc1_;
      }
      
      private function onWalk() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         clearPath();
         _path = new Array();
         var _loc1_:Point = isoGridPos.clone();
         var _loc2_:int = SPAWN_POINT_XOFFSET;
         if(_loc1_.x == SPAWN_POINT_BACKCURVE_X && _loc1_.y < SPAWN_POINT_YOFFSET)
         {
            _loc2_ = -(CafeModel.levelData.levelVO.mapSizeY + SPAWN_POINT_YOFFSET);
            _loc3_ = SPAWN_POINT_BACKCURVE_Y;
            _loc5_ = _loc2_ + 1;
            while(_loc5_ < _loc3_)
            {
               _path.push(new IntPoint(_loc1_.x,_loc5_));
               _loc5_++;
            }
            _loc4_ = _loc1_.x;
            while(_loc4_ > _loc2_)
            {
               _path.push(new IntPoint(_loc4_,_loc3_));
               _loc4_--;
            }
            _path.push(new IntPoint(_loc2_,_loc3_));
         }
         if(_loc1_.y == SPAWN_POINT_BACKCURVE_Y && _loc1_.x < SPAWN_POINT_XOFFSET)
         {
            _loc2_ = -(CafeModel.levelData.levelVO.mapSizeX + SPAWN_POINT_XOFFSET);
            _loc3_ = SPAWN_POINT_BACKCURVE_X;
            _loc4_ = _loc2_ - 1;
            while(_loc4_ < _loc3_)
            {
               _path.push(new IntPoint(_loc4_,_loc1_.y));
               _loc4_++;
            }
            _loc5_ = _loc1_.y;
            while(_loc5_ > _loc2_)
            {
               _path.push(new IntPoint(_loc3_,_loc5_));
               _loc5_--;
            }
            _path.push(new IntPoint(_loc3_,_loc2_));
         }
         if((_loc1_.x == SPAWN_POINT_SHORTWAY || _loc1_.x == SPAWN_POINT_LONGWAY) && _loc1_.y > SPAWN_POINT_YOFFSET)
         {
            _loc2_ += CafeModel.levelData.levelVO.mapSizeY;
            _loc3_ = _loc1_.x;
            if(_loc3_ == SPAWN_POINT_SHORTWAY && MathBase.random(1,2) == 1)
            {
               _loc3_ = SPAWN_POINT_LONGWAY;
            }
            _loc5_ = _loc2_ - 1;
            while(_loc5_ > _loc3_)
            {
               _path.push(new IntPoint(_loc1_.x,_loc5_));
               _loc5_--;
            }
            _loc4_ = _loc1_.x;
            while(_loc4_ < _loc2_)
            {
               _path.push(new IntPoint(_loc4_,_loc3_));
               _loc4_++;
            }
            _path.push(new IntPoint(_loc2_,_loc3_));
         }
         if((_loc1_.y == SPAWN_POINT_SHORTWAY || _loc1_.y == SPAWN_POINT_LONGWAY) && _loc1_.x > SPAWN_POINT_XOFFSET)
         {
            _loc2_ += CafeModel.levelData.levelVO.mapSizeX;
            _loc3_ = _loc1_.y;
            _loc4_ = _loc2_ - 1;
            while(_loc4_ > _loc3_)
            {
               _path.push(new IntPoint(_loc4_,_loc1_.y));
               _loc4_--;
            }
            _loc5_ = _loc1_.y;
            while(_loc5_ < _loc2_)
            {
               _path.push(new IntPoint(_loc3_,_loc5_));
               _loc5_++;
            }
            _path.push(new IntPoint(_loc3_,_loc2_));
         }
         _path.reverse();
         _isWalkingPath = true;
         startWalkPathAction();
      }
   }
}
