package com.goodgamestudios.cafe.world.objects.fridge
{
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.world.info.FridgeToolTip;
   import com.goodgamestudios.cafe.world.objects.CafeInteractiveFloorObject;
   import flash.events.MouseEvent;
   
   public class BasicFridge extends CafeInteractiveFloorObject
   {
       
      
      private var infoToolTip:FridgeToolTip;
      
      public function BasicFridge()
      {
         super();
         isClickable = true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.infoToolTip = new FridgeToolTip(this);
         world.toolTipLayer.addChild(this.infoToolTip.disp);
      }
      
      override protected function onMouseUpRun(param1:MouseEvent) : void
      {
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.FRIDGE_CLICK,[this]));
      }
      
      override protected function onRollOverRun(param1:MouseEvent) : void
      {
         if(isClickable)
         {
            this.infoToolTip.showInfoToolTip();
            addGlow();
         }
      }
      
      override protected function onRollOutRun(param1:MouseEvent) : void
      {
         this.infoToolTip.hide();
         removeGlow();
      }
      
      public function updateToolTipTextFields() : void
      {
         if(this.infoToolTip)
         {
            this.infoToolTip.updateAllTextFields();
         }
      }
      
      override public function get removeAllowed() : Boolean
      {
         return true;
      }
   }
}
