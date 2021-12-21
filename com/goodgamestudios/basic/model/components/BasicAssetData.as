package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.event.BasicAssetsEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import flash.events.EventDispatcher;
   
   public class BasicAssetData extends EventDispatcher
   {
       
      
      public function BasicAssetData()
      {
         super();
         if(BasicModel.basicLoaderData.assetLoader.isComplete)
         {
            this.handleComplete();
         }
         else
         {
            BasicModel.basicLoaderData.assetLoader.loadingQueueFirstTimeFinished.add(this.handleComplete);
         }
      }
      
      private function handleComplete(param1:String = "") : void
      {
         dispatchEvent(new BasicAssetsEvent(BasicAssetsEvent.ASSETS_COMPLETE));
      }
      
      public function get isComplete() : Boolean
      {
         return BasicModel.basicLoaderData.assetLoader.isComplete;
      }
   }
}
