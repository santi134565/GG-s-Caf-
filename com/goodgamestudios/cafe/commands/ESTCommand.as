package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeEditorEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   
   public class ESTCommand extends CafeCommand
   {
       
      
      public function ESTCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EDITOR_STORE_OBJECT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:VisualVO = null;
         if(param1 == 0)
         {
            _loc3_ = param2[3];
            cafeIsoWorld.doAction(CafeIsoWorld.ACTION_EDITOR_STORE,param2);
            CafeModel.inventoryFurniture.addItem(_loc3_);
            if((_loc4_ = CafeModel.wodData.createVObyWOD(_loc3_)).group == CafeConstants.GROUP_FRIDGE)
            {
               CafeModel.inventoryFridge.removeCapacity((_loc4_ as BasicFridgeVO).inventroySize);
            }
            controller.dispatchEvent(new CafeEditorEvent(CafeEditorEvent.STORE_ITEM));
            CafeModel.levelData.checkLevelLuxury(cafeIsoWorld.getIsoObjectLuxury());
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("edit_error"),CafeModel.languageData.getTextById("editstoreobj_errorcode_" + param1)));
         return false;
      }
   }
}
