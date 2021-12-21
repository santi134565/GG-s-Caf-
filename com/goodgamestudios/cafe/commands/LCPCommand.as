package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class LCPCommand extends CafeCommand
   {
       
      
      public function LCPCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CHANGE_PASSWORD;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("changepassword_error"),CafeModel.languageData.getTextById("changepassword_errorcode_" + param1)));
         if(param1 == 0)
         {
            CafeModel.localData.saveLoginData(CafeModel.userData.loginName,CafeModel.userData.loginPwd,true);
         }
         return true;
      }
   }
}
