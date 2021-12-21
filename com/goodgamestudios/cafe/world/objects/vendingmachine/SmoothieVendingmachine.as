package com.goodgamestudios.cafe.world.objects.vendingmachine
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeSmoothiemakerDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeSmoothiemakerDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.fastfood.BasicFastfoodVO;
   import com.goodgamestudios.cafe.world.vo.vendingmachine.BasicVendingmachineVO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   
   public class SmoothieVendingmachine extends BasicVendingmachine
   {
       
      
      private var mc_bubbles_startY:Number;
      
      private var mc_liquid_startY:Number;
      
      private var mc_bubbles:MovieClip;
      
      private var mc_liquid:MovieClip;
      
      private var mc_drink:MovieClip;
      
      public function SmoothieVendingmachine()
      {
         super();
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.mc_bubbles = (objectLayer.getChildAt(0) as MovieClip).mc_blubber;
         this.mc_liquid = (objectLayer.getChildAt(0) as MovieClip).mc_food;
         this.mc_drink = (objectLayer.getChildAt(0) as MovieClip).mc_drink;
         this.mc_bubbles.stop();
         this.mc_bubbles.visible = false;
         this.mc_bubbles_startY = this.mc_bubbles.y;
         this.mc_liquid_startY = this.mc_liquid.y;
         this.updateGraphics();
         if((vo as BasicVendingmachineVO).fastfoodAmount < 1)
         {
            this.mc_liquid.visible = false;
            if(this.mc_drink)
            {
               this.mc_drink.visible = false;
            }
            this.mc_bubbles.visible = false;
         }
         else
         {
            this.changeColor((CafeModel.wodData.voList[usedFastFoodWodId] as BasicFastfoodVO).color);
         }
      }
      
      override public function rotate() : void
      {
         super.rotate();
         this.mc_drink = (objectLayer.getChildAt(0) as MovieClip).mc_drink;
         this.updateGraphics();
         if(usedFastFoodWodId > 0)
         {
            this.changeColor((CafeModel.wodData.voList[usedFastFoodWodId] as BasicFastfoodVO).color);
         }
      }
      
      public function changeColor(param1:uint) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.color = param1;
         if(this.mc_drink)
         {
            MovieClip(this.mc_drink).transform.colorTransform = _loc2_;
         }
         MovieClip(this.mc_liquid.cc1).transform.colorTransform = _loc2_;
         MovieClip(this.mc_liquid.cc2).transform.colorTransform = _loc2_;
      }
      
      override protected function updateGraphics() : void
      {
         if(this.numFastFood > 0)
         {
            currentStatus = VENDING_STATUS_INUSE;
         }
         this.mc_bubbles.visible = this.numFastFood > 0;
         this.mc_bubbles.gotoAndPlay(1);
         trace("Smoothiemaker hat noch " + percentFilled + "%");
         this.mc_bubbles.y = this.mc_bubbles_startY + 20 - 20 * percentFilled;
         this.mc_bubbles.alpha = 1;
         if(isoRotation == 1 || isoRotation == 2)
         {
            this.mc_bubbles.y -= 10;
            this.mc_bubbles.alpha = percentFilled;
         }
         this.mc_liquid.visible = this.numFastFood > 0;
         if(this.mc_drink)
         {
            this.mc_drink.visible = this.numFastFood > 0;
         }
         this.mc_liquid.y = this.mc_liquid_startY + 20 - 20 * percentFilled;
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
         if(this.mc_bubbles.visible && this.mc_bubbles.currentFrame == 33)
         {
            this.mc_bubbles.visible = false;
            this.mc_bubbles.gotoAndStop(1);
            updateStatus();
         }
      }
      
      override protected function onClickError_NotEmpty() : void
      {
         CafeLayoutManager.getInstance().showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("alert_smoothiemaker_full_copy")));
      }
      
      override protected function onMouseUpRun(param1:MouseEvent) : void
      {
         if(CafeLayoutManager.getInstance().currentState != CafeLayoutManager.STATE_MY_CAFE)
         {
            return;
         }
         super.onMouseUpRun(param1);
         if(currentStatus == VENDING_STATUS_EMPTY)
         {
            CafeLayoutManager.getInstance().showDialog(CafeSmoothiemakerDialog.NAME,new CafeSmoothiemakerDialogProperties(this));
         }
      }
      
      override public function get numFastFood() : int
      {
         if(tempNum > -1)
         {
            return tempNum;
         }
         return super.numFastFood;
      }
      
      override public function set usedFastFoodWodId(param1:int) : void
      {
         super.usedFastFoodWodId = param1;
         if(param1 > 0)
         {
            this.changeColor((CafeModel.wodData.voList[param1] as BasicFastfoodVO).color);
         }
      }
   }
}
