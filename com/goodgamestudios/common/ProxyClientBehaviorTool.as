package com.goodgamestudios.common
{
   public class ProxyClientBehaviorTool
   {
       
      
      public function ProxyClientBehaviorTool()
      {
         super();
      }
      
      public static function getScaleFactor(stageWidth:Number, stageHeight:Number) : Number
      {
         var _loc3_:Number = stageHeight / 600;
         if(_loc3_ * 800 > stageWidth)
         {
            _loc3_ = stageWidth / 800;
         }
         return _loc3_;
      }
   }
}
