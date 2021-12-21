package com.goodgamestudios.logging
{
   import com.jeromedecoster.logging.logmeister.LogMeister;
   import com.jeromedecoster.logging.logmeister.NSLogMeister;
   
   use namespace NSLogMeister;
   
   public function warn(... rest) : void
   {
      LogMeister.warn.apply(this,rest);
   }
}
