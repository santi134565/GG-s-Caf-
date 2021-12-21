package com.goodgamestudios.isocore.objects
{
   import com.goodgamestudios.isocore.VisualElement;
   
   public class IsoObject extends VisualElement
   {
       
      
      private var _isClickable:Boolean = false;
      
      public function IsoObject()
      {
         super();
      }
      
      public function get isWalkable() : Boolean
      {
         return vo.walkable;
      }
      
      public function set isWalkable(param1:Boolean) : void
      {
         vo.walkable = param1;
      }
      
      public function remove() : void
      {
      }
      
      public function handleObjectDependencies() : void
      {
      }
      
      public function set isClickable(param1:Boolean) : void
      {
         this._isClickable = param1;
      }
      
      public function get isClickable() : Boolean
      {
         return this._isClickable;
      }
   }
}
