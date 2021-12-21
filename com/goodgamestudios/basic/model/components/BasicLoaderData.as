package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.loading.GoodgameLoader;
   
   public class BasicLoaderData
   {
       
      
      private var _appLoader:GoodgameLoader;
      
      private var _assetLoader:GoodgameLoader;
      
      public function BasicLoaderData()
      {
         this._appLoader = new GoodgameLoader("appLoader",100);
         this._assetLoader = new GoodgameLoader("assetLoader",100);
         super();
      }
      
      public function get appLoader() : GoodgameLoader
      {
         return this._appLoader;
      }
      
      public function get assetLoader() : GoodgameLoader
      {
         return this._assetLoader;
      }
   }
}
