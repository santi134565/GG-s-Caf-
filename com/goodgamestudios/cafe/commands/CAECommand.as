package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeAchievementEarnDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAchievementEarnDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   
   public class CAECommand extends CafeCommand
   {
       
      
      public function CAECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_ACHIEVEMENT_EARN;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:BasicIngredientVO = null;
         if(param1 == 0)
         {
            CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_ACHIEVEMENT);
            param2.shift();
            while(param2.length > 0 && param2[0] != "")
            {
               _loc3_ = param2.shift().split("+");
               _loc4_ = parseInt(_loc3_.shift());
               _loc5_ = parseInt(_loc3_.shift());
               _loc6_ = CafeModel.achievementData.getBonusElementsById(_loc4_,_loc5_ - 1);
               if(_loc3_.length > 0)
               {
                  _loc7_ = _loc3_.shift().split("#");
                  while(_loc7_.length > 0 && _loc7_[0] != "")
                  {
                     _loc8_ = _loc7_.shift().split("$");
                     if(_loc9_ = CafeModel.wodData.createVObyWOD(_loc8_[0]) as BasicIngredientVO)
                     {
                        _loc9_.inventoryAmount = _loc8_[1];
                        CafeModel.inventoryFridge.addItem(_loc9_.wodId,_loc9_.inventoryAmount);
                        _loc6_.push(_loc9_);
                     }
                  }
               }
               layoutManager.showDialog(CafeAchievementEarnDialog.NAME,new CafeAchievementEarnDialogProperties(CafeModel.languageData.getTextById(CafeModel.achievementData.getAchievementName(_loc4_)),CafeModel.languageData.getTextById("dialogwin_bonus_copy_achievement",[_loc5_]),CafeModel.achievementData.getWodIdById(_loc4_),_loc6_,[CafeModel.languageData.getTextById(CafeModel.achievementData.getAchievementName(_loc4_))]));
            }
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("achievement_error"),CafeModel.languageData.getTextById("achievement_errorcode_" + param1)));
         return false;
      }
   }
}
