package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class ABRCommand extends CafeCommand
   {
       
      
      public function ABRCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_ALLOW_BUDDY_REQUESTS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.otherUserData.setAllowBuddyByUserId(param2.shift(),param2.shift());
            return true;
         }
         return false;
      }
   }
}
