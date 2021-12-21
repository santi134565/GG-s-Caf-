package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeInviteFriendDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeInviteFriendDialog";
       
      
      public function CafeInviteFriendDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         controller.addEventListener(CafeDialogEvent.CLOSE_DIALOGS,this.onCloseDialog);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeDialogEvent.CLOSE_DIALOGS,this.onCloseDialog);
      }
      
      private function onCloseDialog(param1:CafeDialogEvent) : void
      {
         if(param1.params && param1.params.length > 0 && param1.params[0] == NAME)
         {
            hide();
         }
      }
      
      override protected function applyProperties() : void
      {
         this.inviteDialog.btn_yes.label = this.inviteDialogProperties.buttonLabel_yes;
         this.inviteDialog.btn_no.label = this.inviteDialogProperties.buttonLabel_no;
         this.inviteDialog.txt_title.text = this.inviteDialogProperties.title;
         this.inviteDialog.txt_copy.text = this.inviteDialogProperties.copy;
         this.inviteDialog.txt_myname.text = CafeModel.languageData.getTextById("alert_invitefriend_myname");
         this.inviteDialog.txt_friendname.text = CafeModel.languageData.getTextById("alert_invitefriend_name");
         this.inviteDialog.txt_friendmail.text = CafeModel.languageData.getTextById("alert_invitefriend_mail");
         this.inviteDialog.txt_input_myname.inputField.text = CafeModel.userData.userName;
         this.inviteDialog.txt_input_friendname.inputField.text = "";
         this.inviteDialog.txt_input_friendmail.inputField.text = "";
         this.inviteDialog.txt_input_myname.inputField.tabIndex = 1;
         this.inviteDialog.txt_input_friendname.inputField.tabIndex = 2;
         this.inviteDialog.txt_input_friendmail.inputField.tabIndex = 3;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.inviteDialog.btn_yes:
               if(CafeModel.userData.isGuest())
               {
                  layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(true));
               }
               else if(this.inviteDialogProperties.functionYes != null)
               {
                  this.inviteDialogProperties.functionYes([this.inviteDialog.txt_input_myname.inputField.text,TextValide.getCleanText(this.inviteDialog.txt_input_friendname.inputField.text),this.inviteDialog.txt_input_friendmail.inputField.text]);
               }
               break;
            case this.inviteDialog.btn_no:
            case this.inviteDialog.btn_close:
               hide();
               if(this.inviteDialogProperties.functionNo != null)
               {
                  this.inviteDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get inviteDialogProperties() : CafeInviteFriendDialogProperties
      {
         return properties as CafeInviteFriendDialogProperties;
      }
      
      protected function get inviteDialog() : CafeInviteFriend
      {
         return disp as CafeInviteFriend;
      }
   }
}
