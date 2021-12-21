package com.goodgamestudios.cafe.world.info
{
   import com.goodgamestudios.isocore.VisualElement;
   import flash.text.TextField;
   
   public class ProgressToolTip extends BasicToolTip
   {
      
      private static const MC_NAME:String = "ProgressToolTip";
      
      private static const STD_TEXT_POS:int = -15;
      
      private static const MIN_TEXT_WIDTH:int = 105;
       
      
      public function ProgressToolTip(param1:VisualElement)
      {
         super(param1);
         init(MC_NAME);
      }
      
      public function update(param1:Number) : void
      {
         param1 = Math.min(Math.max(0,param1),100);
         disp.barMc.scaleX = param1 / 100;
      }
      
      public function showProgressTip(param1:String) : void
      {
         var _loc2_:TextField = disp.txt_infStepText as TextField;
         _loc2_.text = param1;
         var _loc3_:Number = _loc2_.textWidth / MIN_TEXT_WIDTH;
         if(_loc3_ > 1)
         {
            disp.bg.scaleX = _loc3_;
            _loc2_.width = _loc2_.textWidth + 5;
            _loc2_.x = STD_TEXT_POS - (_loc2_.textWidth - MIN_TEXT_WIDTH) / 2;
         }
         else
         {
            disp.bg.scaleX = 1;
            _loc2_.x = STD_TEXT_POS;
         }
         show();
      }
   }
}
