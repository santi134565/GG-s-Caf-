package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicInviteFriendCommand extends SimpleCommand
   {
       
      
      public function BasicInviteFriendCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Array = param1 as Array;
         if(!_loc2_ || _loc2_.length != 3)
         {
            return;
         }
         var _loc3_:String = String(_loc2_.shift());
         var _loc4_:String = String(_loc2_.shift());
         var _loc5_:String = String(_loc2_.shift());
         BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_INVITE_FRIEND,[_loc3_,_loc4_,_loc5_]);
      }
   }
}
