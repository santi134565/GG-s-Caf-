package com.goodgamestudios.constants
{
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class PaymentConstants
   {
      
      public static const URL_PAYMENT:String = "http://shop.localhost/";
      
      public static const EARN_CREDITS_DISABLED:int = 0;
      
      public static const SUPERREWARDS:int = 1;
      
      public static const SPONSORPAY:int = 2;
      
      public static const CURRENCY_GOLD:int = 1;
      
      public static const CURRENCY_CHIPS:int = 2;
       
      
      public function PaymentConstants()
      {
         super();
      }
      
      public static function getEarnCreditsUrl(param1:int) : String
      {
         switch(param1)
         {
            case SUPERREWARDS:
               return "https://secure.goodgamestudios.com/shop/SR.php?";
            case SPONSORPAY:
               return "https://secure.goodgamestudios.com/shop/1-Payment.php?";
            default:
               return "";
         }
      }
      
      public static function getPaymentURLRequest(param1:String, param2:int, param3:int, param4:int, param5:String) : URLRequest
      {
         var _loc8_:URLVariables = null;
         var _loc6_:URLRequest = null;
         var _loc7_:String = PaymentConstants.URL_PAYMENT;
         (_loc8_ = new URLVariables()).lng = param1;
         _loc8_.gId = param2;
         _loc8_.nId = param3;
         _loc8_.iId = param4;
         _loc8_.key = param5;
         (_loc6_ = new URLRequest(_loc7_)).data = _loc8_;
         _loc6_.method = URLRequestMethod.GET;
         return _loc6_;
      }
      
      public static function getEarnCreditsURLRequest(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int) : URLRequest
      {
         var _loc10_:URLVariables = null;
         var _loc8_:URLRequest = null;
         var _loc9_:String = PaymentConstants.getEarnCreditsUrl(param1);
         (_loc10_ = new URLVariables()).lng = param2;
         _loc10_.gId = param3;
         _loc10_.nId = param4;
         _loc10_.iId = param5;
         _loc10_.key = param6;
         switch(param1)
         {
            case SUPERREWARDS:
               if(param7 == CURRENCY_GOLD)
               {
                  _loc10_.w = "g";
               }
               else
               {
                  _loc10_.w = "c";
               }
               break;
            case SPONSORPAY:
               _loc10_.rlnk = 19;
               if(param7 == CURRENCY_GOLD)
               {
                  _loc10_.rlnkC = "XAU";
               }
               else
               {
                  _loc10_.rlnkC = "XAG";
               }
         }
         (_loc8_ = new URLRequest(_loc9_)).data = _loc10_;
         _loc8_.method = URLRequestMethod.GET;
         return _loc8_;
      }
   }
}
