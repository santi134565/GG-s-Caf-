package com.goodgamestudios.cafe.view
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.math.MathBase;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeBackgroundComponent extends BasicBackgroundComponent
   {
       
      
      private const MAX_TRY:int = 20;
      
      private const PRELOAD_POS:Array = [-85,-28,28,85];
      
      private const ASSETS:Array = [PreloadIngredient_0,PreloadIngredient_1,PreloadIngredient_2,PreloadIngredient_3,PreloadIngredient_4,PreloadIngredient_5,PreloadIngredient_6,PreloadIngredient_7,PreloadIngredient_8,PreloadIngredient_9,PreloadIngredient_10];
      
      private var ingredientIndex:Array;
      
      public function CafeBackgroundComponent(param1:CafeTitle)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         customCursor = new BasicCustomCursor(new CursorGfx());
         customCursor.init();
         this.cafeTitle.addChild(customCursor.disp);
         background.mc_logo.mc_instants2.visible = this.env.instanceId > 1 && this.env.forceInstanceConnect;
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Number = NaN;
         if(background)
         {
            _loc1_ = backgroundView.mc_bg.mc_mask.getBounds(null);
            _loc2_ = backgroundView.stage.stageWidth / _loc1_.width;
            if(_loc1_.height * _loc2_ > backgroundView.stage.stageHeight)
            {
               _loc2_ = backgroundView.stage.stageHeight / _loc1_.height;
            }
            backgroundView.mc_bg.scaleX = backgroundView.mc_bg.scaleY = _loc2_;
            backgroundView.mc_bg.x = (backgroundView.stage.stageWidth - _loc1_.width * _loc2_) / 2;
         }
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         if(customCursor.disp && customCursor.disp.parent)
         {
            this.cafeTitle.removeChild(customCursor.disp);
         }
      }
      
      override protected function get progressBar() : MovieClip
      {
         return backgroundView.mc_bg.mc_progressBar;
      }
      
      override public function updateLoadingProgress(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Class = null;
         var _loc6_:Sprite = null;
         if(param1 <= 19 || param1 > 99)
         {
            this.ingredientIndex = new Array();
            while(this.progressBar.mc_holder.numChildren > 0)
            {
               this.progressBar.mc_holder.removeChildAt(0);
            }
         }
         else
         {
            _loc2_ = param1 / 20;
            if(this.progressBar.mc_holder.numChildren < _loc2_)
            {
               _loc3_ = 0;
               _loc4_ = MathBase.random(0,this.ASSETS.length - 1);
               while(this.ingredientIndex.indexOf(_loc4_) >= 0 && _loc3_ < this.MAX_TRY)
               {
                  _loc4_ = MathBase.random(0,this.ASSETS.length - 1);
                  _loc3_++;
               }
               this.ingredientIndex.push(_loc4_);
               (_loc6_ = new (_loc5_ = getDefinitionByName("PreloadIngredient_" + _loc4_) as Class)()).x = this.PRELOAD_POS[_loc2_ - 1];
               this.progressBar.mc_holder.addChild(_loc6_);
            }
         }
      }
      
      private function get cafeTitle() : CafeTitle
      {
         return disp as CafeTitle;
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
