package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   
   public class NACCommand extends CafeCommand
   {
       
      
      public function NACCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_NPC_ACTION;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = param2.shift().split("#");
            while(_loc3_.length > 0)
            {
               cafeIsoWorld.doAction(CafeIsoWorld.ACTION_NPC_ACTION,_loc3_.shift().split("+"));
            }
            return true;
         }
         if(param1 == 103)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("dialogwin_smoothiemaker_allserved_copy")));
         }
         return false;
      }
   }
}
