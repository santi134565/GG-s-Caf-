package com.goodgamestudios.cafe.world.objects.chair
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.CafeInteractiveFloorObject;
   import com.goodgamestudios.cafe.world.objects.moving.NpcguestMoving;
   import com.goodgamestudios.cafe.world.objects.table.BasicTable;
   import com.goodgamestudios.cafe.world.vo.chair.BasicChairVO;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class BasicChair extends CafeInteractiveFloorObject
   {
      
      private static const BACK_NAME:String = "Back";
       
      
      private var backVE:BackChair;
      
      private var oldRotation:int;
      
      private var _guest:NpcguestMoving;
      
      public function BasicChair()
      {
         super();
         isClickable = false;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.addBack();
      }
      
      override public function handleObjectDependencies() : void
      {
         this.addTableDish();
         if(this.table && this.table.currentDishState == BasicTable.DISH_STATE_EATFULL)
         {
            if(CafeModel.userData.isMyPlayerWaiter)
            {
               this.table.isClickable = true;
               this.table.disp.addEventListener(CafeIsoEvent.TABLE_CLICK,this.onTableClick);
            }
         }
      }
      
      public function addTableDish() : void
      {
         var _loc1_:int = (getVisualVO() as BasicChairVO).dishID;
         if(_loc1_ < 0 || this.table == null)
         {
            return;
         }
         var _loc2_:int = (getVisualVO() as BasicChairVO).dishStatus;
         this.table.addDish(_loc1_,_loc2_);
      }
      
      private function addBack() : void
      {
         var _loc2_:VisualVO = null;
         var _loc1_:Class = getDefinitionByName(world.voClassPath + group.toLowerCase() + "::" + BACK_NAME + vo.group + "VO") as Class;
         _loc2_ = new _loc1_();
         _loc2_.wodId = -1;
         _loc2_.group = vo.group;
         _loc2_.name = BACK_NAME;
         _loc2_.type = vo.type;
         _loc2_.rotationDir = vo.rotationDir;
         if(isoGridPos)
         {
            _loc2_.isoPos = isoGridPos;
         }
         this.backVE = world.addLevelElement(_loc2_) as BackChair;
         this.backVE.parent = this;
      }
      
      override public function startDrag() : void
      {
         this.oldRotation = isoRotation;
         super.startDrag();
      }
      
      override public function stopDrag() : void
      {
         super.stopDrag();
         if(this.oldRotation != isoRotation && oldIsoPos)
         {
            world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.EDITOR_EVENT,[CafeIsoEvent.EDITOR_ROTATE,isoGridPos.x,isoGridPos.y,isoRotation]));
         }
      }
      
      override protected function dragMoveAction() : void
      {
         var _loc1_:Point = null;
         var _loc3_:Array = null;
         var _loc4_:IsoObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < rotationDir.length)
         {
            _loc3_ = rotationDir[_loc2_] as Array;
            _loc1_ = isoGridPos.add(new Point(_loc3_[0],_loc3_[1]));
            if(_loc4_ = world.getIsoObjectByPoint(_loc1_))
            {
               if(_loc4_.getVisualVO().group == CafeConstants.GROUP_TABLE)
               {
                  this.setRotation(_loc2_);
                  return;
               }
            }
            _loc2_++;
         }
      }
      
      private function setRotation(param1:int) : void
      {
         isoRotation = param1;
         this.backVE.isoRotation = param1;
         setRotationGfx();
         this.backVE.setRotationGfx();
      }
      
      public function guestEatUp() : void
      {
         this.table.guestEatUp();
         if(CafeModel.userData.isMyPlayerWaiter)
         {
            this.table.isClickable = true;
         }
         this.table.disp.addEventListener(CafeIsoEvent.TABLE_CLICK,this.onTableClick);
      }
      
      public function get table() : BasicTable
      {
         if(!isoGridPos)
         {
            return null;
         }
         var _loc1_:Point = new Point();
         _loc1_.x = int(rotationDir[isoRotation][0]) + isoGridPos.x;
         _loc1_.y = int(rotationDir[isoRotation][1]) + isoGridPos.y;
         return world.getIsoObjectByPoint(_loc1_) as BasicTable;
      }
      
      override public function changeIsoPos(param1:Point) : void
      {
         super.changeIsoPos(param1);
         this.backVE.changeIsoPos(param1);
      }
      
      override public function rotate() : void
      {
         super.rotate();
         this.backVE.rotate();
      }
      
      override public function remove() : void
      {
         world.removeIsoObject(this.backVE as VisualElement);
         this.backVE = null;
         if(this.table)
         {
            this.table.disp.removeEventListener(CafeIsoEvent.TABLE_CLICK,this.onTableClick);
         }
         super.remove();
      }
      
      override public function hide() : void
      {
         this.backVE.hide();
         super.hide();
      }
      
      public function onTableClick(param1:CafeIsoEvent) : void
      {
         if(cafeIsoWorld.myPlayer.isFreeForWaiterAction)
         {
            this.table.disp.removeEventListener(CafeIsoEvent.TABLE_CLICK,this.onTableClick);
            this.onChairClick();
         }
      }
      
      public function onChairClick() : void
      {
         if(this.table)
         {
            world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.CHAIR_EVENT,[CafeIsoEvent.CLICK_CHAIR,this,this.table.currentDish]));
         }
      }
      
      override protected function onRollOverRun(param1:MouseEvent) : void
      {
      }
      
      override protected function onRollOutRun(param1:MouseEvent) : void
      {
         removeGlow();
      }
      
      public function get guest() : NpcguestMoving
      {
         return this._guest;
      }
      
      public function set guest(param1:NpcguestMoving) : void
      {
         this._guest = param1;
      }
   }
}
