package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class SBSCommand extends CafeCommand
   {
       
      
      public function SBSCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SOCIAL_BUDDIES;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.buddyList.addSocialBuddyAvatarInfo(param2);
            return true;
         }
         return false;
      }
   }
}
