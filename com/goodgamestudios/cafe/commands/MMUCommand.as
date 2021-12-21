package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeMinigameEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class MMUCommand extends CafeCommand
   {
       
      
      public function MMUCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_MINI_MUFFIN;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         param2.shift();
         if(param1 == 0)
         {
            controller.dispatchEvent(new CafeMinigameEvent(CafeMinigameEvent.MUFFIN_GAMERESULTS,param2));
            return true;
         }
         if(param1 == 9)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties("",CafeModel.languageData.getTextById("dialogwin_muffinman_nopayment")));
         }
         return false;
      }
   }
}
