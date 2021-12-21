package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.dish.RequirementVO;
   
   public class CCCCommand extends CafeCommand
   {
       
      
      public function CCCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_COOK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:BasicDishVO = null;
         var _loc4_:RequirementVO = null;
         if(param1 == 0)
         {
            if(param2[4] == BasicStove.STOVE_STATE_NEW && CafeModel.levelData.levelVO.ownerUserID == CafeModel.userData.userID)
            {
               _loc3_ = CafeModel.wodData.voList[param2[3]];
               _loc3_.checkFancyRequirements(CafeModel.wodData.voList);
               for each(_loc4_ in _loc3_.requirements)
               {
                  CafeModel.inventoryFridge.removeItem(_loc4_.wodId,_loc4_.amount);
               }
               if(param2[5] == 1)
               {
                  CafeModel.userData.resetFancyPopupBlockedTimer();
                  CafeModel.inventoryFridge.removeItem(_loc3_.fancyRequirement.wodId,_loc3_.fancyRequirement.amount);
               }
            }
         }
         cafeIsoWorld.doAction(CafeIsoWorld.ACTION_STOVE_COOK,param2);
         return true;
      }
   }
}
