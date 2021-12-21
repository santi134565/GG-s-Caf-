package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class COFCommand extends CafeCommand
   {
       
      
      public function COFCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_COOP_FINISH;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         CafeModel.coopData.setActiveCoopFinishLevel(param2.shift());
         return true;
      }
   }
}
