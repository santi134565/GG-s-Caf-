package com.goodgamestudios.cafe.controller.clientcommands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class CafeRegisterUserCommand extends SimpleCommand
   {
       
      
      public function CafeRegisterUserCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         CafeModel.userData.userName = param1.username;
         BasicController.getInstance().sendServerMessageAndWait(BasicSmartfoxConstants.C2S_REGISTER,[param1.username,param1.email,param1.password,param1.agbs,this.env.referrer,this.env.distributorId,BasicModel.smartfoxClient.connectionTime,BasicModel.smartfoxClient.roundTripTime,this.env.accountId,this.env.campainVars.partnerId,this.env.campainVars.creative,this.env.campainVars.placement,this.env.campainVars.keyword,this.env.campainVars.network,this.env.campainVars.lp,this.env.campainVars.channelId,this.env.campainVars.trafficSource],BasicSmartfoxConstants.S2C_REGISTER);
         BasicModel.userData.loginPwd = param1.password;
         CafeModel.localData.saveInstanceId(this.env.instanceId);
         CafeModel.localData.saveLanguageData(this.env.language);
         CafeModel.localData.saveLoginData(param1.username,param1.password,true);
         CafeModel.userData.loginPwd = param1.password;
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
   }
}
