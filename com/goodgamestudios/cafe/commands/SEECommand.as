package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeTimeFeatureDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeTimeFeatureDialogProperties;
   
   public class SEECommand extends CafeCommand
   {
       
      
      public function SEECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SPECIAL_EVENT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.sessionData.currentEvents = String(param2.shift()).split("#");
            _loc3_ = false;
            if(param2.length > 0)
            {
               _loc4_ = String(param2.shift()).split("#");
               while(_loc4_.length > 0 && _loc4_[0] != "")
               {
                  layoutManager.showDialog(CafeTimeFeatureDialog.NAME,new CafeTimeFeatureDialogProperties(_loc4_.shift()));
                  _loc3_ = true;
               }
            }
            if(!_loc3_)
            {
               for each(_loc5_ in CafeModel.sessionData.currentEvents)
               {
                  if(_loc5_ > 0 && !CafeModel.sessionData.isEventKnown(_loc5_))
                  {
                     layoutManager.showDialog(CafeTimeFeatureDialog.NAME,new CafeTimeFeatureDialogProperties(_loc5_ + "+" + -1));
                     CafeModel.localData.addKnownEvent(_loc5_);
                     return true;
                  }
               }
            }
            return true;
         }
         return false;
      }
   }
}
