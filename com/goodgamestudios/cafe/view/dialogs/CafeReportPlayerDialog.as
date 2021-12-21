package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import com.goodgamestudios.basic.view.BasicComboboxComponent;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeReportPlayerDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeReportPlayerDialog";
       
      
      private var selectionBox:BasicComboboxComponent;
      
      public function CafeReportPlayerDialog(param1:Sprite)
      {
         super(param1);
         this.selectionBox = new BasicComboboxComponent(this.reportPlayerDialog.reasoncombobox,CafeModel.languageData.getTextById("generic_report_player_reason_title"));
      }
      
      override protected function applyProperties() : void
      {
         this.reportPlayerDialog.txt_title.text = CafeModel.languageData.getTextById("generic_report_player_title");
         this.reportPlayerDialog.txt_copy.text = CafeModel.languageData.getTextById("generic_report_player_copy",[this.reportPlayerDialogProperties.reportPlayerName]);
         this.reportPlayerDialog.txt_reason_title.text = CafeModel.languageData.getTextById("generic_report_player_reason_title");
         this.reportPlayerDialog.btn_report.label = CafeModel.languageData.getTextById("generic_btn_report");
         this.reportPlayerDialog.btn_cancel.label = CafeModel.languageData.getTextById("generic_btn_cancel");
         this.selectionBox.clearItems();
         var _loc1_:int = 0;
         while(CafeModel.languageData.getTextById("generic_report_player_reason_" + _loc1_) != "")
         {
            this.selectionBox.addItem({
               "label":CafeModel.languageData.getTextById("generic_report_player_reason_" + _loc1_),
               "data":{}
            });
            _loc1_++;
         }
         this.selectionBox.selectItemIndex(-1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         super.onClick(param1);
         switch(param1.target)
         {
            case this.reportPlayerDialog.btn_report:
               if(this.selectionBox.selectedId != -1)
               {
                  _loc2_ = this.selectionBox.selectedId + " - " + this.selectionBox.selectedLabel;
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_REPORT_PLAYER,[this.reportPlayerDialogProperties.reportPlayerUserId,_loc2_]);
               }
               this.hide();
               break;
            case this.reportPlayerDialog.btn_close:
            case this.reportPlayerDialog.btn_cancel:
               this.hide();
         }
      }
      
      override public function show() : void
      {
         this.selectionBox.disp.addEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onComboboxChange);
         this.reportPlayerDialog.btn_report.visible = false;
         super.show();
      }
      
      override public function hide() : void
      {
         this.selectionBox.disp.addEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onComboboxChange);
         super.hide();
      }
      
      private function onComboboxChange(param1:BasicComboboxEvent) : void
      {
         this.reportPlayerDialog.btn_report.visible = true;
      }
      
      protected function get reportPlayerDialogProperties() : CafeReportPlayerDialogProperties
      {
         return properties as CafeReportPlayerDialogProperties;
      }
      
      protected function get reportPlayerDialog() : CafeReportPlayer
      {
         return disp as CafeReportPlayer;
      }
   }
}
