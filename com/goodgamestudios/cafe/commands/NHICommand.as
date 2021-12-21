package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeShowBonusDialogCommand;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeBonusDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.commanding.CommandController;
   
   public class NHICommand extends CafeCommand
   {
       
      
      public function NHICommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_NPC_HIRE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:String = null;
         if(param1 == 0)
         {
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_WAITERHIRE);
            _loc3_ = param2[2];
            CafeModel.userData.checkMoneyChanges(0,-CafeConstants.staffPrice);
            if(env.enableFeedMessages)
            {
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.BONUS,[CafeBonusDialogProperties.TYPE_WAITER,_loc3_]));
               CommandController.instance.executeCommand(CafeShowBonusDialogCommand.COMMAND_NAME,[CafeBonusDialogProperties.TYPE_WAITER,_loc3_]);
            }
            return true;
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_npchire")));
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("npc_error"),CafeModel.languageData.getTextById("npchire_errorcode_" + param1)));
         }
         return false;
      }
   }
}
