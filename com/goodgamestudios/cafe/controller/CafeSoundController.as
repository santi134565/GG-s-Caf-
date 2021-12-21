package com.goodgamestudios.cafe.controller
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSoundController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.media.Sound;
   
   public class CafeSoundController extends BasicSoundController
   {
      
      private static var soundController:CafeSoundController;
      
      public static var MUSIC_LOOP1:String = "Music_Loop1.mp3";
      
      public static var SND_ACHIEVEMENT:Sound = new snd_achievement();
      
      public static var SND_BUTTON:Sound = new snd_button();
      
      public static var SND_BUYSELL:Sound = new snd_buy_sell();
      
      public static var SND_EXPAND:Sound = new snd_cafe_expand();
      
      public static var SND_FANCYPREPARESTEP:Sound = new snd_fancy_preparestep();
      
      public static var SND_JOBFINISHED:Sound = new snd_job_finish();
      
      public static var SND_LEVELUP:Sound = new snd_levelup();
      
      public static var SND_TIMERLOOP:Sound = new snd_timer_loop();
      
      public static var SND_WAITERHIRE:Sound = new snd_waiter_hire();
      
      public static var SND_XPGAIN:Sound = new snd_xp_gain();
       
      
      public function CafeSoundController()
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         super();
         var _loc1_:Array = CafeModel.localData.readSoundSettings();
         if(_loc1_)
         {
            _loc2_ = _loc1_[0];
            _loc3_ = _loc1_[2];
            if(_loc2_)
            {
               muteMusic();
            }
            if(_loc3_)
            {
               muteEffects();
            }
         }
      }
      
      public static function getInstance() : CafeSoundController
      {
         if(!soundController)
         {
            soundController = new CafeSoundController();
            BasicController.getInstance().soundController = soundController;
         }
         return soundController;
      }
   }
}
