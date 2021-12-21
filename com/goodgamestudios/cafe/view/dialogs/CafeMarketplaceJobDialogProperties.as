package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeMarketplaceJobDialogProperties extends BasicDialogProperties
   {
       
      
      public var buttonLabel_yes:String = "Yes";
      
      public var buttonLabel_no:String = "No";
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public var offerUserId:int;
      
      public function CafeMarketplaceJobDialogProperties(param1:String, param2:String, param3:int, param4:String = "Yes", param5:String = "No")
      {
         this.buttonLabel_yes = param4;
         this.buttonLabel_no = param5;
         this.title = param1;
         this.copy = param2;
         this.offerUserId = param3;
         super();
      }
   }
}
