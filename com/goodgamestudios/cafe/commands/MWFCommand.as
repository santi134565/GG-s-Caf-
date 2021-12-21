package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeMinigameEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class MWFCommand extends CafeCommand
   {
       
      
      public function MWFCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_WHEELOFFORTUNE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            controller.dispatchEvent(new CafeMinigameEvent(CafeMinigameEvent.WHEELOFFORTUNE,param2));
            return true;
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_clean_copy")));
            controller.dispatchEvent(new CafeMinigameEvent(CafeMinigameEvent.WHEELOFFORTUNE,[]));
         }
         else if(param1 == 92)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("gift_error"),CafeModel.languageData.getTextById("dialogwin_wheeloffortune_nospace")));
            controller.dispatchEvent(new CafeMinigameEvent(CafeMinigameEvent.WHEELOFFORTUNE,[]));
         }
         return false;
      }
   }
}
