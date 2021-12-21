package com.goodgamestudios.ai.astar
{
   import com.goodgamestudios.utils.IntPoint;
   
   public class AStarNode extends IntPoint
   {
       
      
      public var g:Number = 0;
      
      public var h:Number = 0;
      
      public var f:Number = 0;
      
      public var parent:AStarNode;
      
      public var walkable:Boolean;
      
      public var walkLeftUp:Boolean;
      
      public var walkRightUp:Boolean;
      
      public var walkLeftDown:Boolean;
      
      public var walkRightDown:Boolean;
      
      public function AStarNode(param1:int, param2:int, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true, param6:Boolean = true, param7:Boolean = true)
      {
         super(param1,param2);
         this.walkable = param3;
         this.walkLeftUp = param4;
         this.walkLeftDown = param6;
         this.walkRightUp = param5;
         this.walkRightDown = param7;
      }
   }
}
