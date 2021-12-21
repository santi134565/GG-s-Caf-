package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class STECommand extends CafeCommand
   {
       
      
      public function STECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SOCIAL_TRIGGEREVENT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = param2.shift();
            _loc4_ = param2.shift();
            _loc5_ = String(param2.shift()).split("#");
            CafeModel.userData.socialLoginBonus(_loc5_,_loc3_,_loc4_);
            return true;
         }
         return false;
      }
   }
}
