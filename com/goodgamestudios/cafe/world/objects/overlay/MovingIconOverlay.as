package com.goodgamestudios.cafe.world.objects.overlay
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.overlay.MovingIconOverlayVO;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MovingIconOverlay extends MovingOverlay
   {
       
      
      private var timeToShow:int = 0;
      
      protected var icon:Sprite;
      
      public function MovingIconOverlay()
      {
         super();
      }
      
      public function get movingIconOverlayVO() : MovingIconOverlayVO
      {
         return vo as MovingIconOverlayVO;
      }
      
      private function scaleIcon(param1:Sprite, param2:Number) : Sprite
      {
         var _loc4_:Number = NaN;
         var _loc5_:Rectangle = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Sprite = param1;
         if(_loc3_.scale9Grid == null)
         {
            _loc4_ = param2 / _loc3_.width;
            if(_loc3_.height * _loc4_ > param2)
            {
               _loc4_ = param2 / _loc3_.height;
            }
            _loc3_.scaleX = _loc3_.scaleY = _loc4_;
            _loc5_ = _loc3_.getBounds(_loc3_);
            _loc3_.x = -_loc5_.left * _loc4_ - _loc5_.width * _loc4_ / 2;
            _loc3_.y = -_loc5_.top * _loc4_ - _loc5_.height * _loc4_ / 2;
         }
         else
         {
            _loc4_ = param2 / _loc3_.scale9Grid.width;
            if(_loc3_.scale9Grid.height * _loc4_ > param2)
            {
               _loc4_ = param2 / _loc3_.scale9Grid.height;
            }
            _loc3_.scale9Grid = null;
            _loc3_.scaleX = _loc3_.scaleY = _loc4_;
            _loc5_ = _loc3_.getBounds(_loc3_);
            _loc3_.x = -_loc5_.left * _loc4_ - _loc5_.width * _loc4_ / 2;
            _loc3_.y = -_loc5_.top * _loc4_ - _loc5_.height * _loc4_ / 2;
         }
         return _loc3_;
      }
      
      override public function update(param1:Number) : void
      {
         if(this.timeToShow && getTimer() > this.timeToShow)
         {
            super.show();
            this.timeToShow = 0;
         }
         super.update(param1);
      }
      
      override public function show() : void
      {
         if(this.movingIconOverlayVO.timeDelay > 0 && this.timeToShow < 1)
         {
            this.timeToShow = getTimer() + this.movingIconOverlayVO.timeDelay;
         }
         else if(this.movingIconOverlayVO.timeDelay > 0 && getTimer() > this.timeToShow)
         {
            super.show();
            this.timeToShow = 0;
         }
         else if(this.movingIconOverlayVO.timeDelay < 1)
         {
            super.show();
            this.timeToShow = 0;
         }
      }
      
      override protected function createVisualRep() : Boolean
      {
         var _loc2_:Sprite = null;
         if(!super.createVisualRep())
         {
            return false;
         }
         var _loc1_:Class = getDefinitionByName(CafeModel.wodData.voList[this.movingIconOverlayVO.iconWodId].getVisClassName()) as Class;
         this.icon = new _loc1_();
         if(!this.icon)
         {
            return false;
         }
         this.icon = this.scaleIcon(this.icon,30);
         if(this.icon != null)
         {
            this.icon.cacheAsBitmap = true;
            _loc2_ = getDispChildAt(0) as Sprite;
            if(textField)
            {
               textField.x = this.icon.width / 2 + 5;
               textField.y = -this.icon.height / 2;
            }
            if(_loc2_ != null)
            {
               _loc2_.addChild(this.icon);
            }
         }
         return true;
      }
   }
}
