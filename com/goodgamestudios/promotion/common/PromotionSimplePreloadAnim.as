package com.goodgamestudios.promotion.common
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class PromotionSimplePreloadAnim extends Sprite
   {
       
      
      private var startTime:Number;
      
      private var currentDegree:int = 0;
      
      private var ggsLogo:GGS_Logo_Promotion;
      
      public var circleRadius:Number = 8;
      
      public var numCircles:Number = 20;
      
      public var speed:int = 5;
      
      public var preloadWidth:Number = 50;
      
      public var preloadHeight:Number = 50;
      
      public var usedDegrees:Number = 120;
      
      public function PromotionSimplePreloadAnim()
      {
         super();
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(event:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         ggsLogo = new GGS_Logo_Promotion();
         var _loc2_:Number = (preloadWidth - 10) / ggsLogo.width;
         ggsLogo.scaleX = ggsLogo.scaleY = _loc2_;
         addChild(ggsLogo);
         ggsLogo.x = stage.stageWidth / 2;
         ggsLogo.y = stage.stageHeight / 2;
         startTime = getTimer();
         addEventListener("removedFromStage",onRemovedFromStage);
         addEventListener("enterFrame",updatePreloadAnim);
      }
      
      private function onRemovedFromStage(event:Event) : void
      {
         removeEventListener("removedFromStage",onRemovedFromStage);
         removeEventListener("enterFrame",updatePreloadAnim);
      }
      
      private function updatePreloadAnim(event:Event) : void
      {
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = getTimer();
         currentDegree += (_loc2_ - startTime) / speed;
         startTime = _loc2_;
         if(currentDegree >= 360)
         {
            currentDegree = 0;
         }
         graphics.clear();
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         while(_loc3_ < 360)
         {
            _loc4_ = Number(_loc3_ > currentDegree ? 1 - (360 - _loc3_ + currentDegree) / usedDegrees : Number(1 - (currentDegree - _loc3_) / usedDegrees));
            _loc6_ = Math.cos(_loc3_ * (3.141592653589793 / 180)) * preloadWidth + stage.stageWidth / 2;
            _loc5_ = Math.sin(_loc3_ * (3.141592653589793 / 180)) * preloadHeight + stage.stageHeight / 2;
            graphics.beginFill(14540253,1);
            graphics.drawCircle(_loc6_,_loc5_,circleRadius);
            graphics.beginFill(2506366,Math.max(0,_loc4_));
            graphics.drawCircle(_loc6_,_loc5_,circleRadius);
            _loc3_ += Math.floor(360 / numCircles) + 360 % numCircles / numCircles;
         }
      }
   }
}
