package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class BOPCommand extends CafeCommand
   {
       
      
      public function BOPCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_OTHERPLAYER_INFO;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            CafeModel.otherUserData.updateUser(param2.shift());
            return true;
         }
         return false;
      }
   }
}
