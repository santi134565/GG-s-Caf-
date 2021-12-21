package com.goodgamestudios.isocore.vo
{
   import com.goodgamestudios.math.MathBase;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.describeType;
   
   public class VisualVO extends EventDispatcher
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      private var _objectID:Number;
      
      private var _isoX:int = -1;
      
      private var _isoY:int = -1;
      
      private var _isoRotation:int;
      
      private var _isInGroup:Boolean = false;
      
      public var isOnIsoMap:Boolean = false;
      
      public var walkable:Boolean = true;
      
      public var deltaDepth:Number = 0;
      
      public var collisionSizeX:int = 1;
      
      public var collisionSizeY:int = 1;
      
      protected var _wodId:int = -1;
      
      protected var _name:String;
      
      protected var _group:String;
      
      protected var _type:String;
      
      public function VisualVO()
      {
         super();
      }
      
      public function get wodId() : int
      {
         return this._wodId;
      }
      
      public function set wodId(param1:int) : void
      {
         this._wodId = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get group() : String
      {
         return this._group;
      }
      
      public function set group(param1:String) : void
      {
         this._group = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function toXML() : XML
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:XML = null;
         var _loc4_:XML;
         (_loc4_ = new XML("<" + this.group + "/>")).@wodId = this._wodId;
         for each(_loc5_ in describeType(this).variable)
         {
            _loc1_ = _loc5_.@name.toString();
            _loc2_ = _loc5_.@type.toString();
            switch(_loc2_)
            {
               case "Boolean":
                  _loc3_ = !!this[_loc1_] ? "true" : "false";
                  break;
               case "String":
                  _loc3_ = this[_loc1_];
                  break;
               case "Number":
                  _loc3_ = MathBase.toFloatString(Number(this[_loc1_]),6);
                  break;
               case "int":
                  _loc3_ = int(this[_loc1_]).toString();
                  break;
               case "uint":
                  _loc3_ = uint(this[_loc1_]).toString();
                  break;
            }
            _loc4_[_loc1_] = _loc3_;
         }
         return _loc4_;
      }
      
      public function populateFromXML(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:XML = describeType(this);
         for each(_loc2_ in _loc3_.variable)
         {
            this.setAttributeFromXML(_loc2_,param1);
         }
         for each(_loc2_ in _loc3_.accessor)
         {
            this.setAttributeFromXML(_loc2_,param1);
         }
      }
      
      private function setAttributeFromXML(param1:XML, param2:XML) : void
      {
         var _loc6_:Object = null;
         var _loc3_:String = param1.@name.toString();
         var _loc4_:String = param1.@type.toString();
         var _loc5_:String;
         if((_loc5_ = param2.attribute(_loc3_)) == null || _loc5_ == "")
         {
            return;
         }
         switch(_loc4_)
         {
            case "Boolean":
               _loc6_ = Boolean(_loc5_.toLowerCase() == "true");
               break;
            case "String":
               _loc6_ = _loc5_.toString();
               break;
            case "Number":
               _loc6_ = Number(_loc5_);
               break;
            case "int":
               _loc6_ = int(_loc5_);
               break;
            case "uint":
               _loc6_ = uint(_loc5_);
         }
         this[_loc3_] = _loc6_;
      }
      
      public function fillFromParamXML(param1:XML) : void
      {
         this.wodId = param1.attribute("id");
         this.group = param1.attribute("g");
         this.name = param1.attribute("n");
         this.type = param1.attribute("t");
      }
      
      public function loadFromParamArray(param1:Array) : void
      {
         this._isoRotation = param1.shift();
      }
      
      public function fillFromParamArray(param1:Array) : void
      {
      }
      
      public function validateValue(param1:String, param2:Object) : Boolean
      {
         return true;
      }
      
      public function get isoPos() : Point
      {
         if(this._isoX >= 0 && this._isoY >= 0)
         {
            return new Point(this._isoX,this._isoY);
         }
         return null;
      }
      
      public function set isoPos(param1:Point) : void
      {
         if(param1)
         {
            this._isoX = param1.x;
            this._isoY = param1.y;
         }
      }
      
      public function set isoX(param1:int) : void
      {
         this._isoX = param1;
      }
      
      public function set isoY(param1:int) : void
      {
         this._isoY = param1;
      }
      
      public function get objectID() : Number
      {
         return this._objectID;
      }
      
      public function set objectID(param1:Number) : void
      {
         this._objectID = param1;
      }
      
      public function get isoX() : int
      {
         return this._isoX;
      }
      
      public function get isoY() : int
      {
         return this._isoY;
      }
      
      public function get rotationDir() : int
      {
         return this._isoRotation;
      }
      
      public function set rotationDir(param1:int) : void
      {
         this._isoRotation = param1;
      }
      
      public function getVisClassName() : String
      {
         if(this.type == "-")
         {
            return this.name + "_" + this.group;
         }
         return this.name + "_" + this.group + "_" + this.type;
      }
      
      public function get isInGroup() : Boolean
      {
         return this._isInGroup;
      }
      
      public function set isInGroup(param1:Boolean) : void
      {
         this._isInGroup = param1;
      }
      
      public function isItemAvalibleByEvent() : Boolean
      {
         return true;
      }
   }
}
