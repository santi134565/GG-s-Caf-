package com.goodgamestudios.cafe.view
{
   public class CheckBoxButton extends BasicButton
   {
       
      
      private var _isSelected:Boolean = false;
      
      public function CheckBoxButton()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(!this._isSelected)
         {
            this.deselected();
         }
         super.init();
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      override public function selected() : void
      {
         if(!enabled)
         {
            return;
         }
         this._isSelected = true;
         this.gotoAndStop(2);
      }
      
      override public function deselected() : void
      {
         if(!enabled)
         {
            return;
         }
         this._isSelected = false;
         this.gotoAndStop(1);
      }
   }
}
