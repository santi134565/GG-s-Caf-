package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class BasicComboboxComponent
   {
      
      protected static const ITEM_SPACE:int = 0;
       
      
      protected var CLOSED_HEIGHT:int;
      
      protected var ITEM_HEIGHT:int;
      
      protected var ITEM_WIDTH:int;
      
      protected var _disp:MovieClip;
      
      protected var _defaultString:String;
      
      protected var _itemData:Array;
      
      protected var _selectedItem:int;
      
      protected var _scaleOpen:Number;
      
      protected var _itemDir:int;
      
      public function BasicComboboxComponent(param1:MovieClip, param2:String = "", param3:int = 1, param4:int = 30, param5:int = 28, param6:int = 0, param7:Boolean = false)
      {
         super();
         this._disp = param1;
         this._itemDir = param3;
         this.CLOSED_HEIGHT = param4;
         this.ITEM_HEIGHT = param5;
         this.ITEM_WIDTH = param6;
         this._disp.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this._disp.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._disp.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._itemData = [];
         this._defaultString = param2;
         this._disp.item_Holder.visible = false;
         this._disp.btn_arrow.gotoAndStop(2);
         if(param7)
         {
            this._disp.btn_arrow.x = this.ITEM_WIDTH - 20;
         }
         if(this.ITEM_WIDTH > 0)
         {
            this._disp.bg.width = this.ITEM_WIDTH;
         }
         this._disp.bg.gotoAndStop(1);
         this._disp.bg.scaleY = 1;
         this._disp.txt_selected.mouseEnabled = false;
         if(this._defaultString != "")
         {
            this._disp.txt_selected.text = this._defaultString;
         }
      }
      
      protected function get itemClass() : Class
      {
         return BasicComboboxItem;
      }
      
      protected function fillItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         while(this._disp.item_Holder.numChildren > 0)
         {
            this._disp.item_Holder.removeChildAt(0);
         }
         if(this._itemData.length > 1)
         {
            _loc1_ = this.CLOSED_HEIGHT + this._itemData.length * (this.ITEM_HEIGHT + ITEM_SPACE) + 15;
            this._scaleOpen = _loc1_ / this.CLOSED_HEIGHT;
            _loc2_ = 0;
            while(_loc2_ < this._itemData.length)
            {
               _loc3_ = new this.itemClass();
               _loc3_.mouseChildren = false;
               _loc3_.txt_item.text = this._itemData[_loc2_].label;
               _loc3_.bg.width = this.ITEM_WIDTH;
               _loc3_.bg.gotoAndStop(1);
               _loc3_.id = _loc2_;
               this._disp.item_Holder.addChild(_loc3_);
               _loc3_.y = _loc2_ * (this.ITEM_HEIGHT + ITEM_SPACE) * this._itemDir;
               _loc2_++;
            }
         }
         this._disp.item_Holder.visible = false;
      }
      
      public function addItem(param1:Object) : void
      {
         this._itemData.push(param1);
         var _loc2_:int = this.CLOSED_HEIGHT + this._itemData.length * (this.ITEM_HEIGHT + ITEM_SPACE);
         if(this._itemDir == 1)
         {
            _loc2_ += this._disp.item_Holder.y - (this._disp.txt_selected.y + this._disp.txt_selected.height);
         }
         this._scaleOpen = _loc2_ / this.CLOSED_HEIGHT;
         var _loc3_:MovieClip = new this.itemClass();
         _loc3_.mouseChildren = false;
         _loc3_.txt_item.text = param1.label;
         if(this.ITEM_WIDTH > 0)
         {
            _loc3_.bg.width = this.ITEM_WIDTH;
         }
         _loc3_.bg.gotoAndStop(1);
         _loc3_.id = this._itemData.length - 1;
         _loc3_.y = (this._itemData.length - 1) * (this.ITEM_HEIGHT + ITEM_SPACE) * this._itemDir;
         this._disp.item_Holder.addChild(_loc3_);
      }
      
      public function selectItemIndex(param1:int) : void
      {
         if(this._itemData.length < 1)
         {
            return;
         }
         if(param1 > this._itemData.length || param1 < 0)
         {
            this._selectedItem = -1;
            this._disp.txt_selected.text = this._defaultString;
         }
         else
         {
            this._selectedItem = param1;
            this._disp.txt_selected.text = this._itemData[this._selectedItem].label;
         }
         this._disp.dispatchEvent(new BasicComboboxEvent(BasicComboboxEvent.COMBOBOXCHANGE));
      }
      
      protected function showItems() : void
      {
         this._disp.btn_arrow.gotoAndStop(1);
         this._disp.bg.scaleY = this._scaleOpen;
         if(this._itemDir == -1)
         {
            this._disp.bg.y = -this._disp.bg.height + this.CLOSED_HEIGHT;
            this._disp.item_Holder.y = -this.CLOSED_HEIGHT;
         }
         this._disp.item_Holder.visible = true;
         this._disp.dispatchEvent(new BasicComboboxEvent(BasicComboboxEvent.COMBOBOXSELECT,1));
      }
      
      public function hideItems() : void
      {
         this._disp.btn_arrow.gotoAndStop(2);
         this._disp.bg.scaleY = 1;
         this._disp.bg.y = 0;
         this._disp.item_Holder.visible = false;
         this._disp.dispatchEvent(new BasicComboboxEvent(BasicComboboxEvent.COMBOBOXSELECT,0));
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this._disp.bg:
            case this._disp.btn_arrow:
               if(!this._disp.btn_arrow.enabled)
               {
                  return;
               }
               this.onClickArrow();
               break;
         }
         if(param1.target is this.itemClass)
         {
            this.selectItemIndex(param1.target.id);
            this.hideItems();
         }
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is this.itemClass)
         {
            param1.target.bg.gotoAndStop(1);
         }
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is this.itemClass)
         {
            param1.target.bg.gotoAndStop(2);
         }
      }
      
      public function clearItems() : void
      {
         this.hideItems();
         this._itemData = [];
         this.fillItems();
      }
      
      protected function onClickArrow() : void
      {
         if(this._disp.bg.scaleY > 1)
         {
            this.hideItems();
         }
         else
         {
            this.showItems();
         }
      }
      
      public function get selectedId() : int
      {
         if(this._selectedItem != -1)
         {
            return this._selectedItem;
         }
         return -1;
      }
      
      public function get selectedData() : Object
      {
         if(this._selectedItem == -1)
         {
            return null;
         }
         return this._itemData[this._selectedItem].data;
      }
      
      public function get selectedLabel() : String
      {
         if(this._selectedItem == -1)
         {
            return "";
         }
         return this._itemData[this._selectedItem].label;
      }
      
      public function get disp() : MovieClip
      {
         return this._disp;
      }
      
      public function get itemData() : Array
      {
         return this._itemData;
      }
   }
}
