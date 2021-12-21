package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeFeatureDialogProperties extends BasicDialogProperties
   {
       
      
      public var featureId:int;
      
      public function CafeFeatureDialogProperties(param1:int)
      {
         this.featureId = param1;
         super();
      }
   }
}
