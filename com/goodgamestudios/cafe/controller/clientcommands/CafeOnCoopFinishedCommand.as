package com.goodgamestudios.cafe.controller.clientcommands
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeCoopRewardDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeCoopRewardDialogProperties;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class CafeOnCoopFinishedCommand extends SimpleCommand
   {
      
      public static const COMMAND_NAME:String = "CafeOnCoopFinishedCommand";
       
      
      public function CafeOnCoopFinishedCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:int = param1[0];
         var _loc3_:int = param1[1];
         var _loc4_:int = param1[2];
         var _loc5_:int = param1[3];
         CafeLayoutManager.getInstance().showDialog(CafeCoopRewardDialog.NAME,new CafeCoopRewardDialogProperties(param1 as Array,CafeModel.languageData.getTextById("btn_text_okay")));
         CafeModel.userData.changeUserMoney(_loc3_,_loc4_);
         CafeModel.userData.changeUserXp(_loc5_);
      }
   }
}
