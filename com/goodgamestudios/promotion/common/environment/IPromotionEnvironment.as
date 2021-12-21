package com.goodgamestudios.promotion.common.environment
{
   import com.goodgamestudios.common.environment.IEnvironment;
   
   public interface IPromotionEnvironment extends IEnvironment
   {
       
      
      function get configFolder() : String;
      
      function get assetFolder() : String;
   }
}
