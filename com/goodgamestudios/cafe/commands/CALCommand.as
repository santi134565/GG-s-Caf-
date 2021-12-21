package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class CALCommand extends CafeCommand
   {
       
      
      public function CALCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_ACHIEVEMENT_LIST;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            param2.shift();
            param2.shift();
            CafeModel.achievementData.parseAchievementList(param2);
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("achievement_error"),CafeModel.languageData.getTextById("achievement_errorcode_" + param1)));
         return false;
      }
   }
}
