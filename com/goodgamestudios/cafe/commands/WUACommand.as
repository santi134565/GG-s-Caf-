package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   
   public class WUACommand extends CafeCommand
   {
       
      
      public function WUACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return "wua";
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 64 || param1 == 65)
         {
            return false;
         }
         if(param1 == 0)
         {
            param2.shift();
            cafeIsoWorld.doAction(CafeIsoWorld.ACTION_JOBUSER_ACTION,param2);
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("useraction_error"),CafeModel.languageData.getTextById("useraction_errorcode_" + param1)));
         }
         return true;
      }
   }
}
