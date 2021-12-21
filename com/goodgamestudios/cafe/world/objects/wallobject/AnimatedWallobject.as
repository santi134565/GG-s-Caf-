package com.goodgamestudios.cafe.world.objects.wallobject
{
   import com.goodgamestudios.cafe.world.vo.wallobject.AnimatedWallobjectVO;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.graphics.animation.AnimatedMovieClip;
   import com.goodgamestudios.graphics.animation.event.FrameEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class AnimatedWallobject extends BasicWallobject
   {
       
      
      private var _animDO:AnimatedDisplayObject;
      
      private var _nextLoopPlayback:Number = 0;
      
      public function AnimatedWallobject()
      {
         super();
         isMutable = true;
      }
      
      override protected function initVisualRep() : void
      {
         disp = new Sprite();
         objectLayer = new MovieClip();
         disp.addChild(objectLayer);
         var _loc1_:Class = getDefinitionByName(visClassName) as Class;
         this._animDO = new AnimatedMovieClip(-1,1,visClassName);
         this._animDO.processAnimation(new _loc1_(),null,true);
         this._animDO.setFrameRate((vo as AnimatedWallobjectVO).frameRate);
         this._animDO.play();
         this._animDO.addEventListener(FrameEvent.LOOP_END,this.onLoopEnd);
         objectLayer.addChild(this._animDO.disp);
         disp.cacheAsBitmap = false;
         disp.mouseChildren = true;
         addMouseListener();
         if(isoGridPos)
         {
            updateAlignment();
         }
         this.playAnimation();
      }
      
      private function onLoopEnd(param1:FrameEvent) : void
      {
         if(this.animationDelay > 0)
         {
            this.stopAnimation();
            this._nextLoopPlayback = getTimer() + this.animationDelay * 1000;
         }
      }
      
      public function stopAnimation() : void
      {
         this._animDO.stop();
      }
      
      public function playAnimation() : void
      {
         this._animDO.play();
      }
      
      override public function update(param1:Number) : void
      {
         this.updateVisualRep(param1);
      }
      
      override protected function updateVisualRep(param1:Number) : void
      {
         if(param1 > this._nextLoopPlayback && !this._animDO.isPlaying())
         {
            this.playAnimation();
         }
         this._animDO.playForward();
      }
      
      private function get animationDelay() : int
      {
         return (vo as AnimatedWallobjectVO).animationDelay;
      }
   }
}
