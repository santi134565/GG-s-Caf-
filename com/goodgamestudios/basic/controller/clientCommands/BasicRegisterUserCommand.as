package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.misc.ValueCollection;
   
   public class BasicRegisterUserCommand extends SimpleCommand
   {
       
      
      public function BasicRegisterUserCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:ValueCollection = param1 as ValueCollection;
         var _loc3_:String = _loc2_.currStringValue;
         var _loc4_:String = _loc2_.currStringValue;
         var _loc5_:String = null;
         var _loc6_:String = _loc2_.currStringValue;
         BasicController.getInstance().sendServerMessageAndWait(BasicSmartfoxConstants.C2S_REGISTER,[_loc3_,_loc4_,EnviromentGlobalsHandler.globals.referrer,EnviromentGlobalsHandler.globals.distributorId,BasicModel.smartfoxClient.connectionTime,BasicModel.smartfoxClient.roundTripTime,EnviromentGlobalsHandler.globals.accountId,EnviromentGlobalsHandler.globals.campainVars.partnerId,EnviromentGlobalsHandler.globals.campainVars.creative,EnviromentGlobalsHandler.globals.campainVars.placement,EnviromentGlobalsHandler.globals.campainVars.keyword,EnviromentGlobalsHandler.globals.campainVars.network,EnviromentGlobalsHandler.globals.campainVars.lp,EnviromentGlobalsHandler.globals.campainVars.channelId,EnviromentGlobalsHandler.globals.campainVars.trafficSource],BasicSmartfoxConstants.S2C_REGISTER);
         BasicModel.userData.loginPwd = _loc4_;
      }
   }
}
