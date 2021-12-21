package com.goodgamestudios.cafe.world.objects.deco
{
   public class AdventDeco extends BasicDeco
   {
       
      
      public function AdventDeco()
      {
         super();
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         var _loc1_:int = 4;
         var _loc2_:Date = new Date();
         _loc2_.time = new Date().time;
         var _loc3_:Date = new Date(_loc2_.fullYear,11,24);
         var _loc4_:Date = new Date(_loc2_.fullYear,11,24 - _loc3_.day);
         if(_loc2_.time < _loc4_.time)
         {
            _loc1_--;
         }
         var _loc5_:Date = new Date(_loc2_.fullYear,11,17 - _loc3_.day);
         if(_loc2_.time < _loc5_.time)
         {
            _loc1_--;
         }
         var _loc6_:Date = new Date(_loc2_.fullYear,11,10 - _loc3_.day);
         if(_loc2_.time < _loc6_.time)
         {
            _loc1_--;
         }
         var _loc7_:Date = new Date(_loc2_.fullYear,11,3 - _loc3_.day);
         if(_loc2_.time < _loc7_.time)
         {
            _loc1_--;
         }
         var _loc8_:int = 1;
         while(_loc8_ <= 4)
         {
            if(objectdisp.hasOwnProperty("light" + _loc8_))
            {
               objectdisp["light" + _loc8_].visible = _loc8_ <= _loc1_;
            }
            _loc8_++;
         }
      }
   }
}
