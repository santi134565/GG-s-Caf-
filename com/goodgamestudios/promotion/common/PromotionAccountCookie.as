package com.goodgamestudios.promotion.common
{
   import com.goodgamestudios.cookie.CookieHelper;
   import flash.net.SharedObject;
   
   public class PromotionAccountCookie
   {
      
      public static const NAME:String = "GGSAccount";
       
      
      private var so:SharedObject;
      
      private var _ageGateData:String;
      
      public function PromotionAccountCookie(cookie:SharedObject)
      {
         super();
         if(!cookie)
         {
            throw new Error("PromotionAccountCookie: Cookie must not be null!");
         }
         this.so = cookie;
         var _loc2_:String = so.data.agd;
         _ageGateData = !!_loc2_ ? CookieHelper.decrypt(so.data.agd) : "";
      }
      
      public function get accountId() : String
      {
         if(!so.data.accountId)
         {
            so.data.accountId = new Date().time.toString() + (Math.random() * 999999).toFixed();
         }
         try
         {
            so.flush();
         }
         catch(e:Error)
         {
            throw Error("PromotionAccountCookie: Saving Account-Cookie failed!");
         }
         return so.data.accountId;
      }
      
      public function get ageGateData() : String
      {
         return _ageGateData;
      }
      
      public function set ageGateData(value:String) : void
      {
         _ageGateData = value;
         so.data.agd = CookieHelper.encrypt(_ageGateData);
         writeToSharedObject();
      }
      
      private function writeToSharedObject() : void
      {
         try
         {
            CookieHelper.writeSharedObject(so);
         }
         catch(e:Error)
         {
            throw Error("PromotionAccountCookie, writeToSharedObject() -> saving account-cookie failed!");
         }
      }
   }
}
