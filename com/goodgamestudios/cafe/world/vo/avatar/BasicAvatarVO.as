package com.goodgamestudios.cafe.world.vo.avatar
{
   import com.goodgamestudios.isocore.vo.VisualVO;
   
   public class BasicAvatarVO extends VisualVO
   {
       
      
      private var _gender:int;
      
      private var _colorable:Boolean;
      
      private var _colorArray:Array;
      
      private var _currentColor:int;
      
      public function BasicAvatarVO()
      {
         this._colorArray = [];
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         this._gender = parseInt(param1.attribute("gender"));
         var _loc2_:Array = param1.attribute("colors").split("#");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            this._colorArray.push(_loc2_[_loc3_]);
            _loc3_++;
         }
         this._colorable = this._colorArray && this._colorArray.length > 1;
      }
      
      public function get colorable() : Boolean
      {
         return this._colorable;
      }
      
      public function set colorable(param1:Boolean) : void
      {
         this._colorable = param1;
      }
      
      public function set currentColor(param1:int) : void
      {
         this._currentColor = param1;
      }
      
      public function get currentColor() : int
      {
         return this._currentColor;
      }
      
      public function set colorArray(param1:Array) : void
      {
         this._colorArray = param1;
      }
      
      public function get colorArray() : Array
      {
         return this._colorArray;
      }
   }
}
