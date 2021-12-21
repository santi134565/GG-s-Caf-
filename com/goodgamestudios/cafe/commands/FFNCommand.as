package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeDekoShop;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardYesNoDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.objects.moving.NpcguestMoving;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class FFNCommand extends CafeCommand
   {
       
      
      public function FFNCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_FASTFOOD_NPC;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:NpcguestMoving = null;
         param2.shift();
         switch(param1)
         {
            case 999:
               layoutManager.showDialog(CafeStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("dialogwin_smoothiemaker_nofrosty_copy"),this.onBuyVendingMachine,null,null,CafeModel.languageData.getTextById("dialogwin_smoothiemaker_nofrosty_btn_toshop"),CafeModel.languageData.getTextById("dialogwin_smoothiemaker_nofrosty_btn_toshop")));
               break;
            case 103:
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("dialogwin_smoothiemaker_allserved_copy")));
               break;
            case 0:
            default:
               _loc3_ = param2.shift();
               (_loc4_ = this.isoWorld.map.getNpcById(_loc3_) as NpcguestMoving).walkToVendingmachine(this.isoWorld.getVendingmachineByPoint(new Point(param2.shift(),param2.shift())));
               break;
            case 36:
               _loc3_ = param2.shift();
               _loc4_ = this.isoWorld.map.getNpcById(_loc3_) as NpcguestMoving;
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("alert_smoothiemaker_outofreach_copy")));
         }
         return param1 == 0;
      }
      
      public function onBuyVendingMachine(param1:Event = null) : void
      {
         CafeModel.dekoShop.openFor = CafeDekoShop.OPEN_FOR_VENDINGMACHINES;
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_MODE,[1]);
      }
      
      private function get isoWorld() : CafeIsoWorld
      {
         return layoutManager.isoScreen.isoWorld as CafeIsoWorld;
      }
   }
}
