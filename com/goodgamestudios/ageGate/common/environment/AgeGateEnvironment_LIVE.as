package com.goodgamestudios.ageGate.common.environment
{
   import com.goodgamestudios.common.environment.AbstractLiveEnvironment;
   
   public class AgeGateEnvironment_LIVE extends AbstractLiveEnvironment implements IAgeGateEnvironment
   {
       
      
      public function AgeGateEnvironment_LIVE()
      {
         super();
      }
      
      public function get assetFolder() : String
      {
         return "/games-crosspromo/ageGate/assets/";
      }
   }
}
