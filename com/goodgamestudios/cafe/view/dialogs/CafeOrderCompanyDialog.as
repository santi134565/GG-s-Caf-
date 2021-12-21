package com.goodgamestudios.cafe.view.dialogs
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeOrderCompanyDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeOrderCompanyDialog";
       
      
      public function CafeOrderCompanyDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.orderCompanyDialog.btn_buy.textXOffset = 35;
         this.orderCompanyDialog.btn_buy.label = "x" + this.orderCompanyProperties.expensivPrice;
         this.orderCompanyDialog.txt_title.text = this.orderCompanyProperties.title;
         this.orderCompanyDialog.txt_copy.text = this.orderCompanyProperties.copy;
         this.orderCompanyDialog.btn_addfriend.visible = env.invitefriends;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.orderCompanyDialog.btn_close:
               hide();
               break;
            case this.orderCompanyDialog.btn_addfriend:
               hide();
               if(this.orderCompanyProperties.functionFriend != null)
               {
                  this.orderCompanyProperties.functionFriend(null);
               }
               break;
            case this.orderCompanyDialog.btn_buy:
               hide();
               if(this.orderCompanyProperties.functionBuy != null)
               {
                  this.orderCompanyProperties.functionBuy([this.orderCompanyProperties.wodId]);
               }
         }
      }
      
      protected function get orderCompanyProperties() : CafeOrderCompanyDialogProperties
      {
         return properties as CafeOrderCompanyDialogProperties;
      }
      
      protected function get orderCompanyDialog() : OrderCompanyDialog
      {
         return disp as OrderCompanyDialog;
      }
   }
}
