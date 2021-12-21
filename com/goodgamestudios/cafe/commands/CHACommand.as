package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   
   public class CHACommand extends CafeCommand
   {
       
      
      public function CHACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CHANGE_AVATAR;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == 0 && param2.length > 1)
         {
            _loc3_ = param2[2];
            if(CafeModel.userData.playerID == _loc3_ || layoutManager.outGameState)
            {
               CafeModel.userData.changeUserMoney(0,-CafeModel.userData.changAvatarPrice);
               CafeModel.userData.changeAvatarParts(param2[1],layoutManager.inGameState);
            }
            else
            {
               layoutManager.isoScreen.isoWorld.spawnOtherPlayer(CafeModel.otherUserData.changeAvatarParts(param2[1],_loc3_));
            }
         }
         else if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_avatarchange")));
         }
         return super.executeCommand(param1,param2);
      }
   }
}
