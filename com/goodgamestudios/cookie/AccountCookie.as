package com.goodgamestudios.cookie
{
   import flash.net.SharedObject;
   
   public class AccountCookie
   {
       
      
      private var so:SharedObject;
      
      public function AccountCookie(param1:SharedObject)
      {
         super();
         if(!param1)
         {
            throw new Error("Cookie must not be null!");
         }
         this.so = param1;
      }
      
      public function get accountId() : String
      {
         if(!this.so.data.accountId)
         {
            this.so.data.accountId = new Date().time.toString() + (Math.random() * 999999).toFixed();
            try
            {
               this.so.flush();
            }
            catch(e:Error)
            {
               throw Error("Saving Account-Cookie failed!");
            }
         }
         return this.so.data.accountId;
      }
   }
}
