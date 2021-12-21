package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.event.CafeNPCEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeNpcData;
   import com.goodgamestudios.cafe.view.BasicButton;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CafeStaffHireDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeStaffHireDialog";
      
      public static const MAX_HEIGHT:int = 120;
       
      
      private var selectedButton:BasicButton;
      
      private var maleNameArray:Array;
      
      private var femaleNameArray:Array;
      
      public function CafeStaffHireDialog(param1:Sprite)
      {
         this.maleNameArray = ["Oskar","James","Jeffrey","Tom","William"];
         this.femaleNameArray = ["Jane","Lucy","Emma","Stacey","Becky"];
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.staffDialog.btn_yes.textXOffset = 30;
         this.staffDialog.btn_yes.label = this.staffDialogProperties.buttonLabel_yes;
         this.staffDialog.txt_title.text = this.staffDialogProperties.title;
         this.staffDialog.txt_copy.text = this.staffDialogProperties.copy;
         this.staffDialog.txt_nameinput.inputField.text = "";
         this.staffDialog.txt_name.text = CafeModel.languageData.getTextById("dialogwin_avatarcreate_txt_avatar_name");
         this.staffDialog.btn_female.txt_name.text = CafeModel.languageData.getTextById("dialogwin_avatarcreate_woman");
         this.staffDialog.btn_male.txt_name.text = CafeModel.languageData.getTextById("dialogwin_avatarcreate_man");
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeNPCEvent.WAITER_ADDED,this.onWaiterlistChanged);
      }
      
      override protected function init() : void
      {
         var _loc1_:Sprite = new CafeStaffDummy();
         var _loc2_:Sprite = new CafeStaffDummyFemale();
         this.fillItem(_loc1_,this.staffDialog.btn_male);
         this.fillItem(_loc2_,this.staffDialog.btn_female);
         this.staffDialog.txt_nameinput.inputField.maxChars = CafeNpcData.MAX_NAMELENGTH;
         super.init();
      }
      
      override public function show() : void
      {
         super.show();
         var _loc1_:int = Math.random() * 2;
         this.activateButton(_loc1_ == 1 ? this.staffDialog.btn_male : this.staffDialog.btn_female);
         this.randomizeName();
      }
      
      private function randomizeName() : void
      {
         var _loc1_:int = 0;
         if(this.selectedButton == this.staffDialog.btn_male)
         {
            _loc1_ = Math.random() * (this.maleNameArray.length - 1);
            this.staffDialog.txt_nameinput.inputField.text = this.maleNameArray[_loc1_];
         }
         else
         {
            _loc1_ = Math.random() * (this.femaleNameArray.length - 1);
            this.staffDialog.txt_nameinput.inputField.text = this.femaleNameArray[_loc1_];
         }
      }
      
      private function fillItem(param1:Sprite, param2:MovieClip) : void
      {
         var _loc3_:Rectangle = param1.getBounds(null);
         var _loc4_:Number = MAX_HEIGHT / _loc3_.height;
         param1.x = -(_loc3_.width * _loc4_ / 2 + _loc3_.left * _loc4_);
         param1.y = -(_loc3_.top * _loc4_);
         param1.scaleX = param1.scaleY = _loc4_;
         while(param2.mc_holder.numChildren > 0)
         {
            param2.mc_holder.removeChildAt(0);
         }
         param2.mc_holder.addChild(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.staffDialog.btn_yes:
               if(!this.selectedButton)
               {
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("createavatar_error"),CafeModel.languageData.getTextById("createavatar_error_nogender")));
                  return;
               }
               controller.addEventListener(CafeNPCEvent.WAITER_ADDED,this.onWaiterlistChanged);
               if(this.staffDialogProperties.functionYes != null)
               {
                  this.staffDialogProperties.functionYes([this.staffDialog.txt_nameinput.inputField.text,this.selectedButton == this.staffDialog.btn_female ? 1 : 2]);
               }
               break;
            case this.staffDialog.btn_close:
               this.hide();
               if(this.staffDialogProperties.functionNo != null)
               {
                  this.staffDialogProperties.functionNo(null);
               }
               break;
            case this.staffDialog.btn_female:
            case this.staffDialog.btn_male:
               this.activateButton(param1.target as BasicButton);
               this.randomizeName();
         }
      }
      
      protected function activateButton(param1:BasicButton) : void
      {
         if(this.selectedButton != param1)
         {
            if(this.selectedButton)
            {
               this.selectedButton.deselected();
            }
            this.selectedButton = param1;
            this.selectedButton.selected();
         }
      }
      
      private function onWaiterlistChanged(param1:CafeNPCEvent) : void
      {
         this.hide();
      }
      
      override public function hide() : void
      {
         controller.removeEventListener(CafeNPCEvent.WAITER_ADDED,this.onWaiterlistChanged);
         super.hide();
      }
      
      protected function get staffDialogProperties() : CafeStaffHireDialogProperties
      {
         return properties as CafeStaffHireDialogProperties;
      }
      
      protected function get staffDialog() : CafeStaffHire
      {
         return disp as CafeStaffHire;
      }
   }
}
