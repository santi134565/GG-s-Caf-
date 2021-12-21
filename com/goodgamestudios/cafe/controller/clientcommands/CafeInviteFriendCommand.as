package com.goodgamestudios.cafe.controller.clientcommands
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class CafeInviteFriendCommand extends SimpleCommand
   {
      
      public static const COMMAND_NAME:String = "CafeInviteFriendCommand";
       
      
      public function CafeInviteFriendCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(!param1 || param1.length != 3)
         {
            return;
         }
         var _loc2_:String = String(param1.shift());
         var _loc3_:String = String(param1.shift());
         var _loc4_:String = String(param1.shift());
         var _loc5_:RegExp = /%/g;
         _loc3_ = _loc3_.replace(_loc5_,"");
         BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_INVITE_FRIEND,[_loc2_,_loc3_,_loc4_]);
      }
   }
}
