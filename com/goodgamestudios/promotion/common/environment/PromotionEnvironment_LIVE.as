package com.goodgamestudios.promotion.common.environment
{
   import com.goodgamestudios.common.environment.AbstractLiveEnvironment;
   
   public class PromotionEnvironment_LIVE extends AbstractLiveEnvironment implements IPromotionEnvironment
   {
      
      public static const NAME:String = "LIVE";
       
      
      public function PromotionEnvironment_LIVE()
      {
         super();
      }
      
      public function get configFolder() : String
      {
         return "/games-config/crossPromotion/";
      }
      
      public function get assetFolder() : String
      {
         return "/games-crosspromo/";
      }
   }
}
