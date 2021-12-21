package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class CODCommand extends CafeCommand
   {
       
      
      public function CODCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_COOP_DETAIL;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.coopData.parseCoopDetail(param2);
            return true;
         }
         return false;
      }
   }
}
