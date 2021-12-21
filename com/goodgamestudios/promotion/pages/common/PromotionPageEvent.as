package com.goodgamestudios.promotion.pages.common
{
   import flash.events.Event;
   
   public class PromotionPageEvent extends Event
   {
      
      public static const PLAY_PROMOTED_GAME:String = "playPromotedGame";
      
      public static const PLAY_ORIGINAL_GAME:String = "playOriginalGame";
       
      
      public var originalGameId:int;
      
      public function PromotionPageEvent(type:String, originalGameId:int = -1, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this.originalGameId = originalGameId;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new PromotionPageEvent(type,originalGameId,bubbles,cancelable);
      }
   }
}
