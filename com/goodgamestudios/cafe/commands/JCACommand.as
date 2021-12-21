package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class JCACommand extends CafeCommand
   {
       
      
      public function JCACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_JOIN_CAFE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 != 0 && param1 != 21)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("joincafe_error"),CafeModel.languageData.getTextById("joincafe_errorcode_" + param1)));
            return false;
         }
         return true;
      }
   }
}
