package com.goodgamestudios.graphics.utils
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class MovieClipHelper
   {
       
      
      public function MovieClipHelper()
      {
         super();
      }
      
      public static function stopAllMovies(param1:DisplayObjectContainer) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_)
         {
            _loc2_.stop();
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            stopAllMovies(param1.getChildAt(_loc3_) as DisplayObjectContainer);
            _loc3_++;
         }
      }
      
      public static function stopAllMoviesGotoFrameOne(param1:DisplayObjectContainer) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_)
         {
            _loc2_.gotoAndStop(1);
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            stopAllMoviesGotoFrameOne(param1.getChildAt(_loc3_) as DisplayObjectContainer);
            _loc3_++;
         }
      }
      
      public static function playAllMovies(param1:DisplayObjectContainer) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_ && _loc2_.totalFrames > 1)
         {
            _loc2_.play();
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            MovieClipHelper.playAllMovies(param1.getChildAt(_loc3_) as DisplayObjectContainer);
            _loc3_++;
         }
      }
      
      public static function clearMovieClip(param1:DisplayObjectContainer) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
   }
}
