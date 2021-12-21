package com.goodgamestudios.cafe
{
   public class CafeBoardConstants
   {
      
      public static const FORUM_POSTFIX:String = "_FORUM";
      
      public static const FAQ_POSTFIX:String = "_FAQ";
      
      private static const DE_FORUM:int = 1;
      
      private static const EN_FORUM:int = 19;
      
      private static const PT_FORUM:int = 34;
      
      private static const TR_FORUM:int = 94;
      
      private static const PL_FORUM:int = 49;
      
      private static const DEFAULT_FORUM:int = 64;
      
      private static const DE_FAQ:int = 7;
      
      private static const EN_FAQ:int = 22;
      
      private static const PT_FAQ:int = 37;
      
      private static const TR_FAQ:int = 97;
      
      private static const PL_FAQ:int = 52;
      
      private static const DEFAULT_FAQ:int = 66;
       
      
      public function CafeBoardConstants()
      {
         super();
      }
      
      public static function boardID(param1:String, param2:String = "_FORUM") : int
      {
         var _loc3_:int = 0;
         switch(param1)
         {
            case "de":
               return param2 == FAQ_POSTFIX ? int(DE_FAQ) : int(DE_FORUM);
            case "en":
               return param2 == FAQ_POSTFIX ? int(EN_FAQ) : int(EN_FORUM);
            case "pt":
               return param2 == FAQ_POSTFIX ? int(PT_FAQ) : int(PT_FORUM);
            case "tr":
               return param2 == FAQ_POSTFIX ? int(TR_FAQ) : int(TR_FORUM);
            default:
               return param2 == FAQ_POSTFIX ? int(DEFAULT_FAQ) : int(DEFAULT_FORUM);
         }
      }
   }
}
