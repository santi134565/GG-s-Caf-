package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.vo.BasicDragVO;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class BasicDragManager
   {
       
      
      public var dragVO:BasicDragVO = null;
      
      protected var dragLayer:Sprite;
      
      protected var _scaleMode:Number = 1;
      
      protected var _tempScaleMode:Number = 0;
      
      protected var _posX:Number = 1;
      
      protected var _posY:Number = 1;
      
      protected var _alpha:Number = 1;
      
      public function BasicDragManager(param1:Sprite, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 1)
      {
         super();
         this.dragLayer = param1;
         if(param2 != 0)
         {
            this._scaleMode = param2;
         }
         if(param3 != 0)
         {
            this._posX = param3;
         }
         if(param4 != 0)
         {
            this._posY = param4;
         }
         this._alpha = param5;
      }
      
      public function set scaleMode(param1:Number) : void
      {
         this._tempScaleMode = param1;
      }
      
      public function startDragging(param1:BasicDragVO) : void
      {
         this.dragVO = param1;
         var _loc2_:Class = getDefinitionByName(getQualifiedClassName(this.dragVO.dragSourceMC)) as Class;
         this.dragVO.dragMC = new _loc2_();
         this.dragVO.dragMC.mouseEnabled = false;
         if(this._tempScaleMode != 0)
         {
            this.dragVO.dragMC.scaleX = this._tempScaleMode;
            this.dragVO.dragMC.scaleY = this._tempScaleMode;
         }
         else
         {
            this.dragVO.dragMC.scaleX = this._scaleMode;
            this.dragVO.dragMC.scaleY = this._scaleMode;
         }
         this.dragVO.dragMC.x = this.dragLayer.mouseX + this._posX;
         this.dragVO.dragMC.y = this.dragLayer.mouseY - this._posY;
         this.dragVO.dragSourceMC.alpha = this._alpha;
         this.dragVO.dragMC.startDrag();
         this.dragLayer.addChildAt(this.dragVO.dragMC,0);
      }
      
      public function stopDragging() : void
      {
         if(!this.dragVO)
         {
            return;
         }
         this.dragVO.dragSourceMC.alpha = 1;
         this.dragLayer.removeChild(this.dragVO.dragMC);
         this.dragVO = null;
         this._tempScaleMode = 0;
      }
   }
}
