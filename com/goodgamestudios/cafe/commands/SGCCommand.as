package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeWheelOfFortuneReminderDialog;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.math.Random;
   
   public class SGCCommand extends CafeCommand
   {
       
      
      public function SGCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.userData.heroVO.isoX = param2[2];
            CafeModel.userData.heroVO.isoY = param2[3];
            CafeModel.npcData.resetNpcArray();
            CafeModel.npcStaffData.resetStaff();
            CafeModel.levelData.buildNewLevel(param2);
            layoutManager.isoScreen.buildWorld();
            switch(CafeModel.levelData.levelVO.worldType)
            {
               case CafeConstants.CAFE_WORLD_TYPE_MYCAFE:
                  CafeModel.userData.resetWorkTime();
                  layoutManager.state = CafeLayoutManager.STATE_MY_CAFE;
                  CafeModel.coopData.getActiveCoopFromServer();
                  if(CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_WHEELOFFORTUNE)
                  {
                     layoutManager.showDialogAfterTime(CafeWheelOfFortuneReminderDialog.NAME,Random.integer(1,45) * 60000);
                  }
                  break;
               case CafeConstants.CAFE_WORLD_TYPE_MARKETPLACE:
                  CafeModel.userData.resetWorkTime();
                  layoutManager.state = CafeLayoutManager.STATE_MARKETPLACE;
                  if(CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_WHEELOFFORTUNE)
                  {
                     layoutManager.showDialogAfterTime(CafeWheelOfFortuneReminderDialog.NAME,Random.integer(1,45) * 60000);
                  }
                  break;
               case CafeConstants.CAFE_WORLD_TYPE_OTHERPLAYERCAFE:
                  layoutManager.state = CafeLayoutManager.STATE_OTHER_CAFE;
            }
            cafeIsoWorld.spawnPlayer(VisualVO(CafeModel.userData.heroVO));
            CafeSoundController.getInstance().playMusic(CafeSoundController.MUSIC_LOOP1,int.MAX_VALUE,true);
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("level_error"),CafeModel.languageData.getTextById("level_errorcode_" + param1),this.onLogout,CafeModel.languageData.getTextById("logout")));
         return false;
      }
      
      public function onLogout() : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN);
      }
   }
}
