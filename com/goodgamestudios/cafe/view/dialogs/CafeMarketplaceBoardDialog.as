package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeMarketplaceBoardDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeMarketplaceBoardDialog";
       
      
      public function CafeMarketplaceBoardDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.boardDialog.btn_refill.textXOffset = 60;
         controller.addEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayoutState);
         controller.addEventListener(CafeUserEvent.CHANGE_JOBAMOUNT,this.onChangeJobAmount);
         super.init();
      }
      
      override protected function applyProperties() : void
      {
         this.boardDialog.btn_refill.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.boardDialog.btn_refill.name);
         this.boardDialog.btn_refill.txt_label.text = "x " + CafeConstants.jobRefillGold;
         this.boardDialog.btn_help.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.boardDialog.btn_help.name);
         this.boardDialog.btn_sign.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.boardDialog.btn_sign.name);
         if(this.boardDialogProperties.seekingJob)
         {
            this.boardDialog.btn_sign.gotoAndStop(2);
         }
         else
         {
            this.boardDialog.btn_sign.enableButton = CafeModel.userData.heroVO.openJobs > 0;
            this.boardDialog.btn_sign.gotoAndStop(1);
         }
         this.boardDialog.txt_job.text = CafeModel.languageData.getTextById("XofY",[CafeModel.userData.heroVO.openJobs,CafeConstants.jobsPerDay]);
         this.boardDialog.txt_title.text = this.boardDialogProperties.title;
         TextFieldHelper.changeTextFromatSizeByTextWidth(20,this.boardDialog.txt_title,this.boardDialogProperties.title);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayoutState);
         controller.removeEventListener(CafeUserEvent.CHANGE_JOBAMOUNT,this.onChangeJobAmount);
      }
      
      override public function show() : void
      {
         super.show();
         this.boardDialog.btn_help.selected();
      }
      
      private function onChangeLayoutState(param1:CafeDialogEvent) : void
      {
         hide();
      }
      
      private function onChangeJobAmount(param1:CafeUserEvent) : void
      {
         this.boardDialog.txt_job.text = CafeModel.languageData.getTextById("XofY",[CafeModel.userData.heroVO.openJobs,CafeConstants.jobsPerDay]);
         this.boardDialog.btn_sign.enableButton = CafeModel.userData.heroVO.openJobs > 0;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.boardDialog.btn_help:
               hide();
               if(this.boardDialogProperties.functionHelp != null)
               {
                  this.boardDialogProperties.functionHelp(null);
               }
               break;
            case this.boardDialog.btn_close:
               hide();
               break;
            case this.boardDialog.btn_refill:
               if(this.boardDialogProperties.functionRefill != null)
               {
                  this.boardDialogProperties.functionRefill(null);
               }
               break;
            case this.boardDialog.btn_sign:
               hide();
               if(this.boardDialogProperties.functionSign != null)
               {
                  this.boardDialogProperties.functionSign(null);
               }
         }
      }
      
      protected function get boardDialogProperties() : CafeMarketplaceBoardDialogProperties
      {
         return properties as CafeMarketplaceBoardDialogProperties;
      }
      
      protected function get boardDialog() : CafeMarketplaceBoard
      {
         return disp as CafeMarketplaceBoard;
      }
   }
}
