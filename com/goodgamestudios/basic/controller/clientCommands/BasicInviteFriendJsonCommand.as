package com.goodgamestudios.basic.controller.clientCommands
{
   import com.adobe.serialization.json.JSON;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicInviteFriendJsonCommand extends SimpleCommand
   {
       
      
      public function BasicInviteFriendJsonCommand()
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
         var _loc3_:Object = {
            "myname":String(_loc2_.shift()),
            "name":String(_loc2_.shift()),
            "mail":String(_loc2_.shift())
         };
         BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_INVITE_FRIEND,[com.adobe.serialization.json.JSON.encode(_loc3_)]);
      }
   }
}
