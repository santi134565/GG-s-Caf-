package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class COACommand extends CafeCommand
   {
       
      
      public function COACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_COOP_ACTIVELIST;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.coopData.parseActiveCoops(param2.shift());
            return true;
         }
         return false;
      }
   }
}
