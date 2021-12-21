package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class SBICommand extends CafeCommand
   {
       
      
      public function SBICommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SHOP_BUY_ITEM;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == 0)
         {
            param2.shift();
            if(param2.length % 2 == 0)
            {
               while(param2.length > 0)
               {
                  _loc3_ = param2.shift();
                  CafeModel.inventoryFridge.addItem(_loc3_,param2.shift());
                  CafeModel.userData.checkMoneyChanges(-CafeModel.wodData.voList[_loc3_].itemCash,-CafeModel.wodData.voList[_loc3_].itemGold);
               }
            }
            return true;
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_copy")));
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("shopbuy_error"),CafeModel.languageData.getTextById("shopbuy_errorcode_" + param1)));
         }
         return false;
      }
   }
}
