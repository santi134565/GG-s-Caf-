package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.world.objects.vendingmachine.BasicVendingmachine;
   import com.goodgamestudios.cafe.world.vo.fastfood.BasicFastfoodVO;
   import flash.geom.Point;
   
   public class FFCCommand extends CafeCommand
   {
       
      
      public function FFCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_FASTFOOD_COOK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:BasicVendingmachine = null;
         var _loc4_:BasicFastfoodVO = null;
         param2.shift();
         if(param1 == 0)
         {
            _loc3_ = cafeIsoWorld.getVendingmachineByPoint(new Point(param2.shift(),param2.shift()));
            _loc4_ = CafeModel.wodData.voList[param2.shift()] as BasicFastfoodVO;
            _loc3_.refillFastfood(_loc4_,_loc4_.baseServings);
            CafeModel.userData.changeUserMoney(-_loc4_.itemCash,-_loc4_.itemGold);
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_copy")));
         }
         return param1 == 0;
      }
   }
}
