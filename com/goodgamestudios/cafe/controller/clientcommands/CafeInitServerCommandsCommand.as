package com.goodgamestudios.cafe.controller.clientcommands
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitServerCommands;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.commands.ABRCommand;
   import com.goodgamestudios.cafe.commands.ASYCommand;
   import com.goodgamestudios.cafe.commands.BGACommand;
   import com.goodgamestudios.cafe.commands.BIGCommand;
   import com.goodgamestudios.cafe.commands.BOPCommand;
   import com.goodgamestudios.cafe.commands.CAECommand;
   import com.goodgamestudios.cafe.commands.CALCommand;
   import com.goodgamestudios.cafe.commands.CCCCommand;
   import com.goodgamestudios.cafe.commands.CCHCommand;
   import com.goodgamestudios.cafe.commands.CCNCommand;
   import com.goodgamestudios.cafe.commands.CHACommand;
   import com.goodgamestudios.cafe.commands.CICCommand;
   import com.goodgamestudios.cafe.commands.CIFCommand;
   import com.goodgamestudios.cafe.commands.CKUCommand;
   import com.goodgamestudios.cafe.commands.COACommand;
   import com.goodgamestudios.cafe.commands.CODCommand;
   import com.goodgamestudios.cafe.commands.COFCommand;
   import com.goodgamestudios.cafe.commands.COJCommand;
   import com.goodgamestudios.cafe.commands.COLCommand;
   import com.goodgamestudios.cafe.commands.COSCommand;
   import com.goodgamestudios.cafe.commands.COXCommand;
   import com.goodgamestudios.cafe.commands.CPUCommand;
   import com.goodgamestudios.cafe.commands.CRCCommand;
   import com.goodgamestudios.cafe.commands.CSDCommand;
   import com.goodgamestudios.cafe.commands.CSICommand;
   import com.goodgamestudios.cafe.commands.CWACommand;
   import com.goodgamestudios.cafe.commands.EBFCommand;
   import com.goodgamestudios.cafe.commands.EBUCommand;
   import com.goodgamestudios.cafe.commands.EDICommand;
   import com.goodgamestudios.cafe.commands.EEXCommand;
   import com.goodgamestudios.cafe.commands.EINCommand;
   import com.goodgamestudios.cafe.commands.EMCCommand;
   import com.goodgamestudios.cafe.commands.EMOCommand;
   import com.goodgamestudios.cafe.commands.EMVCommand;
   import com.goodgamestudios.cafe.commands.EROCommand;
   import com.goodgamestudios.cafe.commands.ESECommand;
   import com.goodgamestudios.cafe.commands.ESTCommand;
   import com.goodgamestudios.cafe.commands.FFCCommand;
   import com.goodgamestudios.cafe.commands.FFNCommand;
   import com.goodgamestudios.cafe.commands.GAGCommand;
   import com.goodgamestudios.cafe.commands.GAPCommand;
   import com.goodgamestudios.cafe.commands.GMGCommand;
   import com.goodgamestudios.cafe.commands.GRMCommand;
   import com.goodgamestudios.cafe.commands.GUICommand;
   import com.goodgamestudios.cafe.commands.GUSCommand;
   import com.goodgamestudios.cafe.commands.HSLCommand;
   import com.goodgamestudios.cafe.commands.IFRCommand;
   import com.goodgamestudios.cafe.commands.JCACommand;
   import com.goodgamestudios.cafe.commands.JUJCommand;
   import com.goodgamestudios.cafe.commands.JULCommand;
   import com.goodgamestudios.cafe.commands.JUQCommand;
   import com.goodgamestudios.cafe.commands.LBUCommand;
   import com.goodgamestudios.cafe.commands.LCACommand;
   import com.goodgamestudios.cafe.commands.LCBCommand;
   import com.goodgamestudios.cafe.commands.LCPCommand;
   import com.goodgamestudios.cafe.commands.LFECommand;
   import com.goodgamestudios.cafe.commands.LGNCommand;
   import com.goodgamestudios.cafe.commands.LLPCommand;
   import com.goodgamestudios.cafe.commands.LMICommand;
   import com.goodgamestudios.cafe.commands.LRECommand;
   import com.goodgamestudios.cafe.commands.LRFCommand;
   import com.goodgamestudios.cafe.commands.LWRCommand;
   import com.goodgamestudios.cafe.commands.MJMCommand;
   import com.goodgamestudios.cafe.commands.MJOCommand;
   import com.goodgamestudios.cafe.commands.MJRCommand;
   import com.goodgamestudios.cafe.commands.MMUCommand;
   import com.goodgamestudios.cafe.commands.MTSCommand;
   import com.goodgamestudios.cafe.commands.MWFCommand;
   import com.goodgamestudios.cafe.commands.NACCommand;
   import com.goodgamestudios.cafe.commands.NAVCommand;
   import com.goodgamestudios.cafe.commands.NCUCommand;
   import com.goodgamestudios.cafe.commands.NFICommand;
   import com.goodgamestudios.cafe.commands.NHICommand;
   import com.goodgamestudios.cafe.commands.PPCCommand;
   import com.goodgamestudios.cafe.commands.SBCCommand;
   import com.goodgamestudios.cafe.commands.SBICommand;
   import com.goodgamestudios.cafe.commands.SBSCommand;
   import com.goodgamestudios.cafe.commands.SCPCommand;
   import com.goodgamestudios.cafe.commands.SDICommand;
   import com.goodgamestudios.cafe.commands.SEECommand;
   import com.goodgamestudios.cafe.commands.SGACommand;
   import com.goodgamestudios.cafe.commands.SGCCommand;
   import com.goodgamestudios.cafe.commands.SLBCommand;
   import com.goodgamestudios.cafe.commands.SMSCommand;
   import com.goodgamestudios.cafe.commands.SOECommand;
   import com.goodgamestudios.cafe.commands.STECommand;
   import com.goodgamestudios.cafe.commands.VCKCommand;
   import com.goodgamestudios.cafe.commands.WPCCommand;
   import com.goodgamestudios.cafe.commands.WUACommand;
   
   public class CafeInitServerCommandsCommand extends BasicInitServerCommands
   {
       
      
      public function CafeInitServerCommandsCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         super.execute(param1);
         commandDict[SFConstants.S2C_SHOP_DELETE_ITEM] = new SDICommand();
         commandDict[SFConstants.S2C_SHOP_BUY_ITEM] = new SBICommand();
         commandDict[SFConstants.S2C_SHOP_AVAILIBILITY] = new SGACommand();
         commandDict[SFConstants.S2C_JOB_USER_ACTION] = new WUACommand();
         commandDict[SFConstants.S2C_JOB_PAYCHECK] = new WPCCommand();
         commandDict[SFConstants.S2C_MARKETPLACE_SEEKINGJOB] = new MTSCommand();
         commandDict[SFConstants.S2C_MARKETPLACE_JOBREFILL] = new MJRCommand();
         commandDict[SFConstants.S2C_MARKETPLACE_JOB] = new MJOCommand();
         commandDict[SFConstants.S2C_MARKETPLACE_JOIN] = new MJMCommand();
         commandDict[SFConstants.S2C_CAFE_CHAT] = new CCHCommand();
         commandDict[SFConstants.S2C_CAFE_WALK] = new CWACommand();
         commandDict[SFConstants.S2C_CAFE_STOVE_DELIVER] = new CSDCommand();
         commandDict[SFConstants.S2C_CAFE_STOVE_DELIVER_INFO] = new CSICommand();
         commandDict[SFConstants.S2C_CAFE_CLEAN] = new CCNCommand();
         commandDict[SFConstants.S2C_CAFE_INSTANTCOOK] = new CICCommand();
         commandDict[SFConstants.S2C_CAFE_COOK] = new CCCCommand();
         commandDict[SFConstants.S2C_SERVER_MESSAGE] = new SMSCommand();
         commandDict[SFConstants.S2C_ASSETS_SYNCHRONIZE] = new ASYCommand();
         commandDict[SFConstants.S2C_INVENTORY_FRIDGE] = new IFRCommand();
         commandDict[SFConstants.S2C_USER_INFO] = new GUICommand();
         commandDict[SFConstants.S2C_CAFE] = new SGCCommand();
         commandDict[SFConstants.S2C_CHANGE_PASSWORD] = new LCPCommand();
         commandDict[SFConstants.S2C_EDITOR_STORE_OBJECT] = new ESTCommand();
         commandDict[SFConstants.S2C_EDITOR_BUY_OBJECT] = new EBUCommand();
         commandDict[SFConstants.S2C_EDITOR_EXTEND] = new EEXCommand();
         commandDict[SFConstants.S2C_EDITOR_ROTATE_OBJECT] = new EROCommand();
         commandDict[SFConstants.S2C_EDITOR_MOVE_OBJECT] = new EMOCommand();
         commandDict[SFConstants.S2C_EDITOR_MODE] = new EDICommand();
         commandDict[SFConstants.S2C_EDITOR_INVENTORY] = new EINCommand();
         commandDict[SFConstants.S2C_JOIN_USERJOIN] = new JUJCommand();
         commandDict[SFConstants.S2C_JOIN_USERLIST] = new JULCommand();
         commandDict[SFConstants.S2C_NPC_ACTION] = new NACCommand();
         commandDict[SFConstants.S2C_NPC_CUSTOMIZE] = new NCUCommand();
         commandDict[SFConstants.S2C_NPC_FIRE] = new NFICommand();
         commandDict[SFConstants.S2C_NPC_HIRE] = new NHICommand();
         commandDict[SFConstants.S2C_NPC_AVATAR] = new NAVCommand();
         commandDict[SFConstants.S2C_EDITOR_BUY_FLOOR] = new EBFCommand();
         commandDict[SFConstants.S2C_EDITOR_SELL_OBJECT] = new ESECommand();
         commandDict[SFConstants.S2C_CREATE_AVATAR] = new LCACommand();
         commandDict[SFConstants.S2C_REGISTER] = new LRECommand();
         commandDict[SFConstants.S2C_LOGIN] = new LGNCommand();
         commandDict[SFConstants.S2C_LOST_PASSWORD] = new LLPCommand();
         commandDict[SFConstants.S2C_CAFE_RECOOK] = new CRCCommand();
         commandDict[SFConstants.S2C_SOCIAL_TRIGGEREVENT] = new STECommand();
         commandDict[SFConstants.S2C_SOCIAL_LOGIN_BONUS] = new SLBCommand();
         commandDict[SFConstants.S2C_SPECIAL_EVENT] = new SEECommand();
         commandDict[SFConstants.S2C_ALLOW_BUDDY_REQUESTS] = new ABRCommand();
         commandDict[SFConstants.S2C_HIGHSCORE_LIST] = new HSLCommand();
         commandDict[SFConstants.S2C_COOP_FINISH] = new COFCommand();
         commandDict[SFConstants.S2C_COOP_EXTEND] = new COXCommand();
         commandDict[SFConstants.S2C_COOP_LEAVE] = new COLCommand();
         commandDict[SFConstants.S2C_COOP_JOIN] = new COJCommand();
         commandDict[SFConstants.S2C_COOP_START] = new COSCommand();
         commandDict[SFConstants.S2C_COOP_ACTIVELIST] = new COACommand();
         commandDict[SFConstants.S2C_COOP_DETAIL] = new CODCommand();
         commandDict[SFConstants.S2C_GIFT_ALLREADYSEND_PLAYERS] = new GAPCommand();
         commandDict[SFConstants.S2C_GIFT_SENDABLEGIFTS] = new GAGCommand();
         commandDict[SFConstants.S2C_GIFT_PLAYERGIFTS] = new GMGCommand();
         commandDict[SFConstants.S2C_GIFT_USE] = new GUSCommand();
         commandDict[SFConstants.S2C_GIFT_REMOVE] = new GRMCommand();
         commandDict[SFConstants.S2C_CHAT_PUNISHMENT] = new CPUCommand();
         commandDict[SFConstants.S2C_KICK_USER] = new CKUCommand();
         commandDict[SFConstants.S2C_VERSION_CHECK] = new VCKCommand();
         commandDict[SFConstants.S2C_JOIN_CAFE] = new JCACommand();
         commandDict[SFConstants.S2C_LOGIN_FEATURES] = new LFECommand();
         commandDict[SFConstants.S2C_CAFE_ACHIEVEMENT_EARN] = new CAECommand();
         commandDict[SFConstants.S2C_CAFE_ACHIEVEMENT_LIST] = new CALCommand();
         commandDict[SFConstants.S2C_SEND_BLANCING_CONSTANTS] = new SBCCommand();
         commandDict[SFConstants.S2C_SOCIAL_BUDDIES] = new SBSCommand();
         commandDict[SFConstants.S2C_BUDDY_INGAME] = new BIGCommand();
         commandDict[SFConstants.S2C_BUDDY_AVATARS] = new BGACommand();
         commandDict[SFConstants.S2C_LOGIN_BONUS] = new LBUCommand();
         commandDict[SFConstants.S2C_SHOP_CARRIER_PIGEON] = new SCPCommand();
         commandDict[SFConstants.S2C_INVITE_FRIEND] = new CIFCommand();
         commandDict[SFConstants.S2C_OTHERPLAYER_INFO] = new BOPCommand();
         commandDict[SFConstants.S2C_JOIN_USERQUIT] = new JUQCommand();
         commandDict[SFConstants.S2C_MASTERY_INFO] = new LMICommand();
         commandDict[SFConstants.S2C_SPECIAL_OFFER_EVENT] = new SOECommand();
         commandDict[SFConstants.S2C_MINI_MUFFIN] = new MMUCommand();
         commandDict[SFConstants.S2C_WHEELOFFORTUNE] = new MWFCommand();
         commandDict[SFConstants.S2C_CHANGE_AVATAR] = new CHACommand();
         commandDict[SFConstants.S2C_PLAY_WITHOUT_REGISTER] = new LWRCommand();
         commandDict[SFConstants.S2C_FASTFOOD_COOK] = new FFCCommand();
         commandDict[SFConstants.S2C_FASTFOOD_NPC] = new FFNCommand();
         commandDict[BasicSmartfoxConstants.S2C_REGISTER_FACEBOOK] = new LRFCommand();
         commandDict[SFConstants.S2C_COMEBACK_BONUS] = new LCBCommand();
         commandDict[SFConstants.S2C_PAYMENT_SHOP_PRICE_CHANGE] = new PPCCommand();
         commandDict[SFConstants.S2C_EMAIL_VERIFICATION] = new EMVCommand();
         commandDict[SFConstants.S2C_EMAIL_CONFIRMED] = new EMCCommand();
      }
   }
}
