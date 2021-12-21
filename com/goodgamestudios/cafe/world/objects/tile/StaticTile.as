package com.goodgamestudios.cafe.world.objects.tile
{
   import com.goodgamestudios.isocore.IsoMouse;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.objects.IDraggable;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class StaticTile extends VisualElement implements IDraggable
   {
       
      
      public function StaticTile()
      {
         super();
      }
      
      override protected function initVisualRep() : void
      {
         var _loc1_:Class = null;
         if(disp == null)
         {
            _loc1_ = getDefinitionByName(visClassName) as Class;
            disp = new _loc1_();
            disp.mouseEnabled = false;
            disp.mouseChildren = false;
         }
      }
      
      override public function get camX() : Number
      {
         return visualX;
      }
      
      override public function get camY() : Number
      {
         return visualY;
      }
      
      public function startDrag() : void
      {
         if(!world.mouse.iDragObject)
         {
            world.mouse.iDragObject = this;
            isoGridPos = new Point(0,0);
            world.mouse.switchState(IsoMouse.ISOMOUSE_STATE_FREE);
            this.addGlow();
            world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
         }
      }
      
      public function addGlow() : void
      {
         filters = [new GlowFilter(16777215)];
      }
      
      public function removeGlow() : void
      {
         filters = [];
      }
      
      public function stopDrag() : void
      {
      }
      
      public function dragMove(param1:Point) : void
      {
         var _loc2_:Point = world.map.grid.getNextPosOnMap(param1,new Rectangle(0,0,vo.collisionSizeX,vo.collisionSizeY));
         if(!_loc2_.equals(isoGridPos) && disp)
         {
            changeIsoPos(_loc2_);
         }
      }
      
      public function get removeAllowed() : Boolean
      {
         return true;
      }
      
      public function get wasOnMap() : Boolean
      {
         return false;
      }
      
      public function get isDragable() : Boolean
      {
         return true;
      }
      
      public function get wodId() : int
      {
         return getVisualVO().wodId;
      }
   }
}
