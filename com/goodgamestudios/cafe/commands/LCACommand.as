package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicRegisterDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class LCACommand extends CafeCommand
   {
       
      
      public function LCACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CREATE_AVATAR;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               CafeModel.userData.firstLogin = true;
               param2.shift();
               CafeModel.userData.userName = param2.shift();
               if(param2.shift() == 1 || env.campainVars.isValid())
               {
                  layoutManager.clearAllDialogs();
                  layoutManager.showDialog(CafeRegisterDialog.NAME,new BasicRegisterDialogProperties());
               }
               return true;
            case 93:
            case 97:
            case 18:
            case 12:
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.REGISTER_ERROR,[param1,param2]));
               break;
            default:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("createavatar_error"),CafeModel.languageData.getTextById("createavatar_errorcode_" + param1)));
         }
         return false;
      }
   }
}
