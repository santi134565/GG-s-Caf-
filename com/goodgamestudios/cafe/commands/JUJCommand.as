package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class JUJCommand extends CafeCommand
   {
       
      
      public function JUJCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_JOIN_USERJOIN;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            cafeIsoWorld.spawnOtherPlayer(CafeModel.otherUserData.addUser(param2.shift(),true));
            return true;
         }
         return false;
      }
   }
}
