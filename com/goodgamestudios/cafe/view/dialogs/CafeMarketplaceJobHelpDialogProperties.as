package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeMarketplaceJobHelpDialogProperties extends BasicDialogProperties
   {
       
      
      public var title:String;
      
      public var header1:String;
      
      public var header2:String;
      
      public var copy1:String;
      
      public var copy2:String;
      
      public var buttonLabel_ok:String;
      
      public function CafeMarketplaceJobHelpDialogProperties(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String)
      {
         this.title = param1;
         this.header1 = param2;
         this.header2 = param3;
         this.copy1 = param4;
         this.copy2 = param5;
         this.buttonLabel_ok = param6;
         super();
      }
   }
}
