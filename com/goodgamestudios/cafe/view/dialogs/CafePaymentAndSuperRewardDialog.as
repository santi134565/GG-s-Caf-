package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.constants.PaymentConstants;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafePaymentAndSuperRewardDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafePaymentAndSuperRewardDialog";
       
      
      public function CafePaymentAndSuperRewardDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.paymentAndSuperReward.btn_rewardChips.label = this.paymentAndSuperRewardProperties.buttonLabel_sr_chips;
         this.paymentAndSuperReward.btn_rewardGold.label = this.paymentAndSuperRewardProperties.buttonLabel_sr_gold;
         this.paymentAndSuperReward.btn_rewardChips.visible = env.earnCredits != PaymentConstants.EARN_CREDITS_DISABLED;
         this.paymentAndSuperReward.btn_rewardGold.visible = env.earnCredits != PaymentConstants.EARN_CREDITS_DISABLED;
         this.paymentAndSuperReward.btn_payment.label = this.paymentAndSuperRewardProperties.buttonLabel_payment;
         this.paymentAndSuperReward.txt_title.text = this.paymentAndSuperRewardProperties.title;
         this.paymentAndSuperReward.txt_copy.text = this.paymentAndSuperRewardProperties.copy;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.paymentAndSuperReward.btn_rewardChips:
               hide();
               if(this.paymentAndSuperRewardProperties.functionSR != null)
               {
                  this.paymentAndSuperRewardProperties.functionSR([PaymentConstants.CURRENCY_CHIPS]);
               }
               break;
            case this.paymentAndSuperReward.btn_rewardGold:
               hide();
               if(this.paymentAndSuperRewardProperties.functionSR != null)
               {
                  this.paymentAndSuperRewardProperties.functionSR([PaymentConstants.CURRENCY_GOLD]);
               }
               break;
            case this.paymentAndSuperReward.btn_payment:
               hide();
               if(this.paymentAndSuperRewardProperties.functionPayment != null)
               {
                  this.paymentAndSuperRewardProperties.functionPayment(null);
               }
               break;
            case this.paymentAndSuperReward.btn_close:
               hide();
         }
      }
      
      protected function get paymentAndSuperRewardProperties() : CafePaymentAndSuperRewardDialogProperties
      {
         return properties as CafePaymentAndSuperRewardDialogProperties;
      }
      
      protected function get paymentAndSuperReward() : CafePaymentReward
      {
         return disp as CafePaymentReward;
      }
   }
}
