package com.goodgamestudios.ageGate.common.environment
{
   import com.goodgamestudios.common.environment.AbstractEnvironment;
   
   public class AgeGateEnvironment extends AbstractEnvironment
   {
       
      
      public function AgeGateEnvironment()
      {
         super();
      }
      
      override protected function createTestEnvironment() : void
      {
         _environment = new AgeGateEnvironment_TEST();
      }
      
      override protected function createLiveEnvironment() : void
      {
         _environment = new AgeGateEnvironment_LIVE();
      }
      
      public function get ageGateAssetURL() : String
      {
         return ageGateEnvironment.serverUrl + ageGateEnvironment.assetFolder + "AgeGateAsset.swf";
      }
      
      public function get ageGateEnvironment() : IAgeGateEnvironment
      {
         return _environment as IAgeGateEnvironment;
      }
   }
}
