package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.utils.ExternalInterfaceUtils;
   
   public class VCKCommand extends CafeCommand
   {
       
      
      public function VCKCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_VERSION_CHECK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            env.buildNumberServer = int(param2[1]);
            layoutManager.showServerAndClientVersion();
            if(env.pln != "" && env.sig != "")
            {
               CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN);
            }
            else
            {
               layoutManager.onEndProgressbar();
               if(!CafeModel.smartfoxClient.userForcedDisconnect && CafeModel.localData.readLoginDataUsername() != null && CafeModel.localData.readLoginDataUsername() != "" && CafeModel.localData.readLoginDataPass() != null && CafeModel.localData.readLoginDataPass() != "")
               {
                  CafeModel.smartfoxClient.userForcedDisconnect = false;
                  CafeModel.userData.loginName = CafeModel.localData.readLoginDataUsername();
                  CafeModel.userData.loginPwd = CafeModel.localData.readLoginDataPass();
                  CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN);
               }
               else
               {
                  layoutManager.state = BasicLayoutManager.STATE_LOGIN;
               }
            }
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("versioncheck_error"),CafeModel.languageData.getTextById("versioncheck_errorcode_" + param1),ExternalInterfaceUtils.reloadPage));
         }
         return param1 == 0;
      }
   }
}
