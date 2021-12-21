package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class NAVCommand extends CafeCommand
   {
       
      
      public function NAVCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_NPC_AVATAR;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:String = null;
         if(param1 == 0)
         {
            param2.shift();
            for each(_loc3_ in param2)
            {
               cafeIsoWorld.spawnNpc(CafeModel.npcData.addNpc(_loc3_));
            }
            return true;
         }
         return false;
      }
   }
}
