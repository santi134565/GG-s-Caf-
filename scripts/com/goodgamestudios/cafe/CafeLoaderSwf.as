package com.goodgamestudios.cafe
{
   import com.goodgamestudios.basic.BasicLoaderSwf;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   
   public class CafeLoaderSwf extends BasicLoaderSwf
   {
       
      
      public function CafeLoaderSwf()
      {
         super();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
