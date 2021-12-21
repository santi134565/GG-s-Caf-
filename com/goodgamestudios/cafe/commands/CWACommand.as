package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   
   public class CWACommand extends CafeCommand
   {
       
      
      public function CWACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_WALK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            if(param2[1] == CafeModel.userData.userID)
            {
               cafeIsoWorld.doAction(CafeIsoWorld.ACTION_MOVE_PLAYER,param2);
            }
            else
            {
               param2.shift();
               param2[1] = CafeIsoWorld.ACTION_JOBUSER_MOVE;
               cafeIsoWorld.doAction(CafeIsoWorld.ACTION_JOBUSER_ACTION,param2);
            }
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("cafe_error"),CafeModel.languageData.getTextById("cafewalk_errorcode_" + param1)));
         return false;
      }
   }
}
