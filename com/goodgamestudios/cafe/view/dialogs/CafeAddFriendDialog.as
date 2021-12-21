package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeAddFriendDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeAddFriendDialog";
       
      
      public function CafeAddFriendDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function get isUnique() : Boolean
      {
         return false;
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.btn_yes.label = this.addFriendDialogProperties.buttonLabel_yes;
         this.standardDialog.btn_no.label = this.addFriendDialogProperties.buttonLabel_no;
         this.standardDialog.txt_title.text = this.addFriendDialogProperties.title;
         this.standardDialog.txt_copy.text = this.addFriendDialogProperties.copy;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_yes:
               hide();
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_BUDDY_INGAME,[1,this.addFriendDialogProperties.offerUserId,CafeModel.userData.playerID]);
               break;
            case this.standardDialog.btn_close:
            case this.standardDialog.btn_no:
               hide();
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_BUDDY_INGAME,[2,this.addFriendDialogProperties.offerUserId,CafeModel.userData.playerID]);
         }
      }
      
      protected function get addFriendDialogProperties() : CafeAddFriendDialogProperties
      {
         return properties as CafeAddFriendDialogProperties;
      }
      
      protected function get standardDialog() : CafeStandardYesNo
      {
         return disp as CafeStandardYesNo;
      }
   }
}
