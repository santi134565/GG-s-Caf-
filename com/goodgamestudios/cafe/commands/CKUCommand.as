package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class CKUCommand extends CafeCommand
   {
       
      
      public function CKUCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_KICK_USER;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_userkicked_title"),CafeModel.languageData.getTextById("alert_userkicked_copy")));
         return true;
      }
   }
}
