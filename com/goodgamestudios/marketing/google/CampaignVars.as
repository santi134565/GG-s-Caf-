package com.goodgamestudios.marketing.google
{
   public class CampaignVars
   {
      
      public static const PARTNER_ID:String = "pid";
      
      public static const CHANNEL_ID:String = "cid";
      
      public static const TRAFFIC_SOURCE:String = "tid";
      
      public static const CREATIVE:String = "creative";
      
      public static const PLACEMENT:String = "placement";
      
      public static const KEYWORD:String = "keyword";
      
      public static const NETWORK:String = "network";
      
      public static const LP:String = "lp";
      
      public static const ADID:String = "adid";
      
      public static const CAMP:String = "camp";
      
      public static const ADGR:String = "adgr";
      
      public static const MATCHTYPE:String = "matchtype";
       
      
      private var _partnerId:Number = -1;
      
      private var _channelId:String = "";
      
      private var _trafficSource:String = "";
      
      private var _creative:Number = -1;
      
      private var _placement:String = "";
      
      private var _keyword:String = "";
      
      private var _network:String = "";
      
      private var _lp:Number = -1;
      
      private var _adid:Number = -1;
      
      private var _camp:String = "";
      
      private var _adgr:String = "";
      
      private var _matchtype:String = "";
      
      public function CampaignVars(param1:Object)
      {
         var vars:Object = param1;
         super();
         try
         {
            this._partnerId = parseInt(vars[PARTNER_ID]);
            this._channelId = vars[CHANNEL_ID];
            this._trafficSource = vars[TRAFFIC_SOURCE];
            this._creative = parseInt(vars[CREATIVE]);
            this._placement = vars[PLACEMENT];
            this._keyword = vars[KEYWORD];
            this._network = vars[NETWORK];
            this._lp = vars[LP];
            this._adid = vars[ADID];
            this._camp = vars[CAMP];
            this._adgr = vars[ADGR];
            this._matchtype = vars[MATCHTYPE];
         }
         catch(e:Error)
         {
            trace("Failed constructing campaign vars.");
         }
      }
      
      public function get channelId() : String
      {
         if(this._channelId)
         {
            return this._channelId;
         }
         return "";
      }
      
      public function set channelId(param1:String) : void
      {
         this._channelId = param1;
      }
      
      public function get trafficSource() : String
      {
         if(this._trafficSource)
         {
            return this._trafficSource;
         }
         return "";
      }
      
      public function set trafficSource(param1:String) : void
      {
         this._trafficSource = param1;
      }
      
      public function get partnerId() : Number
      {
         if(this._partnerId)
         {
            return this._partnerId;
         }
         return -1;
      }
      
      public function get creative() : Number
      {
         if(this._creative)
         {
            return this._creative;
         }
         return -1;
      }
      
      public function get placement() : String
      {
         if(this._placement)
         {
            return this._placement;
         }
         return "";
      }
      
      public function get keyword() : String
      {
         if(this._keyword)
         {
            return this._keyword;
         }
         return "";
      }
      
      public function get network() : String
      {
         if(this._network)
         {
            return this._network;
         }
         return "";
      }
      
      public function get lp() : Number
      {
         if(this._lp)
         {
            return this._lp;
         }
         return -1;
      }
      
      public function set lp(param1:Number) : void
      {
         this._lp = param1;
      }
      
      public function isValid() : Boolean
      {
         return !isNaN(this._partnerId) && this._partnerId > 0;
      }
      
      public function get adid() : Number
      {
         if(this._adid)
         {
            return this._adid;
         }
         return -1;
      }
      
      public function get camp() : String
      {
         if(this._camp)
         {
            return this._camp;
         }
         return "";
      }
      
      public function get adgr() : String
      {
         if(this._adgr)
         {
            return this._adgr;
         }
         return "";
      }
      
      public function get matchtype() : String
      {
         if(this._matchtype)
         {
            return this._matchtype;
         }
         return "";
      }
   }
}
