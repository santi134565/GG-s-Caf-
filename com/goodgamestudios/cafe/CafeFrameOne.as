package com.goodgamestudios.cafe
{
   import com.goodgamestudios.basic.BasicConstants;
   import com.goodgamestudios.basic.BasicFrameOne;
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.cafe.model.components.CafeLanguageData;
   import com.goodgamestudios.cafe.view.CafeBackgroundComponent;
   import flash.net.URLLoaderDataFormat;
   
   public class CafeFrameOne extends BasicFrameOne
   {
       
      
      public function CafeFrameOne()
      {
         super();
         EnviromentGlobalsHandler.init(CafeEnvironmentGlobals);
      }
      
      override protected function loadXMLs() : void
      {
         super.loadXMLs();
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.ITEM_XML_LOADER,(this.env as CafeEnvironmentGlobals).itemXMLUrl,URLLoaderDataFormat.BINARY);
         BasicModel.basicLoaderData.appLoader.addXMLLoader("levelxpXML",(this.env as CafeEnvironmentGlobals).levelxpXMLUrl,URLLoaderDataFormat.BINARY);
         BasicModel.basicLoaderData.appLoader.addXMLLoader("achievementXML",(this.env as CafeEnvironmentGlobals).achievementXMLUrl,URLLoaderDataFormat.BINARY);
      }
      
      override protected function initLanguage() : void
      {
         BasicModel.languageData = new CafeLanguageData(CafeEnvironmentGlobals);
         BasicModel.languageData.loadLanguage(this.env.language);
      }
      
      override protected function get mainGameClassName() : String
      {
         return "com.goodgamestudios.cafe.CafeGame";
      }
      
      override protected function createView() : void
      {
         preloaderView = new CafeBackgroundComponent(new CafeTitle());
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
