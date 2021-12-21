package com.goodgamestudios.cafe.world.objects.overlay
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.overlay.StaticIconOverlayVO;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.graphics.animation.AnimatedMovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class StaticIconOverlay extends StaticOverlay
   {
       
      
      protected var icon:AnimatedDisplayObject;
      
      private var _framesPerPixelPerSecond:Number = 0.34;
      
      private var _defaultSpeed:int = 20;
      
      public function StaticIconOverlay()
      {
         super();
      }
      
      override protected function createVisualRep() : Boolean
      {
         if(!super.createVisualRep())
         {
            return false;
         }
         var _loc1_:Class = getDefinitionByName(CafeModel.wodData.voList[this.staticIconOverlayVO.iconWodId].getVisClassName()) as Class;
         this.icon = new AnimatedMovieClip(-1,1,name);
         this.icon.processAnimation(new _loc1_(),null);
         this.icon.setFrameRate(Math.floor(this._framesPerPixelPerSecond * this._defaultSpeed));
         if(!this.icon)
         {
            return false;
         }
         this.scaleIcon(40);
         var _loc2_:Sprite = getDispChildAt(0) as Sprite;
         if(textField)
         {
            textField.x = this.icon.disp.width / 2 + 5;
            textField.y = -this.icon.disp.height / 2;
         }
         if(_loc2_ != null)
         {
            while(_loc2_.numChildren > 0)
            {
               _loc2_.removeChildAt(0);
            }
            _loc2_.addChild(this.icon.disp);
         }
         this.icon.play();
         return true;
      }
      
      public function get staticIconOverlayVO() : StaticIconOverlayVO
      {
         return vo as StaticIconOverlayVO;
      }
      
      private function scaleIcon(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Rectangle = null;
         if(this.icon.disp.scale9Grid == null)
         {
            _loc2_ = param1 / this.icon.disp.width;
            if(this.icon.disp.height * _loc2_ > param1)
            {
               _loc2_ = param1 / this.icon.disp.height;
            }
            this.icon.disp.scaleX = this.icon.disp.scaleY = _loc2_;
            _loc3_ = this.icon.bounds;
            this.icon.disp.x = -_loc3_.left * _loc2_ - _loc3_.width * _loc2_ / 2;
            this.icon.disp.y = -_loc3_.top * _loc2_ - _loc3_.height * _loc2_ / 2;
         }
         else
         {
            _loc2_ = param1 / this.icon.disp.scale9Grid.width;
            if(this.icon.disp.scale9Grid.height * _loc2_ > param1)
            {
               _loc2_ = param1 / this.icon.disp.scale9Grid.height;
            }
            this.icon.disp.scale9Grid = null;
            this.icon.disp.scaleX = this.icon.disp.scaleY = _loc2_;
            _loc3_ = this.icon.bounds;
            this.icon.disp.x = -_loc3_.left * _loc2_ - _loc3_.width * _loc2_ / 2;
            this.icon.disp.y = -_loc3_.top * _loc2_ - _loc3_.height * _loc2_ / 2;
         }
      }
      
      override protected function updateVisualRep(param1:Number) : void
      {
         super.updateVisualRep(param1);
         if(this.icon)
         {
            this.icon.playForward();
         }
      }
   }
}
