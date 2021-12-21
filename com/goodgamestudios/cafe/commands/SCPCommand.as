package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   
   public class SCPCommand extends CafeCommand
   {
       
      
      public function SCPCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SHOP_CARRIER_PIGEON;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ShopVO = null;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = param2.shift();
            _loc4_ = param2.shift();
            CafeModel.inventoryFridge.addItem(_loc3_,_loc4_);
            _loc5_ = CafeModel.wodData.voList[_loc3_] as ShopVO;
            CafeModel.userData.checkMoneyChanges(-_loc5_.itemCash * _loc4_,-(_loc5_.itemGold * _loc4_ + CafeConstants.courierPrice));
            return true;
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_courier")));
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("courier_error"),CafeModel.languageData.getTextById("courier_errorcode_" + param1)));
         }
         return false;
      }
   }
}
