package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class PlateholderMoving extends VestedMoving
   {
       
      
      private var _plateMC:MovieClip;
      
      private var _plateLayer:Sprite;
      
      private var _platePos:Point;
      
      private var _plateTurnOffset:Point;
      
      private var _transport:Boolean = false;
      
      public var currentDish:BasicDishVO;
      
      private var _dishFrame:int;
      
      public function PlateholderMoving()
      {
         this._platePos = new Point(14,-32);
         this._plateTurnOffset = new Point(10,12);
         super();
      }
      
      override protected function createVisualRep() : Boolean
      {
         super.createVisualRep();
         this._plateLayer = new Sprite();
         animDisp.addChild(this._plateLayer);
         return true;
      }
      
      public function addDish(param1:BasicDishVO, param2:int = 4) : void
      {
         while(this._plateLayer.numChildren > 0)
         {
            this._plateLayer.removeChildAt(0);
         }
         if(param1 == null)
         {
            return;
         }
         this._dishFrame = param2;
         this.currentDish = param1;
         var _loc3_:Class = getDefinitionByName(param1.getVisClassName()) as Class;
         this._plateMC = new _loc3_();
         this._plateMC.gotoAndStop(this._dishFrame);
         this._plateLayer.addChild(this._plateMC);
         this._plateLayer.x = this._platePos.x;
         this._plateLayer.y = this._platePos.y;
         this.switchPlate();
         this._transport = true;
      }
      
      public function get transportDish() : Boolean
      {
         return this._transport;
      }
      
      public function removeDish() : void
      {
         this.currentDish = null;
         if(this._plateMC)
         {
            this._plateLayer.removeChild(this._plateMC);
         }
         this._transport = false;
      }
      
      private function switchPlate() : void
      {
         if(isoDir.y == -1)
         {
            animDisp.setChildIndex(this._plateLayer,0);
         }
         else
         {
            animDisp.setChildIndex(this._plateLayer,animDisp.numChildren - 1);
         }
         this._plateLayer.y = isoDir.y > 0 ? Number(this._platePos.y) : Number(this._platePos.y - this._plateTurnOffset.y);
      }
      
      override protected function updateDir(param1:Point) : void
      {
         var _loc2_:Point = isoDir.clone();
         super.updateDir(param1);
         if(this._transport)
         {
            this.switchPlate();
         }
      }
      
      protected function showPlate() : void
      {
         this._plateLayer.visible = true;
      }
      
      protected function hidePlate() : void
      {
         this._plateLayer.visible = false;
      }
      
      public function get dishFrame() : int
      {
         return this._dishFrame;
      }
   }
}
