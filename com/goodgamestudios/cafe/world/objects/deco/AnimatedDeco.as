package com.goodgamestudios.cafe.world.objects.deco
{
   import com.goodgamestudios.cafe.world.vo.deco.AnimatedDecoVO;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.graphics.animation.AnimatedMovieClip;
   import com.goodgamestudios.graphics.animation.event.FrameEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class AnimatedDeco extends BasicDeco
   {
       
      
      private var _animDO:AnimatedDisplayObject;
      
      private var _nextLoopPlayback:Number = 0;
      
      public function AnimatedDeco()
      {
         super();
         isMutable = true;
      }
      
      override protected function initVisualRep() : void
      {
         disp = new Sprite();
         objectLayer = new Sprite();
         disp.addChild(objectLayer);
         disp.mouseChildren = true;
         iconLayer = new Sprite();
         disp.addChild(iconLayer);
         addMouseListener();
         disp.cacheAsBitmap = false;
         var _loc1_:Class = getDefinitionByName(visClassName) as Class;
         this._animDO = new AnimatedMovieClip(-1,1,visClassName);
         this._animDO.processAnimation(new _loc1_(),null,true);
         this._animDO.setFrameRate((vo as AnimatedDecoVO).frameRate);
         this._animDO.play();
         this._animDO.addEventListener(FrameEvent.LOOP_END,this.onLoopEnd);
         objectdisp = new MovieClip();
         objectdisp.addChild(this._animDO.disp);
         objectLayer.addChild(objectdisp);
         setRotationGfx();
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
      
      override public function remove() : void
      {
         if(this._animDO)
         {
            this._animDO.removeEventListener(FrameEvent.LOOP_END,this.onLoopEnd);
         }
         super.remove();
      }
      
      private function get animationDelay() : int
      {
         return (vo as AnimatedDecoVO).animationDelay;
      }
   }
}
