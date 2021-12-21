package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeMailGiftDialogProperties extends BasicDialogProperties
   {
      
      public static const TYPE_GET_GIFT:String = "getGift";
      
      public static const TYPE_SENDMAIL:String = "sendMail";
       
      
      public var title:String;
      
      public var copy1:String;
      
      public var copy2:String;
      
      public var dialogType:String;
      
      public function CafeMailGiftDialogProperties(param1:String, param2:String, param3:String, param4:String)
      {
         this.title = param1;
         this.copy1 = param2;
         this.copy2 = param3;
         this.dialogType = param4;
         super();
      }
   }
}
