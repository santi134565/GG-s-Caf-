package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.door.BasicDoor;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeChoiceAmountDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeChoiceAmountDialog";
       
      
      private const SCALE_FACTOR:Number = 1.2;
      
      private var amount:int = 1;
      
      public function CafeChoiceAmountDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.choiceDialog.btn_yes.visible = this.choiceDialogProperties.buttonType_yes == CafeChoiceAmountDialogProperties.BUTTONTYPE_STANDARD;
         this.choiceDialog.btn_yes.label = this.choiceDialogProperties.buttonLabel_yes;
         this.choiceDialog.btn_order.visible = this.choiceDialogProperties.buttonType_yes == CafeChoiceAmountDialogProperties.BUTTONTYPE_COURIER;
         this.choiceDialog.btn_order.textXOffset = 30;
         this.choiceDialog.btn_order.label = this.choiceDialogProperties.buttonLabel_yes;
         this.choiceDialog.btn_no.label = this.choiceDialogProperties.buttonLabel_no;
         this.choiceDialog.txt_title.text = this.choiceDialogProperties.title;
         this.choiceDialog.txt_copy.text = this.choiceDialogProperties.copy;
         this.amount = 1;
         this.choiceDialog.txt_amount.text = "x" + this.amount;
         while(this.choiceDialog.mc_itemholder.numChildren > 0)
         {
            this.choiceDialog.mc_itemholder.removeChildAt(0);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.choiceDialog.btn_up:
               this.changeAmount(1);
               break;
            case this.choiceDialog.btn_down:
               this.changeAmount(-1);
               break;
            case this.choiceDialog.btn_order:
            case this.choiceDialog.btn_yes:
               hide();
               if(this.choiceDialogProperties.functionYes != null)
               {
                  this.choiceDialogProperties.functionYes([this.choiceDialogProperties.wodId,this.amount]);
               }
               break;
            case this.choiceDialog.btn_close:
            case this.choiceDialog.btn_no:
               hide();
               if(this.choiceDialogProperties.functionNo != null)
               {
                  this.choiceDialogProperties.functionNo(null);
               }
         }
      }
      
      private function fillItem() : void
      {
         var _loc3_:DisplayObject = null;
         if(this.choiceDialogProperties.wodId < 0)
         {
            return;
         }
         var _loc1_:VisualVO = CafeModel.wodData.voList[this.choiceDialogProperties.wodId] as VisualVO;
         var _loc2_:Class = getDefinitionByName(_loc1_.getVisClassName()) as Class;
         _loc3_ = new _loc2_();
         if(_loc3_ is MovieClip)
         {
            if(_loc1_.group == CafeConstants.GROUP_DOOR)
            {
               (_loc3_ as MovieClip).gotoAndStop(BasicDoor.DOOR_WITH_BORDER);
            }
            else
            {
               (_loc3_ as MovieClip).stop();
            }
         }
         var _loc4_:Rectangle = _loc3_.getBounds(null);
         _loc3_.scaleX = _loc3_.scaleY = this.SCALE_FACTOR;
         _loc3_.x = -(_loc4_.width * this.SCALE_FACTOR / 2 + _loc4_.left * this.SCALE_FACTOR);
         _loc3_.y = -(_loc4_.height * this.SCALE_FACTOR / 2 + _loc4_.top * this.SCALE_FACTOR);
         this.choiceDialog.mc_itemholder.addChild(_loc3_);
      }
      
      override public function show() : void
      {
         super.show();
         this.fillItem();
      }
      
      private function changeAmount(param1:int) : void
      {
         if(this.amount + param1 > 0 && this.amount + param1 <= this.choiceDialogProperties.maxAmount)
         {
            this.amount += param1;
         }
         this.choiceDialog.txt_amount.text = "x" + this.amount;
      }
      
      protected function get choiceDialogProperties() : CafeChoiceAmountDialogProperties
      {
         return properties as CafeChoiceAmountDialogProperties;
      }
      
      protected function get choiceDialog() : CafeCourier
      {
         return disp as CafeCourier;
      }
   }
}
