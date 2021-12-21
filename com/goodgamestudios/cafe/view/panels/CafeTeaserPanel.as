package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class CafeTeaserPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeTeaserPanel";
       
      
      public function CafeTeaserPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.teaserPanel.txt_copy.text = CafeModel.languageData.getTextById("generic_register_forfree");
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Number = NaN;
         if(disp && disp.stage)
         {
            _loc1_ = (this.backgroundView as MovieClip).mc_mask.getBounds(null);
            _loc2_ = this.backgroundView.stage.stageWidth / _loc1_.width;
            if(_loc1_.height * _loc2_ > this.backgroundView.stage.stageHeight)
            {
               _loc2_ = this.backgroundView.stage.stageHeight / _loc1_.height;
            }
            disp.x = this.backgroundView.x - 13 * _loc2_;
            disp.scaleX = disp.scaleY = _loc2_;
            disp.y = this.backgroundView.y - 23 * _loc2_;
         }
      }
      
      private function get backgroundView() : MovieClip
      {
         return (layoutManager.background as MovieClip).mc_bg as MovieClip;
      }
      
      private function get teaserPanel() : TeaserPanel
      {
         return disp as TeaserPanel;
      }
   }
}
