package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeTimeFeatureDialogProperties extends BasicDialogProperties
   {
       
      
      public var eventId:int;
      
      public var daysleft:int;
      
      public function CafeTimeFeatureDialogProperties(param1:String)
      {
         var _loc2_:Array = param1.split("+");
         this.eventId = _loc2_.shift();
         this.daysleft = _loc2_.shift();
         super();
      }
   }
}
