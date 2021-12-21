package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceJobDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeMarketplaceJobDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeMultipleDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   
   public class MJOCommand extends CafeCommand
   {
       
      
      public function MJOCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_MARKETPLACE_JOB;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         param2.shift();
         var _loc3_:int = parseInt(param2.shift());
         var _loc4_:int = parseInt(param2.shift());
         var _loc5_:int = parseInt(param2.shift());
         var _loc6_:OtherplayerMovingVO = CafeModel.otherUserData.getUserByUserId(_loc4_);
         var _loc7_:OtherplayerMovingVO = CafeModel.otherUserData.getUserByUserId(_loc5_);
         switch(param1)
         {
            case 0:
               switch(_loc3_)
               {
                  case 0:
                     if(_loc5_ == CafeModel.userData.userID && _loc6_)
                     {
                        layoutManager.showDialog(CafeMarketplaceJobDialog.NAME,new CafeMarketplaceJobDialogProperties(CafeModel.languageData.getTextById("alert_marketplace_job_title"),CafeModel.languageData.getTextById("alert_marketplace_job_copy",[_loc6_.playerName,CafeModel.userData.getLevelByXp(_loc6_.playerXp)]),_loc4_,CafeModel.languageData.getTextById("btn_text_accept"),CafeModel.languageData.getTextById("btn_text_notaccept")));
                     }
                     break;
                  case 1:
                     if(_loc4_ == CafeModel.userData.userID && _loc7_)
                     {
                        layoutManager.showDialog(CafeMultipleDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_marketplace_jobhired_title"),CafeModel.languageData.getTextById("alert_marketplace_jobhired_copy",[_loc7_.playerName])));
                     }
                     if(_loc5_ == CafeModel.userData.userID)
                     {
                        CafeModel.userData.setWorkTime(CafeConstants.workTimeLeft);
                     }
                     break;
                  case 2:
                     if(_loc4_ == CafeModel.userData.userID && _loc7_)
                     {
                        layoutManager.showDialog(CafeMultipleDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_marketplace_jobcancled_title"),CafeModel.languageData.getTextById("alert_marketplace_jobcancled_copy",[_loc7_.playerName])));
                     }
               }
               break;
            case 11:
               if(_loc5_ == CafeModel.userData.userID)
               {
                  layoutManager.showDialog(CafeMultipleDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_marketplace_playerleaved_title"),CafeModel.languageData.getTextById("alert_marketplace_playerleaved_copy")));
               }
               break;
            case 61:
               if(_loc4_ == CafeModel.userData.userID && _loc7_)
               {
                  layoutManager.showDialog(CafeMultipleDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_marketplace_playerjobempty_title"),CafeModel.languageData.getTextById("alert_marketplace_playerjobempty_copy",[_loc7_.playerName])));
               }
               break;
            default:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("marketplace_error"),CafeModel.languageData.getTextById("marketplace_errorcode_" + param1)));
         }
         return false;
      }
   }
}
