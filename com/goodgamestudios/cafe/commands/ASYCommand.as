package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class ASYCommand extends CafeCommand
   {
       
      
      public function ASYCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_ASSETS_SYNCHRONIZE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            CafeModel.userData.changeUserMoney(param2[1] - CafeModel.userData.cash,param2[2] - CafeModel.userData.gold);
            if(param2[3] > 0)
            {
               CafeModel.userData.isPayUser = true;
            }
            return true;
         }
         return false;
      }
   }
}
