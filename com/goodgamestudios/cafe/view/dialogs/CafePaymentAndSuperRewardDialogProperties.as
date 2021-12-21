package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafePaymentAndSuperRewardDialogProperties extends BasicDialogProperties
   {
       
      
      public var buttonLabel_sr_chips:String;
      
      public var buttonLabel_sr_gold:String;
      
      public var buttonLabel_payment:String;
      
      public var title:String;
      
      public var copy:String;
      
      public var functionSR:Function;
      
      public var functionPayment:Function;
      
      public function CafePaymentAndSuperRewardDialogProperties(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Function, param7:Function)
      {
         this.title = param1;
         this.copy = param2;
         this.buttonLabel_payment = param3;
         this.buttonLabel_sr_chips = param4;
         this.buttonLabel_sr_gold = param5;
         this.functionSR = param6;
         this.functionPayment = param7;
         super();
      }
   }
}
