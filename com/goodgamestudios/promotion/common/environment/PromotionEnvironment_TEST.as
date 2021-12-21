package com.goodgamestudios.promotion.common.environment
{
   import com.goodgamestudios.common.environment.AbstractTestEnvironment;
   
   public class PromotionEnvironment_TEST extends AbstractTestEnvironment implements IPromotionEnvironment
   {
       
      
      public function PromotionEnvironment_TEST()
      {
         super();
      }
      
      public function get configFolder() : String
      {
         return "/web/core/common/proxyClient/config/";
      }
      
      public function get assetFolder() : String
      {
         return "/web/core/common/proxyClient/assetsCrosspromotion/";
      }
   }
}
