package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeShowBonusDialogCommand;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeBonusDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.currency.GoldCurrencyVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.isocore.vo.VisualVO;
   
   public class LCBCommand extends CafeCommand
   {
       
      
      public function LCBCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_COMEBACK_BONUS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:VisualVO = null;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = param2.shift().split("#");
            _loc4_ = new Array();
            while(_loc3_.length > 0 && _loc3_[0] != "")
            {
               _loc5_ = _loc3_.shift().split("+");
               if((_loc6_ = CafeModel.wodData.createVObyWOD(_loc5_[0])) is GoldCurrencyVO)
               {
                  (_loc6_ as GoldCurrencyVO).amount = _loc5_[1];
                  _loc4_.push(_loc6_);
                  CafeModel.userData.changeUserMoney(0,_loc5_[1]);
               }
               else if(_loc6_ is BasicIngredientVO)
               {
                  (_loc6_ as BasicIngredientVO).inventoryAmount = _loc5_[1];
                  CafeModel.inventoryFridge.addItem(_loc6_.wodId,_loc5_[1]);
                  _loc4_.push(_loc6_);
               }
            }
            if(_loc4_.length > 0)
            {
               controller.dispatchEvent(new CafeUserEvent(CafeUserEvent.BONUS,[CafeBonusDialogProperties.TYPE_COMEBACK_BONUS,_loc4_]));
               CommandController.instance.executeCommand(CafeShowBonusDialogCommand.COMMAND_NAME,[CafeBonusDialogProperties.TYPE_COMEBACK_BONUS,_loc4_]);
            }
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("dialogwin_noreward_title"),CafeModel.languageData.getTextById("dialogwin_noreward_copy")));
         return false;
      }
   }
}
