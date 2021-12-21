package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.view.dialogs.CafeFeatureDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeFeatureDialogProperties;
   
   public class LFECommand extends CafeCommand
   {
       
      
      public function LFECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_LOGIN_FEATURES;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = param2.shift().split("#");
            while(_loc3_.length > 0 && _loc3_[0] != "")
            {
               layoutManager.showDialog(CafeFeatureDialog.NAME,new CafeFeatureDialogProperties(_loc3_.shift()));
            }
            return true;
         }
         return false;
      }
   }
}
