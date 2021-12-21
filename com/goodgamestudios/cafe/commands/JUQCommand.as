package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class JUQCommand extends CafeCommand
   {
       
      
      public function JUQCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_JOIN_USERQUIT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = int(param2.shift());
            CafeModel.otherUserData.removeUser(_loc3_);
            if(cafeIsoWorld)
            {
               cafeIsoWorld.removeOtherPlayer(_loc3_);
            }
            return true;
         }
         return false;
      }
   }
}
