package com.goodgamestudios.ai.astar
{
   import com.goodgamestudios.utils.IntPoint;
   
   public class AStar
   {
      
      private static const COST_ORTHOGONAL:Number = 1;
       
      
      private var _useWallWalkables:Boolean;
      
      private var width:int;
      
      private var height:int;
      
      private var start:AStarNode;
      
      private var goal:AStarNode;
      
      private var map:Array;
      
      public var open:Array;
      
      public var closed:Array;
      
      public var visited:Array;
      
      private var hFactor:Number;
      
      public function AStar(param1:IAStarSearchable, param2:IntPoint, param3:IntPoint, param4:Boolean = false, param5:Number = 1.00001)
      {
         this.visited = [];
         super();
         this._useWallWalkables = param4;
         this.width = param1.getWidth();
         this.height = param1.getHeight();
         this.start = new AStarNode(param2.x,param2.y);
         this.goal = new AStarNode(param3.x,param3.y,param1.isWalkable(param3.x,param3.y));
         this.map = this.createMap(param1);
         this.hFactor = param5;
      }
      
      private static function hasElement(param1:Array, param2:AStarNode) : Boolean
      {
         var _loc3_:AStarNode = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_.x == param2.x && _loc3_.y == param2.y)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function removeFromArray(param1:Array, param2:Object) : Boolean
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               param1.splice(_loc3_,1);
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function solve() : Array
      {
         var _loc3_:AStarNode = null;
         var _loc4_:Array = null;
         this.open = new Array();
         this.closed = new Array();
         var _loc1_:AStarNode = this.start;
         this.open.push(_loc1_);
         var _loc2_:Boolean = false;
         if(!this.goal.walkable)
         {
            return null;
         }
         while(!_loc2_ && this.open.length > 0)
         {
            this.open.sortOn("f",Array.NUMERIC);
            _loc1_ = this.open.shift();
            if(_loc1_.x == this.goal.x && _loc1_.y == this.goal.y)
            {
               _loc2_ = true;
            }
            else
            {
               this.closed.push(_loc1_);
               for each(_loc3_ in this.neighbors(_loc1_))
               {
                  if(!hasElement(this.open,_loc3_) && !hasElement(this.closed,_loc3_))
                  {
                     _loc3_.parent = _loc1_;
                     _loc3_.g = _loc1_.g + 1;
                     _loc3_.h = this.hFactor * this.distManhattan(this.goal,_loc3_);
                     _loc3_.f += _loc3_.h + _loc3_.g;
                     this.open.push(_loc3_);
                  }
               }
            }
         }
         if(_loc2_)
         {
            (_loc4_ = new Array()).push(new IntPoint(_loc1_.x,_loc1_.y));
            while(_loc1_.parent && _loc1_.parent != this.start)
            {
               _loc1_ = _loc1_.parent;
               _loc4_.push(new IntPoint(_loc1_.x,_loc1_.y));
            }
            _loc4_.push(new IntPoint(_loc1_.x,_loc1_.y));
            return _loc4_;
         }
         return null;
      }
      
      private function visit(param1:AStarNode) : void
      {
         var _loc2_:AStarNode = null;
      }
      
      private function distManhattan(param1:AStarNode, param2:AStarNode) : Number
      {
         return Math.abs(param1.x - param2.x) + Math.abs(param1.y - param2.y);
      }
      
      private function distEuclidian(param1:AStarNode, param2:AStarNode = null) : Number
      {
         if(param2 == null)
         {
            param2 = this.goal;
         }
         return Math.sqrt(Math.pow(param1.x - param2.x,2) + Math.pow(param1.y - param2.y,2));
      }
      
      private function neighbors(param1:AStarNode) : Array
      {
         var _loc4_:AStarNode = null;
         var _loc2_:int = param1.x;
         var _loc3_:int = param1.y;
         var _loc5_:Array = [];
         if(_loc2_ > 0)
         {
            _loc4_ = this.map[_loc2_ - 1][_loc3_];
            if(this._useWallWalkables && param1.walkLeftUp && _loc4_.walkable && _loc4_.walkRightDown)
            {
               _loc5_.push(_loc4_);
            }
            if(!this._useWallWalkables && _loc4_.walkable)
            {
               _loc5_.push(_loc4_);
            }
         }
         if(_loc2_ < this.width - 1)
         {
            _loc4_ = this.map[_loc2_ + 1][_loc3_];
            if(this._useWallWalkables && param1.walkRightDown && _loc4_.walkable && _loc4_.walkLeftUp)
            {
               _loc5_.push(_loc4_);
            }
            if(!this._useWallWalkables && _loc4_.walkable)
            {
               _loc5_.push(_loc4_);
            }
         }
         if(_loc3_ > 0)
         {
            _loc4_ = this.map[_loc2_][_loc3_ - 1];
            if(this._useWallWalkables && param1.walkRightUp && _loc4_.walkable && _loc4_.walkLeftDown)
            {
               _loc5_.push(_loc4_);
            }
            if(!this._useWallWalkables && _loc4_.walkable)
            {
               _loc5_.push(_loc4_);
            }
         }
         if(_loc3_ < this.height - 1)
         {
            _loc4_ = this.map[_loc2_][_loc3_ + 1];
            if(this._useWallWalkables && param1.walkLeftDown && _loc4_.walkable && _loc4_.walkRightUp)
            {
               _loc5_.push(_loc4_);
            }
            if(!this._useWallWalkables && _loc4_.walkable)
            {
               _loc5_.push(_loc4_);
            }
         }
         return _loc5_;
      }
      
      private function createMap(param1:IAStarSearchable) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:AStarNode = null;
         var _loc2_:Array = new Array(this.width);
         var _loc3_:int = 0;
         while(_loc3_ < this.width)
         {
            _loc2_[_loc3_] = new Array(this.height);
            _loc4_ = 0;
            while(_loc4_ < this.height)
            {
               if(this._useWallWalkables)
               {
                  _loc5_ = new AStarNode(_loc3_,_loc4_,param1.isWalkable(_loc3_,_loc4_),param1.isWalkLeftUp(_loc3_,_loc4_),param1.isWalkRightUp(_loc3_,_loc4_),param1.isWalkLeftDown(_loc3_,_loc4_),param1.isWalkRightDown(_loc3_,_loc4_));
               }
               else
               {
                  _loc5_ = new AStarNode(_loc3_,_loc4_,param1.isWalkable(_loc3_,_loc4_));
               }
               _loc2_[_loc3_][_loc4_] = _loc5_;
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
