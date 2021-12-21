package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeSocialData;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class COSCommand extends CafeCommand
   {
       
      
      public function COSCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_COOP_START;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:String = null;
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.coopData.parseCoopDetail(param2);
            if(env.enableFeedMessages)
            {
               _loc3_ = CafeModel.languageData.getTextById("coop_title_" + CafeModel.coopData.activeCoop.type);
               CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_COOPSTART,[_loc3_]);
            }
            return true;
         }
         if(param1 == 87)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_information"),CafeModel.languageData.getTextById("dialogwin_coop_maxdone")));
         }
         else
         {
            param2.shift();
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("generic_alert_information"),CafeModel.languageData.getTextById("coop_errorcode_" + param1)));
         }
         return false;
      }
   }
}
