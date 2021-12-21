package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.components.BasicSharedObject;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   
   public class CafeSharedObject extends BasicSharedObject
   {
       
      
      public function CafeSharedObject()
      {
         super();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      public function readQuality() : int
      {
         if(so.data.quality)
         {
            return so.data.quality as int;
         }
         return 0;
      }
      
      public function saveQuality(param1:int) : void
      {
         so.data.quality = param1;
         writeData();
      }
      
      public function readKnownEvents() : Vector.<int>
      {
         return so.data.knownEvents;
      }
      
      public function addKnownEvent(param1:int) : void
      {
         if(!so.data.knownEvents)
         {
            so.data.knownEvents = new Vector.<int>();
         }
         (so.data.knownEvents as Vector.<int>).push(param1);
      }
   }
}
