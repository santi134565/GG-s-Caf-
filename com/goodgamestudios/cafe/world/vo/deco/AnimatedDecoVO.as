package com.goodgamestudios.cafe.world.vo.deco
{
   public class AnimatedDecoVO extends BasicDecoVO
   {
       
      
      public var animationDelay:int = 0;
      
      public var frameRate:int = 12;
      
      public function AnimatedDecoVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
      }
   }
}
