package com.goodgamestudios.basic.controller
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.event.BasicSoundEvent;
   import com.goodgamestudios.math.MathBase;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class BasicSoundController extends EventDispatcher
   {
      
      private static var BUFFER_SONG_LEGTH:Number = 0.4;
       
      
      private var _globalSoundTransform:SoundTransform;
      
      protected var _effectsTransform:SoundTransform;
      
      private var _musicTransform:SoundTransform;
      
      private var _isMuted:Boolean = false;
      
      private var _isEffectsMuted:Boolean = false;
      
      private var _isMusicMuted:Boolean = false;
      
      private var _globalSavedVolume:Number = 1;
      
      private var _musicSavedVolume:Number = 1;
      
      private var _effectsSavedVolume:Number = 1;
      
      private var _currentSongChannel:SoundChannel;
      
      private var _currentSong:Sound;
      
      private var _currentSongString:String;
      
      private var _currentSongLoops:int;
      
      private var _loadedSongs:Dictionary;
      
      private var _playingSoundEffects:Array;
      
      public function BasicSoundController()
      {
         this._globalSoundTransform = new SoundTransform();
         this._effectsTransform = new SoundTransform();
         this._musicTransform = new SoundTransform();
         super();
      }
      
      public function initialize() : void
      {
         this._loadedSongs = new Dictionary();
         this._playingSoundEffects = [];
      }
      
      public function playSoundEffectByName(param1:String, param2:int = 1) : SoundChannel
      {
         var itemClass:Class = null;
         var sound:Sound = null;
         var soundChannel:SoundChannel = null;
         var nameString:String = param1;
         var loops:int = param2;
         if(this.isEffectsMuted)
         {
            return null;
         }
         try
         {
            itemClass = getDefinitionByName(nameString) as Class;
            sound = new itemClass();
            soundChannel = sound.play(0,loops,this._effectsTransform);
         }
         catch(e:Error)
         {
            return null;
         }
         return soundChannel;
      }
      
      public function playSoundEffect(param1:Sound, param2:int = 1) : SoundChannel
      {
         if(this.isEffectsMuted)
         {
            return null;
         }
         return param1.play(0,param2,this._effectsTransform);
      }
      
      public function playLoopedSoundEffect(param1:Sound, param2:int = 1) : SoundChannel
      {
         if(this.isEffectsMuted)
         {
            return null;
         }
         var _loc3_:SoundChannel = param1.play(0,int.MAX_VALUE,this._effectsTransform);
         this._playingSoundEffects.push(_loc3_);
         return _loc3_;
      }
      
      public function stopAllLoopedSoundEffects() : void
      {
         var _loc2_:SoundChannel = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._playingSoundEffects.length)
         {
            _loc2_ = this._playingSoundEffects[_loc1_];
            _loc2_.stop();
            _loc2_ = null;
            _loc1_++;
         }
         this._playingSoundEffects = [];
      }
      
      public function stopLoopedSoundEffect(param1:SoundChannel) : void
      {
         var _loc3_:SoundChannel = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._playingSoundEffects.length)
         {
            _loc3_ = this._playingSoundEffects[_loc2_];
            if(_loc3_ == param1)
            {
               _loc3_.stop();
               this._playingSoundEffects.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function playMusic(param1:String, param2:int = 1, param3:Boolean = false) : void
      {
         var _loc4_:Sound = null;
         if(this._currentSongString == param1 && !param3)
         {
            return;
         }
         this._currentSongString = param1;
         this._currentSongLoops = param2;
         if(this._loadedSongs[param1])
         {
            dispatchEvent(new BasicSoundEvent(BasicSoundEvent.SONG_BUFFERED_COMPLETE));
            if((_loc4_ = this._loadedSongs[param1] as Sound).bytesLoaded == _loc4_.bytesTotal)
            {
               this.playSong(_loc4_,param2);
            }
         }
         else
         {
            this._loadedSongs[param1] = this.loadMusicFile(this.getSoundUrl(param1));
         }
      }
      
      public function stopMusic() : void
      {
         if(this._currentSongChannel != null)
         {
            this._currentSongChannel.stop();
            this._currentSongChannel.removeEventListener(Event.SOUND_COMPLETE,this.onCurrentSongReachedEnd);
         }
      }
      
      public function stopAllSounds() : void
      {
         this.stopAllLoopedSoundEffects();
         this.stopMusic();
      }
      
      public function preLoadMusic(param1:String) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:Sound = null;
         if(!this._loadedSongs[param1])
         {
            _loc2_ = new URLRequest(this.getSoundUrl(param1));
            _loc3_ = new Sound(_loc2_);
            _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onStreamError);
         }
      }
      
      protected function onStreamError(param1:IOErrorEvent) : void
      {
         throw new Error("Fehler beim Streamen der Sounddatei! \n\n" + (param1.target as Sound).url + "\n\n" + param1.text);
      }
      
      protected function playSong(param1:Sound, param2:int = 1) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this._currentSongChannel != null)
         {
            this._currentSongChannel.stop();
         }
         this._currentSongChannel = param1.play(0,param2,this._musicTransform);
         if(this._currentSongChannel != null)
         {
            this._currentSongChannel.addEventListener(Event.SOUND_COMPLETE,this.onCurrentSongReachedEnd);
            this._currentSong = param1;
         }
      }
      
      private function getSoundUrl(param1:String) : String
      {
         return this.env.baseURL + "/sound/" + param1;
      }
      
      private function onCurrentSongReachedEnd(param1:Event) : void
      {
         dispatchEvent(new BasicSoundEvent(BasicSoundEvent.SONG_PLAYED_COMPLETE));
      }
      
      private function loadMusicFile(param1:String) : Sound
      {
         var _loc2_:Sound = new Sound(new URLRequest(param1));
         _loc2_.addEventListener(Event.COMPLETE,this.onMusicFileLoadComplete);
         _loc2_.addEventListener(ProgressEvent.PROGRESS,this.onMusicFileLoadProgress);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onMusicFileLoadError);
         return _loc2_;
      }
      
      private function onMusicFileLoadError(param1:IOErrorEvent) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onMusicFileLoadComplete);
         param1.target.removeEventListener(ProgressEvent.PROGRESS,this.onMusicFileLoadProgress);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onMusicFileLoadError);
      }
      
      private function onMusicFileLoadComplete(param1:Event) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onMusicFileLoadComplete);
         param1.target.removeEventListener(ProgressEvent.PROGRESS,this.onMusicFileLoadProgress);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onMusicFileLoadError);
         dispatchEvent(new BasicSoundEvent(BasicSoundEvent.SONG_BUFFERED_COMPLETE));
      }
      
      private function onMusicFileLoadProgress(param1:Event) : void
      {
         var _loc2_:Sound = param1.target as Sound;
         if(_loc2_.bytesLoaded > _loc2_.bytesTotal * BUFFER_SONG_LEGTH)
         {
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onMusicFileLoadError);
            _loc2_.removeEventListener(ProgressEvent.PROGRESS,this.onMusicFileLoadProgress);
            dispatchEvent(new BasicSoundEvent(BasicSoundEvent.SONG_BUFFERED_ENOUGH));
            this.playSong(param1.target as Sound,this._currentSongLoops);
         }
      }
      
      public function toggleMute() : void
      {
         if(!this._isMuted)
         {
            this.muteAll();
         }
         else
         {
            this.unMuteAll();
         }
      }
      
      public function toggleMuteMusic() : void
      {
         if(!this._isMusicMuted)
         {
            this.muteMusic();
         }
         else
         {
            this.unMuteMusic();
         }
      }
      
      public function toggleMuteEffects() : void
      {
         if(!this._isEffectsMuted)
         {
            this.muteEffects();
         }
         else
         {
            this.unmuteEffects();
         }
      }
      
      public function muteAll() : void
      {
         this._isMuted = true;
         this._globalSavedVolume = this._globalSoundTransform.volume;
         this._globalSoundTransform.volume = 0;
         this.applyGlobalSoundTransform();
      }
      
      public function unMuteAll() : void
      {
         this._isMuted = false;
         this._globalSoundTransform.volume = this._globalSavedVolume;
         this.applyGlobalSoundTransform();
      }
      
      public function muteMusic() : void
      {
         this._isMusicMuted = true;
         this._musicSavedVolume = this._musicTransform.volume;
         this._musicTransform.volume = 0;
         this.applyMusicSoundTransform();
      }
      
      public function unMuteMusic() : void
      {
         this._isMusicMuted = false;
         this._musicTransform.volume = this._musicSavedVolume;
         this.applyMusicSoundTransform();
      }
      
      public function muteEffects() : void
      {
         this._isEffectsMuted = true;
         this._effectsSavedVolume = this._effectsTransform.volume;
         this._effectsTransform.volume = 0;
      }
      
      public function unmuteEffects() : void
      {
         this._isEffectsMuted = false;
         this._effectsTransform.volume = this._effectsSavedVolume;
      }
      
      public function get musicVolume() : Number
      {
         return this._musicTransform.volume;
      }
      
      public function get isEffectsMuted() : Boolean
      {
         return !this._isMuted ? Boolean(this._isEffectsMuted) : Boolean(this._isMuted);
      }
      
      public function get isMusicMuted() : Boolean
      {
         return !this._isMuted ? Boolean(this._isMusicMuted) : Boolean(this._isMuted);
      }
      
      public function get isMuted() : Boolean
      {
         return this._isMuted;
      }
      
      public function setMusicVolume(param1:Number) : void
      {
         if(!this._isMusicMuted)
         {
            this._musicTransform.volume = MathBase.clamp(param1,0,1);
            this.applyMusicSoundTransform();
         }
         else
         {
            this._musicSavedVolume = MathBase.clamp(param1,0,1);
         }
      }
      
      public function setEffectsVolume(param1:Number) : void
      {
         this._effectsTransform.volume = MathBase.clamp(param1,0,1);
      }
      
      public function get musicMaxPeak() : Number
      {
         return Math.max(this._currentSongChannel.leftPeak,this._currentSongChannel.rightPeak);
      }
      
      private function applyGlobalSoundTransform() : void
      {
         SoundMixer.soundTransform = this._globalSoundTransform;
      }
      
      private function applyMusicSoundTransform() : void
      {
         if(this._currentSongChannel != null)
         {
            this._currentSongChannel.soundTransform = this._musicTransform;
         }
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
   }
}
