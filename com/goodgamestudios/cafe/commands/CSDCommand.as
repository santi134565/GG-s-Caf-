package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.moving.OtherplayerMoving;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   
   public class CSDCommand extends CafeCommand
   {
       
      
      public function CSDCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_STOVE_DELIVER;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 != SFConstants.ERROR_OK)
         {
            return false;
         }
         var _loc3_:int = param2[5];
         var _loc4_:OtherplayerMoving = cafeIsoWorld.map.getOtherPlayerByUserId(_loc3_) as OtherplayerMoving;
         var _loc5_:BasicStove = cafeIsoWorld.getLevelObjectByXY(param2[1],param2[2]) as BasicStove;
         var _loc6_:BasicCounter = cafeIsoWorld.getLevelObjectByXY(param2[3],param2[4]) as BasicCounter;
         if(CafeModel.levelData.isOwnerByUserId(CafeModel.userData.userID))
         {
            CafeModel.masteryData.increaseMastery(_loc5_.currentDish.wodId);
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_XPGAIN);
            cafeIsoWorld.doAction(CafeIsoWorld.ACTION_STOVE_DELIVER,param2);
         }
         else if(_loc4_ && _loc6_ && _loc5_)
         {
            if(_loc4_.currentDish)
            {
               _loc6_.addDish(_loc4_.currentDish.wodId,-1,_loc5_.stoveVO.cookedWithFancyIngredient);
            }
            else if(_loc5_.currentDish)
            {
               _loc6_.addDish(_loc5_.currentDish.wodId,-1,_loc5_.stoveVO.cookedWithFancyIngredient);
               _loc5_.setDirtLayer();
            }
            _loc4_.removeDish();
         }
         return true;
      }
   }
}
