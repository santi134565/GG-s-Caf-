package com.goodgamestudios.cafe.world.objects.chair
{
   import com.goodgamestudios.cafe.world.objects.CafeInteractiveFloorObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class BackChair extends CafeInteractiveFloorObject
   {
       
      
      public var parent:BasicChair;
      
      public function BackChair()
      {
         super();
         isMutable = false;
      }
      
      override protected function initVisualRep() : void
      {
         disp = new Sprite();
         var _loc1_:Class = getDefinitionByName(visClassName) as Class;
         objectLayer = new Sprite();
         disp.addChild(objectLayer);
         objectdisp = new _loc1_();
         objectLayer.addChild(objectdisp);
         addMouseListener();
         deltaDepth = 0.35;
         this.setRotationGfx();
      }
      
      override protected function onMouseDownDeko(param1:MouseEvent) : void
      {
         this.parent.addGlow();
         this.parent.selectObject();
         this.parent.startDrag();
      }
      
      override protected function onRollOutRun(param1:MouseEvent) : void
      {
         this.parent.removeGlow();
      }
      
      override protected function onRollOutDeko(param1:MouseEvent) : void
      {
         if(world.mouse.iDragObject != this.parent)
         {
            this.parent.removeGlow();
         }
      }
      
      override protected function onRollOverRun(param1:MouseEvent) : void
      {
      }
      
      override protected function onRollOverDeko(param1:MouseEvent) : void
      {
         this.parent.addGlow();
      }
      
      override public function setRotationGfx() : void
      {
         if(isoRotation == 1 || isoRotation == 2)
         {
            show();
         }
         else
         {
            hide();
         }
         if(isoRotation < 2)
         {
            mirrorObject(1);
         }
         else
         {
            mirrorObject(-1);
         }
      }
      
      override public function rotate() : void
      {
         --isoRotation;
         this.setRotationGfx();
      }
   }
}
