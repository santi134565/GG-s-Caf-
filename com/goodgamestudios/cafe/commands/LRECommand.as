package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarCreationDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAvatarCreationDialogProperties;
   import com.goodgamestudios.cafe.view.panels.CafeRegisterPanel;
   
   public class LRECommand extends CafeCommand
   {
       
      
      public function LRECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_REGISTER;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               layoutManager.hidePanel(CafeRegisterPanel.NAME);
               controller.dispatchEvent(new BasicUserEvent(BasicUserEvent.REGISTERED));
               return true;
            case 16:
               layoutManager.showDialog(CafeAvatarCreationDialog.NAME,new CafeAvatarCreationDialogProperties());
               controller.dispatchEvent(new BasicUserEvent(BasicUserEvent.REGISTERED));
               layoutManager.hidePanel(CafeRegisterPanel.NAME);
               break;
            default:
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.REGISTER_ERROR,[param1,param2]));
         }
         return false;
      }
   }
}
