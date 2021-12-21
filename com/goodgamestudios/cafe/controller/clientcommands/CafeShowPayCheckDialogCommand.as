package com.goodgamestudios.cafe.controller.clientcommands
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeJobPaycheckDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeJobPaycheckDialogProperties;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class CafeShowPayCheckDialogCommand extends SimpleCommand
   {
      
      public static const COMMAND_NAME:String = "CafeShowPayCheckDialogCommand";
       
      
      public function CafeShowPayCheckDialogCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         CafeLayoutManager.getInstance().showDialog(CafeJobPaycheckDialog.NAME,new CafeJobPaycheckDialogProperties(CafeModel.languageData.getTextById("dialogwin_jobpaycheck_title"),CafeModel.languageData.getTextById("dialogwin_jobpaycheck_copy"),param1 as Array,CafeModel.languageData.getTextById("btn_text_okay")));
      }
   }
}
