package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.chair.BasicChair;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.overlay.StaticOverlay;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcwaiterMovingVO;
   import com.goodgamestudios.cafe.world.vo.overlay.StaticOverlayVO;
   import com.goodgamestudios.isocore.vo.VOHelper;
   import flash.geom.Point;
   
   public class NpcwaiterMoving extends PlateholderMoving
   {
      
      public static const WORK_CLEAN:int = 1001;
      
      public static const WORK_SERVE_START:int = 1002;
      
      public static const WORK_SERVE_END:int = 1003;
       
      
      private var cleaning:Boolean;
      
      private var serving:Boolean;
      
      private var _walkablePos:Point;
      
      private var _counter:BasicCounter;
      
      private var _chair:BasicChair;
      
      private var _currentDish:BasicDishVO;
      
      private var _initFunction:Function;
      
      private var infoBox:StaticOverlay;
      
      public function NpcwaiterMoving()
      {
         super();
         this.cleaning = false;
         this.serving = false;
         _speed = 45;
         overlayPosition.x = 40;
         overlayPosition.y = -100;
      }
      
      override protected function createVisualRep() : Boolean
      {
         vo.deltaDepth = (vo as NpcMovingVO).npcId / 1000000;
         super.createVisualRep();
         disp.mouseEnabled = false;
         disp.mouseChildren = false;
         return true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.infoBox = cafeIsoWorld.addInfoBox(this,StaticOverlayVO.OVERLAY_TYPE_INFOTEXT,[(getVisualVO() as NpcwaiterMovingVO).npc_name]);
      }
      
      public function rename(param1:String) : void
      {
         cafeIsoWorld.removeInfoBox(this.infoBox);
         this.infoBox = cafeIsoWorld.addInfoBox(this,StaticOverlayVO.OVERLAY_TYPE_INFOTEXT,[(getVisualVO() as NpcwaiterMovingVO).npc_name]);
      }
      
      override public function startWalkPathAction() : void
      {
         if(_path && _path.length > 0)
         {
            this._walkablePos = new Point();
            this._walkablePos.x = _path[0].x;
            this._walkablePos.y = _path[0].y;
         }
         super.startWalkPathAction();
      }
      
      override public function reachedObjectAction() : void
      {
         if(this.cleaning)
         {
            setAniState(ANIM_STATUS_WORK);
         }
         else
         {
            super.reachedObjectAction();
         }
         if(!this.serving && transportDish)
         {
            removeDish();
         }
      }
      
      public function walkToCounter(param1:BasicCounter) : void
      {
         this._counter = param1;
         this.onWalkToCounter();
      }
      
      private function onWalkToCounter() : void
      {
         if(hidden)
         {
            show();
         }
         if(this.cleaning && this._chair)
         {
            this._currentDish = this._chair.table.currentDish;
            this._chair.table.removeDish();
            if(this._currentDish)
            {
               addDish(this._currentDish,BasicDishVO.GFX_FRAME_EATFULL);
            }
         }
         else
         {
            if(this.serving && this._chair && this._currentDish)
            {
               this._chair.table.addDish(this._currentDish.wodId);
            }
            if(transportDish)
            {
               removeDish();
            }
         }
         this.serving = false;
         this.cleaning = false;
         clearPath();
         this.changeNpcPos(this.walkablePos);
         walkToObject(this._counter.isoGridPos);
      }
      
      private function changeNpcPos(param1:Point, param2:Number = 0.0) : void
      {
         if(param1 && param1 != isoGridPos)
         {
            deltaDepth = param2;
            changeIsoPos(param1);
         }
      }
      
      public function servToTable(param1:BasicChair) : void
      {
         this._chair = param1;
         if(this._chair.guest)
         {
            this._chair.guest.isClickable = false;
         }
         this.onServToTable();
      }
      
      private function onServToTable() : void
      {
         if(hidden)
         {
            show();
         }
         clearPath();
         this.changeNpcPos(this.walkablePos);
         if(this._counter)
         {
            this._currentDish = VOHelper.clone(this._counter.currentDish) as BasicDishVO;
            this._counter.servDish();
         }
         else
         {
            this._currentDish = CafeModel.wodData.createVObyWOD((getVisualVO() as NpcMovingVO).dishId) as BasicDishVO;
         }
         this.serving = true;
         addDish(this._currentDish);
         walkToObject(this._chair.isoGridPos);
      }
      
      public function clean(param1:BasicChair) : void
      {
         this._chair = param1;
         if(this._chair.table)
         {
            this._chair.table.isClickable = false;
         }
         this.onClean();
      }
      
      private function onClean() : void
      {
         if(hidden)
         {
            show();
         }
         this.cleaning = true;
         walkToObject(this._chair.isoGridPos);
      }
      
      private function get walkablePos() : Point
      {
         if(!this._walkablePos)
         {
            this._walkablePos = cafeIsoWorld.freeDoorPoint.clone();
         }
         return this._walkablePos;
      }
   }
}
