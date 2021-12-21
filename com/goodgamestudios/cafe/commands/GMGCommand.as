package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class GMGCommand extends CafeCommand
   {
       
      
      public function GMGCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_GIFT_PLAYERGIFTS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.giftList.parseMyGifts(param2);
            return true;
         }
         return false;
      }
   }
}
