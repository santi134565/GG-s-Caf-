package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class BGACommand extends CafeCommand
   {
       
      
      public function BGACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_BUDDY_AVATARS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.buddyList.addIngameBuddyAvatarInfo(param2);
            if(env.hasNetworkBuddies)
            {
               CafeModel.buddyList.getSocialBuddyData();
            }
            return true;
         }
         return false;
      }
   }
}
