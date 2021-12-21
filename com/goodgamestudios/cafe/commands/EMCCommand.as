package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeMailGiftDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMailGiftDialogProperties;
   
   public class EMCCommand extends CafeCommand
   {
       
      
      public function EMCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EMAIL_CONFIRMED;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            layoutManager.showDialog(CafeMailGiftDialog.NAME,new CafeMailGiftDialogProperties(CafeModel.languageData.getTextById("dialogwin_presentreceived_title"),CafeModel.languageData.getTextById("dialogwin_presentreceived_copy",[CafeConstants.emailVerificationGold]),"",CafeMailGiftDialogProperties.TYPE_GET_GIFT));
         }
         return param1 == 0;
      }
   }
}
