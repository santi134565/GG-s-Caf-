package com.goodgamestudios.utils
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ForumUtils
   {
      
      public static const URL_FORUM:String = "http://links.goodgamestudios.com/forum/";
       
      
      public function ForumUtils()
      {
         super();
      }
      
      public static function navigateToForum(param1:String) : void
      {
         var url:String = null;
         var urlRequest:URLRequest = null;
         var hash:String = param1;
         try
         {
            url = URL_FORUM + hash;
            urlRequest = new URLRequest(url);
            navigateToURL(urlRequest,"_blank");
         }
         catch(e:Error)
         {
         }
      }
      
      public static function navigateToSubForumID(param1:String, param2:int) : void
      {
         var url:String = null;
         var urlRequest:URLRequest = null;
         var hash:String = param1;
         var forumID:int = param2;
         try
         {
            url = URL_FORUM + hash + forumID + "/0";
            urlRequest = new URLRequest(url);
            navigateToURL(urlRequest,"_blank");
         }
         catch(e:Error)
         {
         }
      }
      
      public static function navigateToThreadID(param1:String, param2:int) : void
      {
         var url:String = null;
         var urlRequest:URLRequest = null;
         var hash:String = param1;
         var threadID:int = param2;
         try
         {
            url = URL_FORUM + hash + "/0/" + threadID;
            urlRequest = new URLRequest(url);
            navigateToURL(urlRequest,"_blank");
         }
         catch(e:Error)
         {
         }
      }
   }
}
