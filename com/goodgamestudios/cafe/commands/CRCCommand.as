package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   
   public class CRCCommand extends CafeCommand
   {
       
      
      public function CRCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_RECOOK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         cafeIsoWorld.doAction(CafeIsoWorld.ACTION_REFRESHFOOD,param2);
         if(param1 == 0)
         {
            if(CafeModel.levelData.isOwnerByUserId(CafeModel.userData.userID))
            {
               CafeModel.userData.changeUserMoney(0,-CafeConstants.refreshFoodCost);
               CafeModel.userData.resetInstantPopupBlockedTimer();
            }
            return true;
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_instantcook_copy")));
         }
         return false;
      }
   }
}
