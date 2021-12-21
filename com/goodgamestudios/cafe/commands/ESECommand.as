package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.event.CafeEditorEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   
   public class ESECommand extends CafeCommand
   {
       
      
      public function ESECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EDITOR_SELL_OBJECT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ShopVO = null;
         if(param1 == 0)
         {
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_BUYSELL);
            _loc3_ = param2[3];
            _loc4_ = param2[4];
            _loc5_ = CafeModel.wodData.createVObyWOD(_loc3_) as ShopVO;
            CafeModel.userData.checkMoneyChanges(_loc4_ * _loc5_.calculateSaleValueCash(),_loc4_ * _loc5_.calculateSaleValueGold());
            if(param2[1] == -1 && param2[2] == -1)
            {
               CafeModel.inventoryFurniture.removeItem(_loc3_,_loc4_);
            }
            else if(_loc5_.group == CafeConstants.GROUP_FRIDGE)
            {
               CafeModel.inventoryFridge.removeCapacity(_loc4_ * (_loc5_ as BasicFridgeVO).inventroySize);
            }
            CafeModel.levelData.checkLevelLuxury(cafeIsoWorld.getIsoObjectLuxury());
            controller.dispatchEvent(new CafeEditorEvent(CafeEditorEvent.SELL_ITEM));
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("edit_error"),CafeModel.languageData.getTextById("editsell_errorcode_" + param1)));
         return false;
      }
   }
}
