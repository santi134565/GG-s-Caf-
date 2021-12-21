package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeOrderCompanyDialogProperties extends BasicDialogProperties
   {
       
      
      public var title:String;
      
      public var copy:String;
      
      public var functionFriend:Function;
      
      public var functionBuy:Function;
      
      public var expensivPrice:int;
      
      public var wodId:int;
      
      public var buttonText_cancle:String;
      
      public function CafeOrderCompanyDialogProperties(param1:String, param2:String, param3:int, param4:int, param5:Function, param6:Function, param7:String)
      {
         this.title = param1;
         this.copy = param2;
         this.wodId = param4;
         this.functionBuy = param6;
         this.functionFriend = param5;
         this.expensivPrice = param3;
         this.buttonText_cancle = param7;
         super();
      }
   }
}
