package com.goodgamestudios.promotion.common.partner
{
   public class PromotionBlacklistedPartnerVO
   {
       
      
      public var referrerId:String;
      
      public var blacklistedParameter:String;
      
      public function PromotionBlacklistedPartnerVO(referrerId:String, blacklistedparameter:String)
      {
         super();
         this.referrerId = referrerId;
         this.blacklistedParameter = blacklistedparameter;
      }
      
      public function toString() : String
      {
         return "referrerId: " + referrerId + ", promotedGameURL: " + blacklistedParameter;
      }
   }
}
