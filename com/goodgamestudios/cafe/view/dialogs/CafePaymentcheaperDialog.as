package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafePaymentcheaperDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafePaymentcheaperDialog";
       
      
      public function CafePaymentcheaperDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
         this.teaserDialog.txt_title.text = CafeModel.languageData.getTextById("generic_payment_discount_title");
         this.teaserDialog.txt_copy.text = CafeModel.languageData.getTextById("generic_payment_newPrices");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.teaserDialog.btn_toshop:
               if(CafeModel.userData.isGuest())
               {
                  layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
               }
               else
               {
                  controller.addExtraGold();
               }
               hide();
               break;
            case this.teaserDialog.btn_ok:
            case this.teaserDialog.btn_close:
               hide();
         }
      }
      
      private function get teaserDialog() : PaymentCheaperPopUp
      {
         return disp as PaymentCheaperPopUp;
      }
   }
}
