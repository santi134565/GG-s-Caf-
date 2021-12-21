package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class JULCommand extends CafeCommand
   {
       
      
      public function JULCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_JOIN_USERLIST;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.otherUserData.resetOtherUser();
            while(param2.length > 0 && param2[0] != "")
            {
               cafeIsoWorld.spawnOtherPlayer(CafeModel.otherUserData.addUser(param2.shift()));
            }
            return true;
         }
         return false;
      }
   }
}
