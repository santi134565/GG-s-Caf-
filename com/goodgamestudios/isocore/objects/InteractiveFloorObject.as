package com.goodgamestudios.isocore.objects
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.getDefinitionByName;
   
   public class InteractiveFloorObject extends FloorObject
   {
       
      
      protected var selectedGlowfilter:GlowFilter;
      
      protected var objectLayer:Sprite;
      
      protected var objectdisp:MovieClip;
      
      protected var iconLayer:Sprite;
      
      protected var staticIconLayer:Sprite;
      
      public function InteractiveFloorObject()
      {
         this.selectedGlowfilter = new GlowFilter(16777215,1,14,14,4);
         super();
      }
      
      override protected function initVisualRep() : void
      {
         disp = new Sprite();
         this.objectLayer = new Sprite();
         disp.addChild(this.objectLayer);
         disp.mouseChildren = true;
         this.staticIconLayer = new Sprite();
         this.staticIconLayer.mouseChildren = false;
         this.staticIconLayer.mouseEnabled = false;
         disp.addChild(this.staticIconLayer);
         this.iconLayer = new Sprite();
         disp.addChild(this.iconLayer);
         var _loc1_:Class = getDefinitionByName(visClassName) as Class;
         this.objectdisp = new _loc1_();
         this.objectdisp.gotoAndStop(1);
         this.objectLayer.addChild(this.objectdisp);
         this.addMouseListener();
         disp.cacheAsBitmap = true;
      }
      
      protected function addMouseListener() : void
      {
         if(disp)
         {
            this.objectLayer.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            this.objectLayer.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.objectLayer.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            this.objectLayer.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         }
      }
      
      override public function remove() : void
      {
         super.remove();
         this.objectLayer.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.objectLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.objectLayer.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.objectLayer.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         world.mouse.isOnObject = false;
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         world.mouse.isOnObject = true;
      }
      
      protected function mirrorObject(param1:int) : void
      {
         if(this.objectdisp.scaleX != param1)
         {
            this.objectdisp.scaleX = param1;
            this.objectdisp.x -= world.map.grid.tileSize.x * param1;
         }
      }
      
      public function setWalkable() : void
      {
         world.map.collisionMap.setWalkable(isoGridPos);
      }
      
      public function addGlow() : void
      {
         if(world.mouse.objectsSelectable && this.objectLayer)
         {
            this.objectLayer.filters = [this.selectedGlowfilter];
         }
      }
      
      public function removeGlow() : void
      {
         if(this.objectLayer)
         {
            this.objectLayer.filters = [];
         }
      }
   }
}
