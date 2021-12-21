package com.goodgamestudios.cafe.world.objects
{
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.world.CafeIsoMouse;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.vo.InteractiveFloorVO;
   import com.goodgamestudios.isocore.IsoMouse;
   import com.goodgamestudios.isocore.objects.InteractiveFloorObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeInteractiveFloorObject extends InteractiveFloorObject
   {
      
      private static const ROTATE_ICON_NAME:String = "Rotate_Icon";
      
      private static const ROTATE_ICON_HEIGHT:int = -60;
      
      private static const ROTATE_ICON_SHIFT:int = 10;
      
      protected static const rotationDir:Array = [[[1],[0]],[[0],[-1]],[[-1],[0]],[[0],[1]]];
      
      protected static const rotationIsoDir:Array = [[[1],[1]],[[1],[-1]],[[-1],[-1]],[[-1],[1]]];
       
      
      private var rotateIconMC:Sprite;
      
      protected var rotateIconGlowfilter:GlowFilter;
      
      protected var _isInWorkList:Boolean = false;
      
      public function CafeInteractiveFloorObject()
      {
         this.rotateIconGlowfilter = new GlowFilter(16777215,1,6,6,4);
         super();
         isMutable = true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.setRotationGfx();
      }
      
      private function get rotateIconHeight() : Number
      {
         var _loc1_:Rectangle = objectLayer.getBounds(null);
         if(_loc1_.top < ROTATE_ICON_HEIGHT)
         {
            return _loc1_.top - ROTATE_ICON_HEIGHT - ROTATE_ICON_SHIFT;
         }
         return 0;
      }
      
      public function get isInWorkList() : Boolean
      {
         return this._isInWorkList;
      }
      
      public function set isInWorkList(param1:Boolean) : void
      {
         if(param1)
         {
            objectLayer.alpha = 0.5;
         }
         else
         {
            objectLayer.alpha = 1;
         }
         this._isInWorkList = param1;
      }
      
      protected function addRotateIcon() : void
      {
         var _loc1_:Class = getDefinitionByName(ROTATE_ICON_NAME) as Class;
         this.rotateIconMC = new _loc1_();
         this.rotateIconMC.y = this.rotateIconHeight;
         iconLayer.addChild(this.rotateIconMC);
         this.rotateIconMC.name = "RotateIcon";
         this.rotateIconMC.addEventListener(MouseEvent.CLICK,this.onRotateClick);
         this.rotateIconMC.addEventListener(MouseEvent.ROLL_OVER,this.onRotateRollOver);
         this.rotateIconMC.addEventListener(MouseEvent.ROLL_OUT,this.onRotateRollOut);
      }
      
      protected function removeRotateIcon() : void
      {
         if(this.rotateIconMC)
         {
            this.rotateIconMC.removeEventListener(MouseEvent.CLICK,this.onRotateClick);
            this.rotateIconMC.removeEventListener(MouseEvent.ROLL_OVER,this.onRotateRollOver);
            this.rotateIconMC.removeEventListener(MouseEvent.ROLL_OUT,this.onRotateRollOut);
            iconLayer.removeChild(this.rotateIconMC);
         }
         this.rotateIconMC = null;
      }
      
      private function onRotateClick(param1:MouseEvent) : void
      {
         if(world.mouse.iDragObjectIsLocked)
         {
            return;
         }
         this.rotate();
      }
      
      private function onRotateRollOver(param1:MouseEvent) : void
      {
         world.mouse.switchState(IsoMouse.ISOMOUSE_STATE_FREE);
         this.rotateIconMC.filters = [this.rotateIconGlowfilter];
      }
      
      private function onRotateRollOut(param1:MouseEvent) : void
      {
         world.mouse.switchState(IsoMouse.ISOMOUSE_STATE_SNAP);
         this.rotateIconMC.filters = [];
      }
      
      public function rotate() : void
      {
         --isoRotation;
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.EDITOR_EVENT,[CafeIsoEvent.EDITOR_ROTATE,isoGridPos.x,isoGridPos.y,isoRotation]));
         this.setRotationGfx();
      }
      
      public function setRotationGfx() : void
      {
         var _loc1_:int = (getVisualVO() as InteractiveFloorVO).rotationType;
         switch(_loc1_)
         {
            case 2:
               if(isoRotation == 0 || isoRotation == 2)
               {
                  mirrorObject(1);
               }
               else
               {
                  mirrorObject(-1);
               }
               break;
            case 3:
               if(isoRotation < 2)
               {
                  mirrorObject(1);
               }
               else
               {
                  mirrorObject(-1);
               }
               if(isoRotation == 0 || isoRotation == 3)
               {
                  objectdisp.gotoAndStop(1);
               }
               else
               {
                  objectdisp.gotoAndStop(2);
               }
               break;
            case 4:
               objectdisp.gotoAndStop(isoRotation + 1);
         }
      }
      
      override public function selectObject() : void
      {
         super.selectObject();
         if(world.mouse.objectsSelectable && (getVisualVO() as InteractiveFloorVO).rotationType > 1)
         {
            this.addRotateIcon();
         }
      }
      
      override public function deSelectObject() : void
      {
         super.deSelectObject();
         this.removeRotateIcon();
      }
      
      override public function startDrag() : void
      {
         addGlow();
         super.startDrag();
      }
      
      override public function stopDrag() : void
      {
         super.stopDrag();
         removeGlow();
      }
      
      protected function isoRotationToIsoDir() : Point
      {
         return new Point(int(rotationIsoDir[isoRotation][0]),int(rotationIsoDir[isoRotation][1]));
      }
      
      protected function get cafeIsoWorld() : CafeIsoWorld
      {
         return world as CafeIsoWorld;
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_DOWN,[this]));
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_RUN:
               this.onMouseDownRun(param1);
               break;
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               this.onMouseDownDeko(param1);
         }
      }
      
      protected function onMouseDownRun(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseDownDeko(param1:MouseEvent) : void
      {
         this.selectObject();
         this.startDrag();
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_UP,[this]));
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_RUN:
               if(!world.mouse.isWorldDragging)
               {
                  this.onMouseUpRun(param1);
               }
               break;
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               this.onMouseUpDeko(param1);
         }
      }
      
      protected function onMouseUpRun(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseUpDeko(param1:MouseEvent) : void
      {
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OUT,[this]));
         super.onRollOut(param1);
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_RUN:
               this.onRollOutRun(param1);
               break;
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               this.onRollOutDeko(param1);
         }
      }
      
      protected function onRollOutRun(param1:MouseEvent) : void
      {
         removeGlow();
      }
      
      protected function onRollOutDeko(param1:MouseEvent) : void
      {
         if(world.mouse.iDragObject != this)
         {
            removeGlow();
         }
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OVER,[this]));
         super.onRollOver(param1);
         switch(world.worldStatus)
         {
            case CafeIsoWorld.CAFE_STATUS_RUN:
               this.onRollOverRun(param1);
               break;
            case CafeIsoWorld.CAFE_STATUS_DEKO:
               this.onRollOverDeko(param1);
         }
      }
      
      protected function onRollOverRun(param1:MouseEvent) : void
      {
         addGlow();
      }
      
      protected function onRollOverDeko(param1:MouseEvent) : void
      {
         addGlow();
      }
      
      protected function get worldMouse() : CafeIsoMouse
      {
         return world.mouse as CafeIsoMouse;
      }
   }
}
