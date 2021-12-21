package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafePaymentTeaserDialogProperties extends BasicDialogProperties
   {
       
      
      public var discountGold:int;
      
      public var discountChips:int;
      
      public var daysleft:int;
      
      public var regBonus:Boolean;
      
      public function CafePaymentTeaserDialogProperties(param1:int, param2:int, param3:int, param4:Boolean)
      {
         this.discountGold = param1;
         this.discountChips = param2;
         this.daysleft = param3;
         this.regBonus = param4;
         super();
      }
   }
}
