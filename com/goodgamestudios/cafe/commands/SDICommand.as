package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   
   public class SDICommand extends CafeCommand
   {
       
      
      public function SDICommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SHOP_DELETE_ITEM;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == 0)
         {
            param2.shift();
            if(param2.length % 2 == 0)
            {
               while(param2.length > 0)
               {
                  _loc3_ = param2.shift();
                  _loc4_ = param2.shift();
                  CafeModel.inventoryFridge.removeItem(_loc3_,_loc4_);
                  CafeModel.userData.checkMoneyChanges(CafeModel.wodData.voList[_loc3_].calculateSaleValueCash() * _loc4_,CafeModel.wodData.voList[_loc3_].calculateSaleValueGold() * _loc4_);
               }
            }
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("shopbuy_error"),CafeModel.languageData.getTextById("shopdelete_errorcode_" + param1)));
         return false;
      }
   }
}
