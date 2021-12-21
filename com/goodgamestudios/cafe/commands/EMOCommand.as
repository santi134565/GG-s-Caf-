package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   
   public class EMOCommand extends CafeCommand
   {
       
      
      public function EMOCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EDITOR_MOVE_OBJECT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         cafeIsoWorld.mouse.unLockDragObject();
         cafeIsoWorld.mouse.iDragObject = null;
         if(param1 == 0)
         {
            cafeIsoWorld.doAction(CafeIsoWorld.ACTION_EDITOR_MOVE,param2);
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("edit_error"),CafeModel.languageData.getTextById("editmoveobj_errorcode_" + param1)));
         return false;
      }
   }
}
