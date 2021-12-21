package com.goodgamestudios.promotion.common
{
   public class PromotionURLVariables
   {
      
      private static const URL_PARAMETER_PARTNER_DOMAIN:String = "pd";
       
      
      private var _urlGetParameters:Object;
      
      public var partnerDomain:String;
      
      public function PromotionURLVariables()
      {
         super();
      }
      
      public function init() : void
      {
         _urlGetParameters = PromotionBrowserUtil.getUrlVariables();
         if(_urlGetParameters && _urlGetParameters["pd"])
         {
            partnerDomain = _urlGetParameters["pd"];
         }
      }
   }
}
