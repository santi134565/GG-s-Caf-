package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import flash.external.ExternalInterface;
   
   public class BasicSocialData
   {
      
      public static const INVITE:String = "invite";
      
      public static const RELOAD:String = "reload";
       
      
      public function BasicSocialData()
      {
         super();
      }
      
      public function inviteFriends() : void
      {
         if(this.env.hasNetworkBuddies)
         {
            this.externalInterface(INVITE);
         }
      }
      
      public function reloadIFrame() : void
      {
         this.externalInterface(RELOAD);
      }
      
      protected function externalInterface(param1:String, param2:Array = null) : void
      {
         var type:String = param1;
         var params:Array = param2;
         if(!ExternalInterface.available)
         {
            return;
         }
         try
         {
            switch(type)
            {
               case INVITE:
               case RELOAD:
                  ExternalInterface.call(type);
            }
         }
         catch(error:SecurityError)
         {
         }
      }
      
      private function get env() : BasicEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
   }
}
