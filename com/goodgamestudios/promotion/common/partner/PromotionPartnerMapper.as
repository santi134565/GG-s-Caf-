package com.goodgamestudios.promotion.common.partner
{
   import com.goodgamestudios.promotion.common.PromotionBrowserUtil;
   import flash.net.URLVariables;
   
   public class PromotionPartnerMapper
   {
      
      private static const W_PARAMETER:String = "w";
      
      private static const TID_PARAMETER:String = "tid";
      
      private static const QUESTION_MARK:String = "?";
      
      private static var _instance:PromotionPartnerMapper;
       
      
      private var _blacklistPartnerVOs:Vector.<PromotionBlacklistedPartnerVO>;
      
      private var _whitelistPartnerVOs:Vector.<PromotionPartnerVO>;
      
      private var _currentPartner:PromotionPartnerVO;
      
      private var _xmlData:XML;
      
      public function PromotionPartnerMapper()
      {
         super();
         _currentPartner = new PromotionPartnerVO("noPartner","noPartner");
      }
      
      public static function get instance() : PromotionPartnerMapper
      {
         if(!_instance)
         {
            _instance = new PromotionPartnerMapper();
         }
         return _instance;
      }
      
      public function init(xmlData:XML) : void
      {
         _xmlData = xmlData;
         _blacklistPartnerVOs = new Vector.<PromotionBlacklistedPartnerVO>();
         _whitelistPartnerVOs = new Vector.<PromotionPartnerVO>();
         parsePartnerBlacklist();
         parsePartnerWhitelist();
      }
      
      private function parsePartnerBlacklist() : void
      {
         var _loc1_:* = null;
         var _loc2_:XMLList = _xmlData.promoted.partnerSites.bl;
         for each(var _loc3_ in _loc2_.partner)
         {
            _loc1_ = new PromotionBlacklistedPartnerVO(_loc3_.attribute("id"),_loc3_.attribute("w"));
            _blacklistPartnerVOs.push(_loc1_);
         }
      }
      
      private function parsePartnerWhitelist() : void
      {
         var _loc1_:* = null;
         var _loc3_:XMLList = _xmlData.promoted.partnerSites.wl;
         for each(var _loc2_ in _loc3_.partner)
         {
            _loc1_ = new PromotionPartnerVO(_loc2_.attribute("id"),_loc2_.promotedGameURL);
            _whitelistPartnerVOs.push(_loc1_);
         }
      }
      
      public function detectPartnerIsBlackListed(partnerURL:String) : Boolean
      {
         var _loc3_:* = null;
         var _loc5_:String;
         var _loc2_:Boolean = (_loc5_ = PromotionBrowserUtil.getMainDomainURL() != "" ? PromotionBrowserUtil.getMainDomainURL() : partnerURL).indexOf("w=") != -1 || _loc5_.indexOf("tid=") != -1;
         if(_loc2_)
         {
            _loc3_ = blacklistParameters(_loc5_);
         }
         var _loc6_:String = getDomainFromURL(_loc5_);
         for each(var _loc4_ in _blacklistPartnerVOs)
         {
            if(_loc6_ == _loc4_.referrerId)
            {
               return true;
            }
            if(_loc3_ && (_loc3_["w"] == _loc4_.blacklistedParameter || _loc3_["tid"] == _loc4_.blacklistedParameter))
            {
               if(_loc4_.blacklistedParameter != "")
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getDomainFromURL(url:String) : String
      {
         var _loc2_:* = null;
         var _loc4_:* = "";
         if(url.indexOf("http://www.") != -1)
         {
            _loc2_ = url.split("http://www.");
         }
         else if(url.indexOf("http://") != -1)
         {
            _loc2_ = url.split("http://");
         }
         var _loc5_:String = "";
         if(_loc2_ && _loc2_.length > 1)
         {
            _loc5_ = _loc2_[1];
         }
         var _loc3_:Array = _loc5_.split("/");
         if(_loc3_.length > 0)
         {
            _loc4_ = _loc3_[0];
         }
         if(!_loc4_)
         {
            _loc4_ = url;
         }
         return _loc4_;
      }
      
      private function blacklistParameters(domain:String) : Object
      {
         var _loc2_:URLVariables = new URLVariables(domain.split("?")[1]);
         var _loc3_:Object = {};
         _loc3_["w"] = _loc2_["w"];
         _loc3_["tid"] = _loc2_["tid"];
         return _loc3_;
      }
      
      public function detectPartnerFromReferrerURL(referrerURL:String) : PromotionPartnerVO
      {
         var _loc3_:String = getDomainFromURL(referrerURL);
         for each(var _loc2_ in _whitelistPartnerVOs)
         {
            if(_loc3_ == _loc2_.referrerId)
            {
               _currentPartner = _loc2_;
               return _currentPartner;
            }
         }
         return null;
      }
      
      public function get currentPartner() : PromotionPartnerVO
      {
         return _currentPartner;
      }
      
      public function get blacklistPartnerVOs() : Vector.<PromotionBlacklistedPartnerVO>
      {
         return _blacklistPartnerVOs;
      }
      
      public function get whitelistPartnerVOs() : Vector.<PromotionPartnerVO>
      {
         return _whitelistPartnerVOs;
      }
   }
}
