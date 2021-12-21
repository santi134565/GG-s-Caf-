package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafePaymentTeaserDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafePaymentTeaserDialog";
       
      
      public function CafePaymentTeaserDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function get isUnique() : Boolean
      {
         return false;
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
         this.teaserDialog.txt_title.text = CafeModel.languageData.getTextById("generic_payment_discount_title");
         this.teaserDialog.btn_ok.label = CafeModel.languageData.getTextById("btn_text_okay");
         if(this.teaserDialogProperties.regBonus)
         {
            this.teaserDialog.txt_copy.text = CafeModel.languageData.getTextById("generic_payment_48hdiscount_copy",[this.teaserDialogProperties.discountGold,this.teaserDialogProperties.discountChips]);
         }
         else
         {
            this.teaserDialog.txt_copy.text = CafeModel.languageData.getTextById("generic_payment_discount_copy",[this.teaserDialogProperties.discountGold,this.teaserDialogProperties.discountChips]);
         }
         this.teaserDialog.txt_time.text = CafeModel.languageData.getTextById("generic_payment_discount_time",[TimeStringHelper.getTimeToString(this.teaserDialogProperties.daysleft,TimeStringHelper.TWO_TIME_FORMAT,CafeModel.languageData.getTextById)]);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.teaserDialog.btn_ok:
               hide();
         }
      }
      
      protected function get teaserDialogProperties() : CafePaymentTeaserDialogProperties
      {
         return properties as CafePaymentTeaserDialogProperties;
      }
      
      private function get teaserDialog() : PaymentBonusPopup
      {
         return disp as PaymentBonusPopup;
      }
   }
}
