package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeFeatureUnlockedProperties extends BasicDialogProperties
   {
      
      public static const TYPE_HIGHSCORE:int = 1;
      
      public static const TYPE_STAFF:int = 2;
      
      public static const TYPE_MARKETPLACE:int = 3;
      
      public static const TYPE_COOPS:int = 4;
      
      public static const TYPE_FANCYS:int = 5;
      
      public static const TYPE_WHEELOFFORTUNE:int = 6;
      
      public static const TYPE_MUFFINMAN:int = 7;
      
      public static const TYPE_FROSTY:int = 8;
      
      public static const TYPE_PREMIUMDECO:int = 9;
       
      
      public var type:int;
      
      public function CafeFeatureUnlockedProperties(param1:int)
      {
         super();
         this.type = param1;
      }
   }
}
