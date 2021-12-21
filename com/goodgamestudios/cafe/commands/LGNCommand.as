package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarCreationDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarCreationDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.constants.CommonGameStates;
   
   public class LGNCommand extends CafeCommand
   {
       
      
      public function LGNCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_LOGIN;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               env.gameState = CommonGameStates.NOT_FIRST_LOGIN;
               layoutManager.onEndProgressbar();
               return true;
            case 10:
            case 11:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("login_error"),CafeModel.languageData.getTextById("login_errorcode_wronglogin")));
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.TRY_LOGIN));
               CafeModel.localData.saveLoginData("","",false);
               layoutManager.onEndProgressbar();
               layoutManager.state = BasicLayoutManager.STATE_LOGIN;
               break;
            case 16:
               layoutManager.showDialog(CafeAvatarCreationDialog.NAME,new CafeAvatarCreationDialogProperties());
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.TRY_LOGIN));
               break;
            case 17:
               CafeModel.userData.firstLogin = true;
               break;
            case 19:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_information"),CafeModel.languageData.getTextById("generic_login_banned")));
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.TRY_LOGIN));
               layoutManager.onEndProgressbar();
               layoutManager.state = BasicLayoutManager.STATE_LOGIN;
               CafeModel.localData.saveLoginData("","",false);
               break;
            default:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("login_error"),CafeModel.languageData.getTextById("login_errorcode_" + param1)));
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.TRY_LOGIN));
               layoutManager.onEndProgressbar();
               layoutManager.state = BasicLayoutManager.STATE_LOGIN;
               CafeModel.localData.saveLoginData("","",false);
         }
         return false;
      }
   }
}
