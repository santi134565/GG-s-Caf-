package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeMarketplaceJobDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeMarketplaceJobDialog";
       
      
      public function CafeMarketplaceJobDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function get isUnique() : Boolean
      {
         return false;
      }
      
      override protected function applyProperties() : void
      {
         this.jobDialog.btn_yes.label = this.jobDialogProperties.buttonLabel_yes;
         this.jobDialog.btn_no.label = this.jobDialogProperties.buttonLabel_no;
         this.jobDialog.txt_title.text = this.jobDialogProperties.title;
         this.jobDialog.txt_copy.text = this.jobDialogProperties.copy;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.jobDialog.btn_yes:
               hide();
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_MARKETPLACE_JOB,[1,this.jobDialogProperties.offerUserId,CafeModel.userData.userID]);
               break;
            case this.jobDialog.btn_close:
            case this.jobDialog.btn_no:
               hide();
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_MARKETPLACE_JOB,[2,this.jobDialogProperties.offerUserId,CafeModel.userData.userID]);
         }
      }
      
      protected function get jobDialogProperties() : CafeMarketplaceJobDialogProperties
      {
         return properties as CafeMarketplaceJobDialogProperties;
      }
      
      protected function get jobDialog() : CafeStandardYesNo
      {
         return disp as CafeStandardYesNo;
      }
   }
}
