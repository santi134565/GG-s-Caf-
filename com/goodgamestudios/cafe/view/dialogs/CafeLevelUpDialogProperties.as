package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeLevelUpDialogProperties extends BasicDialogProperties
   {
       
      
      public var frameNr:int = 3;
      
      public var prizes:Array;
      
      public var dishes:Array;
      
      public var functionals:Array;
      
      public function CafeLevelUpDialogProperties(param1:Array, param2:Array, param3:Array)
      {
         super();
         this.prizes = param1;
         this.dishes = param2;
         this.functionals = param3;
         var _loc4_:int = 0;
         if(param1 && param1.length > 0)
         {
            _loc4_++;
         }
         if(param2 && param2.length > 0)
         {
            _loc4_++;
         }
         if(param3 && param3.length > 0)
         {
            _loc4_++;
         }
         this.frameNr = 4 - _loc4_;
      }
   }
}
