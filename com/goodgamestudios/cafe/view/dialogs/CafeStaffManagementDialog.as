package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeNpcData;
   import com.goodgamestudios.cafe.view.BasicButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeStaffManagementDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeStaffManagementDialog";
       
      
      private var favorite:int;
      
      private var sliderHalfWidth:int;
      
      private var sliderWidth:int;
      
      private var sliderDown:Boolean;
      
      private var step:int;
      
      public function CafeStaffManagementDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.sliderWidth = this.staffDialog.mc_slidebar.width - this.staffDialog.btn_slider.width / 2;
         this.sliderHalfWidth = this.sliderWidth / 2;
         this.step = this.sliderWidth / 10;
         this.sliderDown = false;
         this.staffDialog.btn_slider.addEventListener(MouseEvent.MOUSE_DOWN,this.onSliderDown);
         this.staffDialog.addEventListener(MouseEvent.MOUSE_UP,this.onSliderUp);
         this.staffDialog.addEventListener(MouseEvent.MOUSE_MOVE,this.onSliding);
         this.staffDialog.btn_fire.label = CafeModel.languageData.getTextById("dialogwin_staffmanagement_btn_fire");
         this.staffDialog.btn_fire.enableButton = CafeModel.npcStaffData.numStaff > 1;
         this.staffDialog.txt_fire.text = CafeModel.languageData.getTextById("dialogwin_staffmanagement_fire");
         this.staffDialog.txt_renametitle.text = CafeModel.languageData.getTextById("dialogwin_staffmanagement_renametitle");
         this.staffDialog.txt_renamecopy.text = CafeModel.languageData.getTextById("dialogwin_staffmanagement_renamecopy");
         this.staffDialog.txt_inputname.inputField.text = this.staffDialogProperties.npcName;
         this.staffDialog.txt_inputname.inputField.maxChars = CafeNpcData.MAX_NAMELENGTH;
         this.staffDialog.txt_favorite.text = CafeModel.languageData.getTextById("dialogwin_staffmanagement_favorite");
         this.staffDialog.txt_favorite0.text = CafeModel.languageData.getTextById("dialogwin_staffmanagement_favorite0");
         this.staffDialog.txt_favorite100.text = CafeModel.languageData.getTextById("dialogwin_staffmanagement_favorite100");
         this.staffDialog.btn_okay.label = CafeModel.languageData.getTextById("btn_text_okay");
         this.staffDialog.btn_cancel.label = CafeModel.languageData.getTextById("btn_text_cancle");
         this.favorite = this.staffDialogProperties.npcFavorite;
         this.updateSliding();
      }
      
      override public function destroy() : void
      {
         this.staffDialog.btn_slider.removeEventListener(MouseEvent.MOUSE_DOWN,this.onSliderDown);
         this.staffDialog.removeEventListener(MouseEvent.MOUSE_UP,this.onSliderUp);
         this.staffDialog.removeEventListener(MouseEvent.MOUSE_MOVE,this.onSliding);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton && !(param1.target as BasicButton).enabled)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.staffDialog.btn_close:
            case this.staffDialog.btn_cancel:
               hide();
               break;
            case this.staffDialog.btn_fire:
               layoutManager.showDialog(CafeStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("alert_stafffire_title"),CafeModel.languageData.getTextById("alert_stafffire_copy"),this.onFire,null,null,CafeModel.languageData.getTextById("btn_text_okay"),CafeModel.languageData.getTextById("btn_text_cancle")));
               break;
            case this.staffDialog.btn_okay:
               hide();
               if(this.staffDialogProperties.functionChange != null)
               {
                  this.staffDialogProperties.functionChange([this.staffDialog.txt_inputname.inputField.text,this.favorite]);
               }
               break;
            case this.staffDialog.mc_slidebar:
               this.onClickSlidebar(param1);
         }
      }
      
      public function onFire(param1:Array) : void
      {
         hide();
         if(this.staffDialogProperties.functionFire != null)
         {
            this.staffDialogProperties.functionFire(null);
         }
      }
      
      private function onSliderUp(param1:MouseEvent) : void
      {
         if(!this.sliderDown)
         {
            return;
         }
         this.sliderDown = false;
         this.updateSliding();
      }
      
      private function onSliderDown(param1:MouseEvent) : void
      {
         if(this.sliderDown)
         {
            return;
         }
         this.sliderDown = true;
         var _loc2_:int = this.staffDialog.btn_slider.x + param1.localX;
         if(_loc2_ > -this.sliderHalfWidth && _loc2_ < this.sliderHalfWidth)
         {
            this.staffDialog.btn_slider.x = _loc2_;
         }
      }
      
      private function onSliding(param1:MouseEvent) : void
      {
         if(!this.sliderDown)
         {
            return;
         }
         var _loc2_:int = this.staffDialog.mc_slidebar.mouseX;
         if(_loc2_ > -this.sliderHalfWidth && _loc2_ < this.sliderHalfWidth)
         {
            this.staffDialog.btn_slider.x = _loc2_;
         }
         var _loc3_:int = this.staffDialog.btn_slider.x + this.sliderHalfWidth;
         this.favorite = _loc3_ / this.sliderWidth * 100;
      }
      
      private function onClickSlidebar(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = this.staffDialog.mc_slidebar.x + param1.localX;
         if(_loc2_ > -this.sliderHalfWidth && _loc2_ < this.sliderHalfWidth)
         {
            this.setSliderBtn(_loc2_);
            _loc3_ = this.staffDialog.btn_slider.x + this.sliderHalfWidth;
            this.favorite = _loc3_ / this.sliderWidth * 100;
         }
      }
      
      private function updateSliding() : void
      {
         this.setSliderBtn(this.favorite / 100 * this.sliderWidth - this.sliderHalfWidth);
      }
      
      private function setSliderBtn(param1:int) : void
      {
         var _loc2_:int = param1 / this.step;
         var _loc3_:Number = param1 % this.step;
         if(Math.abs(_loc3_) > this.step / 2)
         {
            if(_loc3_ < 0)
            {
               _loc2_--;
            }
            else
            {
               _loc2_++;
            }
         }
         this.staffDialog.btn_slider.x = _loc2_ * this.step;
      }
      
      protected function get staffDialogProperties() : CafeStaffManagementDialogProperties
      {
         return properties as CafeStaffManagementDialogProperties;
      }
      
      protected function get staffDialog() : CafeStaffManagement
      {
         return disp as CafeStaffManagement;
      }
   }
}
