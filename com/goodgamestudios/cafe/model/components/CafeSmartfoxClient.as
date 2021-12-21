package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.components.BasicSmartfoxClient;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   
   public class CafeSmartfoxClient extends BasicSmartfoxClient
   {
       
      
      public function CafeSmartfoxClient()
      {
         super();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
