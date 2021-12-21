package com.goodgamestudios.constants.enums
{
   public class CDN extends BasicEnum
   {
      
      private static var _values:Vector.<CDN> = new Vector.<CDN>();
      
      private static var _none:CDN = new CDN("None","",instantiationKey);
      
      private static var _fallback:CDN = new CDN("Fallback","fb",instantiationKey);
      
      private static var _akamai:CDN = new CDN("Akamai","ak",instantiationKey);
      
      private static var _cdnetworks:CDN = new CDN("CDNetworks","cd",instantiationKey);
      
      private static var _cloudfront:CDN = new CDN("Cloudfront","cl",instantiationKey);
       
      
      protected var _abbreviation:String;
      
      public function CDN(name:String, abbr:String, doNotInstantiate:Number)
      {
         super(name,doNotInstantiate);
         this._abbreviation = abbr;
         _values.push(this);
      }
      
      public static function get values() : Vector.<CDN>
      {
         return _values.concat();
      }
      
      public static function get None() : CDN
      {
         return _none;
      }
      
      public static function get Fallback() : CDN
      {
         return _fallback;
      }
      
      public static function get Akamai() : CDN
      {
         return _akamai;
      }
      
      public static function get CDNetworks() : CDN
      {
         return _cdnetworks;
      }
      
      public static function get Cloudfront() : CDN
      {
         return _cloudfront;
      }
      
      public static function getByAbbreviation(abbr:String) : CDN
      {
         return getByProperty(CDN,"abbreviation",abbr,None) as CDN;
      }
      
      public function get abbreviation() : String
      {
         return _abbreviation;
      }
   }
}
