package com.goodgamestudios.cafe.world.vo.coop
{
   public class CoopRequirementVO
   {
       
      
      public var dishWodId:int;
      
      public var amountRequired:int;
      
      public var amountDone:int = 0;
      
      public function CoopRequirementVO(param1:int, param2:int)
      {
         super();
         this.dishWodId = param1;
         this.amountRequired = param2;
      }
   }
}
