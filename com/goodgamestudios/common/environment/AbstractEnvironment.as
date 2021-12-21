package com.goodgamestudios.common.environment
{
   import com.goodgamestudios.promotion.common.PromotionModel;
   import flash.system.Security;
   
   public class AbstractEnvironment
   {
      
      private static const LOCAL:String = "local";
      
      private static const TEST:String = "test";
      
      private static const LIVE:String = "live";
      
      private static var _environmentId:String;
      
      protected static var _environment:AbstractEnvironment;
       
      
      public function AbstractEnvironment()
      {
         super();
      }
      
      public function init() : void
      {
         detectEnvironment();
         createEnvironment();
      }
      
      private function detectEnvironment() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!_environmentId)
         {
            _loc1_ = PromotionModel.instance.swf.root.loaderInfo.parameters["environment"];
            if(_loc1_)
            {
               _environmentId = _loc1_;
               return;
            }
            if(Security.sandboxType == "localTrusted")
            {
               _environmentId = "local";
            }
            else
            {
               _loc2_ = PromotionModel.instance.referrerSwfURL;
               if(_loc2_.indexOf("test") >= 0 || _loc2_.indexOf("dev") >= 0)
               {
                  _environmentId = "test";
               }
               else
               {
                  _environmentId = "live";
               }
            }
         }
      }
      
      protected function createEnvironment() : void
      {
         if(!_environmentId)
         {
            detectEnvironment();
         }
         switch(_environmentId)
         {
            case "local":
               createLocalEnvironment();
               break;
            case "test":
               createTestEnvironment();
               break;
            case "live":
               createLiveEnvironment();
         }
      }
      
      protected function createLocalEnvironment() : void
      {
         _environment = new AbstractLocalEnvironment();
      }
      
      protected function createTestEnvironment() : void
      {
         _environment = new AbstractTestEnvironment();
      }
      
      protected function createLiveEnvironment() : void
      {
         _environment = new AbstractLiveEnvironment();
      }
      
      public function get name() : String
      {
         return "AbstractEnvironment";
      }
      
      public function get environment() : AbstractEnvironment
      {
         return _environment;
      }
   }
}
