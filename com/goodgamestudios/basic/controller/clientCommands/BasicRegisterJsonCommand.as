package com.goodgamestudios.basic.controller.clientCommands
{
   import com.adobe.serialization.json.JSON;
   import com.goodgamestudios.basic.EnviromentGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicRegisterJsonCommand extends SimpleCommand
   {
       
      
      public function BasicRegisterJsonCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Array = param1 as Array;
         var _loc3_:String = _loc2_.shift();
         var _loc4_:String = _loc2_.shift();
         var _loc5_:Object;
         (_loc5_ = _loc2_.shift() as Object).mail = _loc3_;
         _loc5_.pw = _loc4_;
         _loc5_.referrer = EnviromentGlobalsHandler.globals.referrer;
         _loc5_.lang = EnviromentGlobalsHandler.globals.language;
         _loc5_.did = EnviromentGlobalsHandler.globals.distributorId;
         _loc5_.connectTime = BasicModel.smartfoxClient.connectionTime;
         _loc5_.ping = BasicModel.smartfoxClient.roundTripTime;
         _loc5_.accountId = EnviromentGlobalsHandler.globals.accountId;
         _loc5_.campainPId = EnviromentGlobalsHandler.globals.campainVars.partnerId;
         _loc5_.campainCr = EnviromentGlobalsHandler.globals.campainVars.creative;
         _loc5_.campainPl = EnviromentGlobalsHandler.globals.campainVars.placement;
         _loc5_.campainKey = EnviromentGlobalsHandler.globals.campainVars.keyword;
         _loc5_.campainNW = EnviromentGlobalsHandler.globals.campainVars.network;
         _loc5_.campainLP = EnviromentGlobalsHandler.globals.campainVars.lp;
         _loc5_.campainCId = EnviromentGlobalsHandler.globals.campainVars.channelId;
         _loc5_.campainTS = EnviromentGlobalsHandler.globals.campainVars.trafficSource;
         _loc5_.adid = EnviromentGlobalsHandler.globals.campainVars.adid;
         _loc5_.camp = EnviromentGlobalsHandler.globals.campainVars.camp;
         _loc5_.adgr = EnviromentGlobalsHandler.globals.campainVars.adgr;
         _loc5_.matchtype = EnviromentGlobalsHandler.globals.campainVars.matchtype;
         BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_REGISTER,[com.adobe.serialization.json.JSON.encode(_loc5_)]);
         BasicModel.userData.loginPwd = _loc4_;
      }
   }
}
