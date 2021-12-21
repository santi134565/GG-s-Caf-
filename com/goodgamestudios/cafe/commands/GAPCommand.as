package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class GAPCommand extends CafeCommand
   {
       
      
      public function GAPCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_GIFT_ALLREADYSEND_PLAYERS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.giftList.parseAllreadySendPlayerIds(param2);
            return true;
         }
         return false;
      }
   }
}
