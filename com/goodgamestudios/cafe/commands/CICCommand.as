package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   
   public class CICCommand extends CafeCommand
   {
       
      
      public function CICCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_INSTANTCOOK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            cafeIsoWorld.doAction(CafeIsoWorld.ACTION_INSTANT_COOK,param2);
            if(CafeModel.levelData.isOwnerByUserId(CafeModel.userData.userID))
            {
               CafeModel.userData.checkMoneyChanges(0,-param2[3]);
               ++CafeModel.userData.instantCookings;
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
