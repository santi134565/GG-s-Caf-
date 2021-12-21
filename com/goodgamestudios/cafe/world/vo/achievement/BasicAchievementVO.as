package com.goodgamestudios.cafe.world.vo.achievement
{
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.utils.Dictionary;
   
   public class BasicAchievementVO extends VisualVO
   {
       
      
      public var achievementId:int;
      
      public var amount:int;
      
      public var levelDict:Dictionary;
      
      public function BasicAchievementVO()
      {
         super();
         this.levelDict = new Dictionary();
      }
   }
}
