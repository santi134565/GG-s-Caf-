package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeChatEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.moving.PlayerMoving;
   import com.goodgamestudios.isocore.objects.IsoMovingObject;
   
   public class CCHCommand extends CafeCommand
   {
       
      
      public function CCHCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_CAFE_CHAT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:IsoMovingObject = null;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = param2.shift();
            _loc4_ = TextValide.parseChatMessage(param2.shift());
            controller.dispatchEvent(new CafeChatEvent(CafeChatEvent.ADD_MSG,_loc3_,_loc4_));
            if(_loc5_ = cafeIsoWorld.map.getOtherPlayerByUserId(_loc3_))
            {
               (_loc5_ as PlayerMoving).speechBubble.newChatMessage(_loc4_);
            }
            else if(_loc3_ == CafeModel.userData.userID)
            {
               cafeIsoWorld.myPlayer.speechBubble.newChatMessage(_loc4_);
            }
            return true;
         }
         controller.dispatchEvent(new CafeChatEvent(CafeChatEvent.ADD_MSG,-100,CafeModel.languageData.getTextById("cafechat_errorcode_" + param1)));
         return false;
      }
   }
}
