package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.view.dialogs.CafePaymentcheaperDialog;
   
   public class PPCCommand extends CafeCommand
   {
       
      
      public function PPCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_PAYMENT_SHOP_PRICE_CHANGE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0 && env.usePayment)
         {
            layoutManager.showDialog(CafePaymentcheaperDialog.NAME);
         }
         return param1 == 0;
      }
   }
}
