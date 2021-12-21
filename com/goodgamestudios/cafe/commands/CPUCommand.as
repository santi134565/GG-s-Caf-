package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeChatEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   
   public class CPUCommand extends CafeCommand
   {
       
      
      public function CPUCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CHAT_PUNISHMENT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc6_:String = null;
         param2.shift();
         var _loc3_:Number = param2.shift();
         var _loc4_:String = TimeStringHelper.getTimeToString(_loc3_ * 60,TimeStringHelper.TWO_TIME_FORMAT,CafeModel.languageData.getTextById);
         var _loc5_:String = param2.shift();
         switch(param1)
         {
            case 1:
               _loc6_ = CafeModel.languageData.getTextById("generic_report_muted_badword2_copy",[_loc4_,_loc5_]);
               break;
            case 2:
               if(_loc3_ == 0)
               {
                  _loc6_ = CafeModel.languageData.getTextById("generic_report_reported_copy",[_loc5_]);
               }
               else
               {
                  _loc6_ = CafeModel.languageData.getTextById("generic_report_muted_reported_copy",[_loc4_,_loc5_]);
               }
               break;
            case 3:
               _loc6_ = CafeModel.languageData.getTextById("generic_report_muted_badword1_copy",[_loc5_]);
               break;
            case 4:
               _loc6_ = CafeModel.languageData.getTextById("generic_report_muted_domain1");
         }
         controller.dispatchEvent(new CafeChatEvent(CafeChatEvent.ADD_MSG,-100,_loc6_));
         return true;
      }
   }
}
