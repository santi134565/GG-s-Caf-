package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   
   public class EEXCommand extends CafeCommand
   {
       
      
      public function EEXCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EDITOR_EXTEND;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:ShopVO = null;
         if(param1 == 0)
         {
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_EXPAND);
            _loc3_ = CafeModel.wodData.voList[param2[1]];
            if(env.hasNetworkBuddies)
            {
               if(_loc3_.friends <= 0 || _loc3_.friends > CafeModel.buddyList.amountSocialFriends)
               {
                  CafeModel.userData.checkMoneyChanges(0,-Math.max(_loc3_.goldNoFriends,_loc3_.itemGold));
               }
            }
            else
            {
               CafeModel.userData.checkMoneyChanges(-_loc3_.itemCash,-_loc3_.itemGold);
            }
            CafeModel.levelData.resizeMap(_loc3_.wodId,param2[2],param2[3]);
            cafeIsoWorld.levelDataUpdate();
            return true;
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_copy")));
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("edit_error"),CafeModel.languageData.getTextById("editextend_errorcode_" + param1)));
         }
         return false;
      }
   }
}
