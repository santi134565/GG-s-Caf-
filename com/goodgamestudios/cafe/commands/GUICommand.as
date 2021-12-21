package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.event.BasicAssetsEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.events.Event;
   
   public class GUICommand extends CafeCommand
   {
       
      
      public function GUICommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_USER_INFO;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         param2.shift();
         if(param1 == 0)
         {
            CafeModel.userData.parseUserData(param2);
            if(CafeModel.assetData.isComplete)
            {
               this.joinMyCafe();
            }
            else
            {
               layoutManager.state = BasicLayoutManager.STATE_LOAD_ITEMS;
               BasicModel.assetData.addEventListener(BasicAssetsEvent.ASSETS_COMPLETE,this.joinMyCafe);
            }
            return true;
         }
         return false;
      }
      
      private function joinMyCafe(param1:Event = null) : void
      {
         BasicModel.assetData.removeEventListener(BasicAssetsEvent.ASSETS_COMPLETE,this.joinMyCafe);
         CafeModel.smartfoxClient.sendMessage(SFConstants.S2C_JOIN_CAFE,[CafeModel.userData.userID,CafeModel.userData.playerID]);
      }
   }
}
