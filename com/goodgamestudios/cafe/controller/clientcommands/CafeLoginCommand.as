package com.goodgamestudios.cafe.controller.clientcommands
{
   import com.goodgamestudios.basic.controller.clientCommands.BasicLoginCommand;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class CafeLoginCommand extends BasicLoginCommand
   {
       
      
      public function CafeLoginCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         super.execute(param1);
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_SPECIAL_EVENT,[]);
      }
   }
}
