package com.goodgamestudios.ageGate.common.environment
{
   import com.goodgamestudios.common.environment.AbstractTestEnvironment;
   
   public class AgeGateEnvironment_TEST extends AbstractTestEnvironment implements IAgeGateEnvironment
   {
       
      
      public function AgeGateEnvironment_TEST()
      {
         super();
      }
      
      public function get assetFolder() : String
      {
         return "/web/core/common/proxyClient/assetsAgeGate/";
      }
   }
}
