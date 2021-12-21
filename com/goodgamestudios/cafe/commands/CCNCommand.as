package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   
   public class CCNCommand extends CafeCommand
   {
       
      
      public function CCNCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_CLEAN;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0 && param2[3] == 1)
         {
            CafeModel.userData.checkMoneyChanges(-CafeConstants.cleanCostCash);
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_clean_copy")));
         }
         cafeIsoWorld.doAction(CafeIsoWorld.ACTION_CLEAN,param2);
         return true;
      }
   }
}
