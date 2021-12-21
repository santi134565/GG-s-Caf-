package com.goodgamestudios.isocore
{
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.graphics.animation.event.FrameEvent;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.isocore.events.ValueObjectChangeEvent;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundTransform;
   import flash.utils.getTimer;
   
   public class VisualElement
   {
       
      
      public var isoDepth:Number;
      
      public var isIsoObject:Boolean;
      
      public var deathTime:Number;
      
      public var isDying:Boolean;
      
      public var dyingTimeFrame:int;
      
      public var world:IIsoWorld;
      
      public var posX:Number = 0;
      
      public var posY:Number = 0;
      
      public var disp:Sprite;
      
      protected var dieAnim:AnimatedDisplayObject;
      
      protected var vo:VisualVO;
      
      protected var currentFilters:Array;
      
      protected var minX:Number;
      
      protected var minY:Number;
      
      protected var maxWidth:Number;
      
      protected var maxHeight:Number;
      
      protected var soundTransform:SoundTransform;
      
      protected var lazyAssets:Array;
      
      protected var useBitmapAnimations:Boolean = false;
      
      protected var bitmapScaleMatrix:Matrix;
      
      private var _initializing:Boolean = false;
      
      private var _dispLayer:Sprite;
      
      private var _visClassName:String;
      
      private var _visRepCreated:Boolean = false;
      
      private var _isMutable:Boolean = false;
      
      private var _hidden:Boolean = false;
      
      public function VisualElement()
      {
         super();
      }
      
      public function initialize(param1:VisualVO, param2:IIsoWorld) : void
      {
         if(this._initializing)
         {
            return;
         }
         this._initializing = true;
         this.vo = param1;
         this._visClassName = this.name + "_" + this.group + "_" + this.type;
         this.deathTime = Number.MAX_VALUE;
         this.dyingTimeFrame = 0;
         this.isDying = false;
         this.world = param2;
         this.currentFilters = new Array();
         this.updateIsoDepth();
         this.initVisualRep();
         this.visualX = this.initialX;
         this.visualY = this.initialY;
         this.useBitmapAnimations = false;
         this._initializing = false;
      }
      
      public function updateIsoDepth() : void
      {
         if(this.isoGridPos)
         {
            this.isoDepth = this.world.map.grid.getDepthByXY(this.isoGridPos) + this.vo.deltaDepth;
         }
         this.world.zSortThisFrame = true;
      }
      
      public function updateIsoDepthManual(param1:Point, param2:Number) : void
      {
         this.isoDepth = this.world.map.grid.getDepthByXY(param1) + this.vo.deltaDepth;
         this.isoDepth += param2;
         this.world.zSortThisFrame = true;
      }
      
      public function set deltaDepth(param1:Number) : void
      {
         this.vo.deltaDepth = param1;
         this.updateIsoDepth();
         this.world.zSortThisFrame = true;
      }
      
      public function getVisualVO() : VisualVO
      {
         return this.vo;
      }
      
      public function get hidden() : Boolean
      {
         return this._hidden;
      }
      
      public function get initialX() : Number
      {
         if(this.isoGridPos)
         {
            return this.world.map.grid.gridPosToPixelPos(this.vo.isoPos).x;
         }
         return this.vo.x;
      }
      
      public function get initialY() : Number
      {
         if(this.isoGridPos)
         {
            return this.world.map.grid.gridPosToPixelPos(this.vo.isoPos).y;
         }
         return this.vo.y;
      }
      
      public function drawToIsoPos() : void
      {
         this.visualX = this.world.map.grid.gridPosToPixelPos(this.isoGridPos).x;
         this.visualY = this.world.map.grid.gridPosToPixelPos(this.isoGridPos).y;
      }
      
      public function get initializing() : Boolean
      {
         return this._initializing;
      }
      
      public function get visualX() : Number
      {
         return this.disp.x;
      }
      
      public function get visualY() : Number
      {
         return this.disp.y;
      }
      
      public function set initializing(param1:Boolean) : void
      {
         this._initializing = param1;
      }
      
      public function set visClassName(param1:String) : void
      {
         this._visClassName = param1;
      }
      
      public function set visualX(param1:Number) : void
      {
         this.posX = param1;
         this.disp.x = param1;
      }
      
      public function set visualY(param1:Number) : void
      {
         this.posY = param1;
         this.disp.y = param1;
      }
      
      public function die(param1:Number = -1) : void
      {
         if(this.isDying)
         {
            return;
         }
         this.isDying = true;
         var _loc2_:int = getTimer();
         this.deathTime = param1 < 0 ? Number(_loc2_) : Number(param1);
         if(!this.isHidden)
         {
            if(this.dieAnim != null)
            {
               MovieClipHelper.clearMovieClip(this.disp);
               this.disp.addChild(this.dieAnim.disp);
               this.dieAnim.addEventListener(FrameEvent.END,this.onDieAnimEnd);
               this.dieAnim.play();
               this.dyingTimeFrame += this.dieAnim.lengthInMillis;
            }
            this.deathTime += this.dyingTimeFrame;
         }
         if(this.deathTime <= _loc2_)
         {
            this.hide();
         }
      }
      
      protected function onDieAnimEnd(param1:FrameEvent) : void
      {
         this.dieAnim.removeEventListener(FrameEvent.END,this.onDieAnimEnd);
         this.dieAnim.gotoAndStop(this.dieAnim.frameAmount);
      }
      
      public function get isoGridPos() : Point
      {
         return this.vo.isoPos;
      }
      
      public function set isoGridPos(param1:Point) : void
      {
         this.vo.isoPos = param1;
      }
      
      public function set isoX(param1:int) : void
      {
         this.vo.isoX = param1;
      }
      
      public function set isoY(param1:int) : void
      {
         this.vo.isoY = param1;
      }
      
      public function get isoX() : int
      {
         return this.vo.isoX;
      }
      
      public function get isoY() : int
      {
         return this.vo.isoY;
      }
      
      public function changeIsoPos(param1:Point) : void
      {
         this.isoX = param1.x;
         this.isoY = param1.y;
         this.drawToIsoPos();
         this.updateIsoDepth();
      }
      
      public function update(param1:Number) : void
      {
         if(this._initializing)
         {
            return;
         }
         var _loc2_:Number = getTimer();
         if(this._visRepCreated)
         {
            if(this.world.isRunning)
            {
               if(this.isDying)
               {
                  this.updateDyingVisRep(param1);
               }
               else
               {
                  this.updateVisualRep(param1);
               }
            }
         }
         else if(!this._hidden)
         {
            this.show();
         }
      }
      
      protected function onValueObjectChange(param1:ValueObjectChangeEvent) : void
      {
      }
      
      protected function updateVisualRep(param1:Number) : void
      {
      }
      
      public function isVisibleIn(param1:Rectangle) : Boolean
      {
         return true;
      }
      
      public function show() : void
      {
         this._hidden = false;
         this.disp.visible = true;
         if(!this._visRepCreated && !this._initializing)
         {
            this._visRepCreated = this.createVisualRep();
         }
      }
      
      public function hide() : void
      {
         this._hidden = true;
         this.disp.visible = false;
      }
      
      public function isDead(param1:Number) : Boolean
      {
         return param1 > this.deathTime;
      }
      
      protected function resetVisRep() : void
      {
         while(this.disp.numChildren > 0)
         {
            this.disp.removeChildAt(0);
         }
         this._visRepCreated = false;
         this.bitmapScaleMatrix = null;
      }
      
      protected function createVisualRep() : Boolean
      {
         return true;
      }
      
      protected function initVisualRep() : void
      {
         if(this.disp == null)
         {
            this.disp = new Sprite();
         }
         this.minX = -100;
         this.minY = -100;
         this.maxWidth = 200;
         this.maxHeight = 200;
         this.disp.mouseChildren = false;
         this.disp.cacheAsBitmap = true;
      }
      
      protected function updateDyingVisRep(param1:Number) : void
      {
      }
      
      public function addDispToLayer(param1:Sprite) : void
      {
         if(this.disp)
         {
            this._dispLayer = param1;
            this._dispLayer.addChild(this.disp);
         }
      }
      
      public function removeDispFromWorld() : void
      {
         if(this.disp)
         {
            if(this._dispLayer.contains(this.disp))
            {
               this._dispLayer.removeChild(this.disp);
            }
            while(this.disp.numChildren > 0)
            {
               this.disp.removeChildAt(0);
            }
            this.disp = null;
         }
      }
      
      protected function addDispChild(param1:DisplayObject) : void
      {
         if(this.disp && param1 && param1.parent != this.disp)
         {
            this.disp.addChild(param1);
         }
      }
      
      protected function addDispChildAt(param1:DisplayObject, param2:int) : void
      {
         if(this.disp && param1 && param1.parent != this.disp && param2 <= this.disp.numChildren)
         {
            this.disp.addChildAt(param1,param2);
         }
      }
      
      protected function removeDispChild(param1:DisplayObject) : void
      {
         if(this.disp && param1 && param1.parent == this.disp)
         {
            this.disp.removeChild(param1);
         }
      }
      
      public function addDropShadow() : void
      {
         this.disp.filters = [new DropShadowFilter(10,45,0,0.5,16,16)];
      }
      
      public function toString() : String
      {
         return this.name + "_" + this.group + "_" + this.type;
      }
      
      public function get isHidden() : Boolean
      {
         return this.disp.visible == false;
      }
      
      public function get useBitmapCache() : Boolean
      {
         return false;
      }
      
      public function get areAssetsComplete() : Boolean
      {
         return !this._initializing && (!this.lazyAssets || this.lazyAssets.length == 0);
      }
      
      public function get isMutable() : Boolean
      {
         return this._isMutable;
      }
      
      public function set isMutable(param1:Boolean) : void
      {
         this._isMutable = param1;
      }
      
      public function get name() : String
      {
         return this.vo.name;
      }
      
      public function get group() : String
      {
         return this.vo.group;
      }
      
      public function get type() : String
      {
         return this.vo.type;
      }
      
      public function get scale() : Number
      {
         return !!this.disp ? Number(this.disp.scaleX) : Number(0);
      }
      
      public function get alpha() : Number
      {
         return !!this.disp ? Number(this.disp.alpha) : Number(1);
      }
      
      public function set alpha(param1:Number) : void
      {
         if(this.disp)
         {
            this.disp.alpha = param1;
         }
      }
      
      protected function set cacheAsBitmap(param1:Boolean) : void
      {
         if(this.disp)
         {
            this.disp.cacheAsBitmap = param1;
         }
      }
      
      protected function getDispChildAt(param1:int) : DisplayObject
      {
         if(this.disp && this.disp.numChildren > param1)
         {
            return this.disp.getChildAt(param1);
         }
         return null;
      }
      
      protected function removeDispChildAt(param1:int) : void
      {
         if(this.disp && this.disp.numChildren > param1)
         {
            this.disp.removeChildAt(param1);
         }
      }
      
      public function get filters() : Array
      {
         return !!this.disp ? this.disp.filters : null;
      }
      
      public function get currentVisWidth() : Number
      {
         return !!this.disp ? Number(this.disp.width) : Number(0);
      }
      
      public function get currentVisHeight() : Number
      {
         return !!this.disp ? Number(this.disp.height) : Number(0);
      }
      
      public function set filters(param1:Array) : void
      {
         if(this.disp)
         {
            this.disp.filters = param1;
         }
      }
      
      protected function get rotation() : Number
      {
         return !!this.disp ? Number(this.disp.rotation) : Number(0);
      }
      
      protected function set rotation(param1:Number) : void
      {
         if(this.disp)
         {
            this.disp.rotation = param1;
         }
      }
      
      protected function get graphics() : Graphics
      {
         return !!this.disp ? this.disp.graphics : null;
      }
      
      public function get lastVisualUpdate() : Number
      {
         return this.world.lastUpdateTimestamp;
      }
      
      public function get visClassName() : String
      {
         if(this.type == "-")
         {
            return this.name + "_" + this.group;
         }
         return this.name + "_" + this.group + "_" + this.type;
      }
      
      public function get camX() : Number
      {
         return this.visualX;
      }
      
      public function get camY() : Number
      {
         return this.visualY;
      }
      
      public function get objectID() : Number
      {
         return this.vo.objectID;
      }
      
      public function set objectID(param1:Number) : void
      {
         this.vo.objectID = param1;
      }
      
      public function get visRepCreated() : Boolean
      {
         return this._visRepCreated;
      }
   }
}
