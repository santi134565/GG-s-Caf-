package com.goodgamestudios.promotion.common.partner
{
   public class PromotionPartnerVO
   {
       
      
      public var referrerId:String;
      
      public var promotedGameURL:String;
      
      public function PromotionPartnerVO(referrerId:String, promotedGameURL:String)
      {
         super();
         this.referrerId = referrerId;
         this.promotedGameURL = promotedGameURL;
      }
      
      public function toString() : String
      {
         return "referrerId: " + referrerId + ", promotedGameURL: " + promotedGameURL;
      }
   }
}
