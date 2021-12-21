package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.model.components.BasicSocialData;
   import flash.external.ExternalInterface;
   
   public class CafeSocialData extends BasicSocialData
   {
      
      public static const EXTERNAL_SHARE_LEVELUP:String = "postLevelUpFeed";
      
      public static const EXTERNAL_SHARE_EXPAND:String = "postExpand";
      
      public static const EXTERNAL_SHARE_ACHIEVEMENT:String = "postAchievementFeed";
      
      public static const EXTERNAL_SHARE_WAITER:String = "postNewWaiterFeed";
      
      public static const EXTERNAL_SHARE_GIFTS:String = "postNewGiftFeed";
      
      public static const EXTERNAL_SHARE_COOPSTART:String = "postCoopStartFeed";
      
      public static const EXTERNAL_SHARE_COOPEND:String = "postCoopEndFeed";
      
      public static const EXTERNAL_SHARE_PERFECTDISH:String = "postPerfectDishFeed";
      
      public static const EXTERNAL_SHARE_FIND_TIP:String = "postGotTipFeed";
      
      public static const EXTERNAL_SHARE_FIND_INGREDIENT:String = "postSecretIngredientFeed";
      
      public static const EXTERNAL_SHARE_DISHMASTERY:String = "postDishMasteryFeed";
       
      
      public function CafeSocialData()
      {
         super();
      }
      
      public function postFeed(param1:String, param2:Array = null) : void
      {
         this.externalInterface(param1,param2);
      }
      
      override protected function externalInterface(param1:String, param2:Array = null) : void
      {
         var type:String = param1;
         var params:Array = param2;
         super.externalInterface(type,params);
         if(!ExternalInterface.available)
         {
            return;
         }
         try
         {
            switch(type)
            {
               case EXTERNAL_SHARE_EXPAND:
                  ExternalInterface.call(type);
                  break;
               case EXTERNAL_SHARE_COOPEND:
               case EXTERNAL_SHARE_PERFECTDISH:
               case EXTERNAL_SHARE_DISHMASTERY:
                  if(params)
                  {
                     ExternalInterface.call(type,params[0],params[1]);
                  }
                  break;
               default:
                  if(params)
                  {
                     ExternalInterface.call(type,params[0]);
                  }
            }
         }
         catch(error:SecurityError)
         {
         }
      }
   }
}
