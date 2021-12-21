package com.goodgamestudios.promotion.pages.common
{
   import com.goodgamestudios.promotion.common.IPromotionOriginalGameModel;
   import com.goodgamestudios.promotion.common.language.AbstractPromotionLanguageModel;
   
   public class PromotionVO
   {
       
      
      public var originalGameId:int;
      
      public var originalGameLogoURL:String;
      
      public var languageModel:AbstractPromotionLanguageModel;
      
      public var originalGameModel:IPromotionOriginalGameModel;
      
      public function PromotionVO()
      {
         super();
      }
   }
}
