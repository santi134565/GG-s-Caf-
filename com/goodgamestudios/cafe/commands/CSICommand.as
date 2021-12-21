package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.objects.moving.OtherplayerMoving;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   
   public class CSICommand extends CafeCommand
   {
       
      
      public function CSICommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_STOVE_DELIVER_INFO;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc4_:OtherplayerMoving = null;
         var _loc5_:BasicStove = null;
         var _loc3_:int = param2[5];
         if(CafeModel.levelData.isOwnerByUserId(CafeModel.userData.userID))
         {
            cafeIsoWorld.doAction(CafeIsoWorld.ACTION_STOVE_DELIVERINFO,param2);
         }
         else
         {
            _loc4_ = cafeIsoWorld.map.getOtherPlayerByUserId(_loc3_) as OtherplayerMoving;
            _loc5_ = cafeIsoWorld.getLevelObjectByXY(param2[1],param2[2]) as BasicStove;
            if(_loc4_ && _loc5_)
            {
               _loc4_.addDish(_loc5_.currentDish);
               _loc5_.setStatus(BasicStove.STOVE_STATUS_DIRTY);
            }
         }
         return true;
      }
   }
}
