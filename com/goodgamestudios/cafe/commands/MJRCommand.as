package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class MJRCommand extends CafeCommand
   {
       
      
      public function MJRCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_MARKETPLACE_JOBREFILL;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.userData.refillJobs();
            return true;
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_copy")));
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("jobrefill_error"),CafeModel.languageData.getTextById("jobrefill_errorcode_" + param1)));
         }
         return false;
      }
   }
}
