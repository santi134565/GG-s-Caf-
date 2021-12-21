package com.goodgamestudios.cafe.world.objects.moving
{
   import com.goodgamestudios.cafe.event.CafeIsoEvent;
   import com.goodgamestudios.cafe.world.vo.avatar.BasicAvatarVO;
   import com.goodgamestudios.cafe.world.vo.moving.VestedMovingVO;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.graphics.animation.AnimatedMovieClip;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class VestedMoving extends BasicMoving
   {
      
      public static const RANGE_WALK:int = 0;
      
      public static const RANGE_SITDOWN:int = 2;
      
      public static const RANGE_EAT:int = 2;
      
      public static const RANGE_WORK:int = 4;
      
      public static const NAME_SKIN:String = "Skin";
      
      public static const NAME_LEGS:String = "Legs";
      
      public static const NAME_TOP:String = "Top";
      
      public static const NAME_FACE:String = "Face";
      
      public static const NAME_HAIR:String = "Hair";
      
      public static const NAME_HAT:String = "Hat";
       
      
      protected var _currentRange:int = 0;
      
      public var animDisp:Sprite;
      
      private var _loopedAnimDOs:Array;
      
      protected var bodyParts:Array;
      
      protected var clothType:Array;
      
      private var _framesPerPixelPerSecond:Number = 0.34;
      
      private var _defaultFrameRanges:Array;
      
      public function VestedMoving()
      {
         this.bodyParts = [];
         this.clothType = [];
         this._defaultFrameRanges = [[1,8],[9,16],[17,24],[25,32],[33,40],[41,48]];
         super();
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.animDisp = new Sprite();
         disp.addChild(this.animDisp);
         disp.mouseChildren = true;
         this.animDisp.mouseEnabled = isClickable;
         if(isClickable)
         {
            this.animDisp.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.animDisp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            this.animDisp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         }
      }
      
      override public function set isClickable(param1:Boolean) : void
      {
         super.isClickable = param1;
         if(!this.animDisp)
         {
            return;
         }
         this.animDisp.mouseEnabled = isClickable;
         if(isClickable)
         {
            this.animDisp.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.animDisp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            this.animDisp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         }
         else
         {
            this.animDisp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.animDisp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            this.animDisp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         }
      }
      
      protected function get avatarParts() : Array
      {
         return VestedMovingVO(getVisualVO()).avatarParts;
      }
      
      override protected function createVisualRep() : Boolean
      {
         var _loc3_:BasicAvatarVO = null;
         var _loc4_:String = null;
         var _loc5_:Class = null;
         var _loc6_:AnimatedDisplayObject = null;
         var _loc7_:Boolean = false;
         var _loc8_:String = null;
         var _loc9_:ColorTransform = null;
         this._loopedAnimDOs = [];
         var _loc1_:int = 0;
         while(_loc1_ < this.avatarParts.length)
         {
            _loc3_ = this.avatarParts[_loc1_] as BasicAvatarVO;
            _loc4_ = _loc3_.group + "_" + _loc3_.name + "_" + _loc3_.type;
            _loc5_ = getDefinitionByName(_loc4_) as Class;
            _loc6_ = new AnimatedMovieClip(-1,1,_loc3_.name);
            _loc7_ = true;
            if(_loc3_.name == NAME_HAT)
            {
               _loc7_ = false;
            }
            _loc6_.processAnimation(new _loc5_(),null,_loc7_);
            _loc6_.frameRanges = this._defaultFrameRanges;
            _loc6_.setFrameRate(Math.floor(this._framesPerPixelPerSecond * _speed));
            if(_loc6_.colorLayer)
            {
               _loc8_ = "0x" + _loc3_.colorArray[_loc3_.currentColor];
               (_loc9_ = new ColorTransform()).color = uint(_loc8_);
               MovieClip(_loc6_.colorLayer).transform.colorTransform = _loc9_;
            }
            switch(_loc3_.name)
            {
               case NAME_SKIN:
                  this._loopedAnimDOs[0] = _loc6_;
                  break;
               case NAME_LEGS:
                  this._loopedAnimDOs[1] = _loc6_;
                  break;
               case NAME_TOP:
                  this._loopedAnimDOs[2] = _loc6_;
                  break;
               case NAME_FACE:
                  this._loopedAnimDOs[3] = _loc6_;
                  break;
               case NAME_HAIR:
                  this._loopedAnimDOs[4] = _loc6_;
                  break;
               case NAME_HAT:
                  this._loopedAnimDOs[5] = _loc6_;
                  break;
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._loopedAnimDOs.length)
         {
            if(this._loopedAnimDOs[_loc2_])
            {
               this.animDisp.addChild(this._loopedAnimDOs[_loc2_].disp);
            }
            _loc2_++;
         }
         this.setDir();
         return true;
      }
      
      public function getHatAnim() : AnimatedDisplayObject
      {
         if(this._loopedAnimDOs && this._loopedAnimDOs.length > 5 && this._loopedAnimDOs[5])
         {
            return this._loopedAnimDOs[5];
         }
         return null;
      }
      
      override protected function updateVisualRep(param1:Number) : void
      {
         var _loc2_:int = 0;
         super.updateVisualRep(param1);
         if(this._loopedAnimDOs)
         {
            _loc2_ = 0;
            while(_loc2_ < this._loopedAnimDOs.length)
            {
               if(this._loopedAnimDOs[_loc2_])
               {
                  this._loopedAnimDOs[_loc2_].playForward();
               }
               _loc2_++;
            }
         }
      }
      
      public function setDir() : void
      {
         this.animDisp.scaleX = isoDir.x > 0 ? Number(1) : Number(-1);
         this.animDisp.x = isoDir.x > 0 ? Number(0) : Number(world.map.grid.tileSize.x);
         this.setAniState(ANIM_STATUS_STAND);
      }
      
      override protected function updateDir(param1:Point) : void
      {
         var _loc2_:Point = isoDir.clone();
         super.updateDir(param1);
         this.mirrorChar(_loc2_);
         this.switchAnimRange(this._currentRange);
      }
      
      override public function reachedObjectAction() : void
      {
         this.animSetAllToFirstFrame();
      }
      
      override public function removeDispFromWorld() : void
      {
         var _loc1_:int = 0;
         if(this.animDisp)
         {
            this.animDisp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.animDisp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            this.animDisp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         }
         if(this._loopedAnimDOs != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._loopedAnimDOs.length)
            {
               if(this._loopedAnimDOs[_loc1_] && this._loopedAnimDOs[_loc1_].disp.parent == this.animDisp)
               {
                  this.animDisp.removeChild(this._loopedAnimDOs[_loc1_].disp);
               }
               _loc1_++;
            }
            this._loopedAnimDOs = null;
         }
         super.removeDispFromWorld();
      }
      
      private function mirrorChar(param1:Point) : void
      {
         if(isoDir.x != param1.x)
         {
            this.animDisp.scaleX = isoDir.x > 0 ? Number(1) : Number(-1);
            this.animDisp.x = isoDir.x > 0 ? Number(0) : Number(world.map.grid.tileSize.x);
         }
      }
      
      private function switchAnimRange(param1:int) : void
      {
         this._currentRange = param1;
         var _loc2_:int = isoDir.y == -1 ? 1 : 0;
         if(visRepCreated)
         {
            this.setCurrentAnimRange(param1 + _loc2_);
         }
      }
      
      override public function setAniState(param1:int) : void
      {
         switch(param1)
         {
            case ANIM_STATUS_STAND:
               this.switchAnimRange(RANGE_WALK);
               this.animSetAllToFirstFrame();
               break;
            case ANIM_STATUS_WALK:
               this.switchAnimRange(RANGE_WALK);
               this.animPlayAll();
               break;
            case ANIM_STATUS_SITING:
               this.switchAnimRange(RANGE_SITDOWN);
               this.animSetAllToFirstFrame();
               break;
            case ANIM_STATUS_WORK:
               this.switchAnimRange(RANGE_WORK);
               this.animPlayAll();
               break;
            case ANIM_STATUS_EAT:
               this.switchAnimRange(RANGE_EAT);
               this.animPlayAll();
         }
      }
      
      private function setCurrentAnimRange(param1:int) : void
      {
         if(!this._loopedAnimDOs)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._loopedAnimDOs.length)
         {
            if(this._loopedAnimDOs[_loc2_])
            {
               this._loopedAnimDOs[_loc2_].currentFrameRange = param1;
               if(this._loopedAnimDOs[_loc2_].disp)
               {
                  this._loopedAnimDOs[_loc2_].disp.y = 0;
               }
            }
            _loc2_++;
         }
      }
      
      private function animPlayAll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._loopedAnimDOs.length)
         {
            if(this._loopedAnimDOs[_loc1_])
            {
               this._loopedAnimDOs[_loc1_].play();
            }
            _loc1_++;
         }
      }
      
      private function animSetAllToFirstFrame() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._loopedAnimDOs.length)
         {
            if(this._loopedAnimDOs[_loc1_])
            {
               this._loopedAnimDOs[_loc1_].gotoAndStopAtFirst();
            }
            _loc1_++;
         }
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OVER,[this]));
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         world.dispatchEvent(new CafeIsoEvent(CafeIsoEvent.ISO_OBJECT_MOUSE_OUT,[this]));
      }
   }
}
