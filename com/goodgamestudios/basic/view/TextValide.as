package com.goodgamestudios.basic.view
{
   import com.adobe.utils.StringUtil;
   
   public class TextValide
   {
      
      public static var SUBST_PERCENT:String = "&percnt;";
      
      public static var SUBST_QUOTE:String = "&quot;";
      
      public static var SUBST_APOSTROPHE:String = "&#145;";
      
      public static var SUBST_NEWLINE:String = "<br />";
      
      private static var invalidChars:Array = ["+","%","&","*","/","(",")","[","]","{","}","\"","\'","\\","´","`","^","°","§","€","²","³",",",";","µ","$"];
       
      
      public function TextValide()
      {
         super();
      }
      
      public static function isSmartFoxValide(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(StringUtil.trim(param1) == "")
         {
            return false;
         }
         for each(_loc2_ in invalidChars)
         {
            if(param1.indexOf(_loc2_) >= 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getSmartFoxInvalideChar(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = "";
         if(StringUtil.trim(param1) == "")
         {
            return _loc2_;
         }
         for each(_loc3_ in invalidChars)
         {
            if(param1.indexOf(_loc3_) >= 0)
            {
               _loc2_ += _loc3_;
            }
         }
         return _loc2_;
      }
      
      public static function getCleanText(param1:String) : String
      {
         var _loc2_:String = null;
         for each(_loc2_ in invalidChars)
         {
            param1 = param1.replace(_loc2_,"");
         }
         return getValideSmartFoxText(param1);
      }
      
      public static function getValideSmartFoxText(param1:String) : String
      {
         var _loc2_:RegExp = /%/g;
         var _loc3_:RegExp = /'/g;
         param1 = param1.replace(_loc2_,SUBST_PERCENT);
         return param1.replace(_loc3_,"");
      }
      
      public static function getValideSmartFoxJSONText(param1:String) : String
      {
         var _loc2_:RegExp = /%/g;
         var _loc3_:RegExp = /'/g;
         var _loc4_:RegExp = /"/g;
         param1 = param1.replace(_loc2_,SUBST_PERCENT);
         param1 = param1.replace(_loc3_,"");
         return param1.replace(_loc4_,"");
      }
      
      public static function getValideSmartFoxJSONTextMessage(param1:String) : String
      {
         var _loc2_:RegExp = /%/g;
         var _loc3_:RegExp = /'/g;
         var _loc4_:RegExp = /"/g;
         var _loc5_:RegExp = /\r/g;
         var _loc6_:RegExp = /\\/g;
         param1 = param1.replace(_loc2_,SUBST_PERCENT);
         param1 = param1.replace(_loc3_,SUBST_APOSTROPHE);
         param1 = param1.replace(_loc4_,SUBST_QUOTE);
         param1 = param1.replace(_loc5_,SUBST_NEWLINE);
         return param1.replace(_loc6_,"");
      }
      
      public static function parseChatMessage(param1:String) : String
      {
         var _loc2_:RegExp = /&percnt;/g;
         return param1.replace(_loc2_,"%");
      }
      
      public static function parseChatJSONMessage(param1:String) : String
      {
         if(!param1)
         {
            return "";
         }
         var _loc2_:RegExp = /&percnt;/g;
         var _loc3_:RegExp = /&quot;/g;
         var _loc4_:RegExp = /&#145;/g;
         var _loc5_:RegExp = /<br \/>/g;
         return param1.replace(_loc2_,"%").replace(_loc3_,"\"").replace(_loc4_,"\'").replace(_loc5_,"\r");
      }
      
      public static function isEmailString(param1:String) : Boolean
      {
         var _loc2_:RegExp = /([A-Za-z0-9._-]+)@([A-Za-z0-9.-]+)\.([a-z]{2,4})/;
         return _loc2_.test(param1);
      }
      
      public static function trimPassword(param1:String) : String
      {
         return StringUtil.ltrim(StringUtil.rtrim(param1));
      }
   }
}
