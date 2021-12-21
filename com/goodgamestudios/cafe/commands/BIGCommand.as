package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeAddFriendDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeAddFriendDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.vo.moving.OtherplayerMovingVO;
   
   public class BIGCommand extends CafeCommand
   {
       
      
      public function BIGCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_BUDDY_INGAME;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         param2.shift();
         var _loc3_:int = parseInt(param2.shift());
         var _loc4_:int = parseInt(param2.shift());
         var _loc5_:int = parseInt(param2.shift());
         var _loc6_:OtherplayerMovingVO = CafeModel.otherUserData.getUserByPlayerId(_loc4_);
         var _loc7_:OtherplayerMovingVO = CafeModel.otherUserData.getUserByPlayerId(_loc5_);
         if(!_loc6_ && _loc3_ != 3)
         {
            return false;
         }
         switch(param1)
         {
            case 0:
               switch(_loc3_)
               {
                  case 0:
                     layoutManager.showDialog(CafeAddFriendDialog.NAME,new CafeAddFriendDialogProperties(CafeModel.languageData.getTextById("alert_addFriend_title"),CafeModel.languageData.getTextById("alert_addFriend_copy",[_loc6_.playerName]),_loc4_,CafeModel.languageData.getTextById("btn_text_accept"),CafeModel.languageData.getTextById("btn_text_notaccept")));
                     break;
                  case 1:
                     CafeModel.buddyList.addBuddy(param2.shift());
                     break;
                  case 2:
                     if(_loc4_ == CafeModel.userData.playerID)
                     {
                        layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_addFriend_denied_title"),CafeModel.languageData.getTextById("alert_addFriend_denied_copy",[_loc7_.playerName])));
                     }
                     break;
                  case 3:
                     if(_loc5_ == CafeModel.userData.playerID)
                     {
                        CafeModel.buddyList.removeBuddy(_loc4_);
                     }
                     else
                     {
                        CafeModel.buddyList.removeBuddy(_loc5_);
                     }
               }
               return true;
            case 11:
            case 70:
         }
         return false;
      }
   }
}
