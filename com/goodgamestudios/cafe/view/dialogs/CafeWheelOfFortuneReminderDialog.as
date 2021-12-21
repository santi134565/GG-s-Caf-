package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeWheelOfFortuneReminderDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeWheelOfFortuneReminderDialog";
       
      
      public function CafeWheelOfFortuneReminderDialog(param1:Sprite)
      {
         super(param1);
      }
      
      public static function get isShowingAllowed() : Boolean
      {
         return CafeModel.userData.userLevel >= CafeConstants.LEVEL_FOR_WHEELOFFORTUNE && CafeLayoutManager.getInstance().inGameState && !CafeTutorialController.getInstance().isActive && !CafeModel.userData.isGuest() && !CafeLayoutManager.getInstance().existsDialog(CafeWheelOfFortuneDialog) && CafeLayoutManager.getInstance().isoScreen && CafeLayoutManager.getInstance().isoScreen.isoWorld;
      }
      
      override protected function applyProperties() : void
      {
         this.reminderDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_wheeloffortune_title");
         TextFieldHelper.changeTextFromatSizeByTextWidth(32,this.reminderDialog.txt_title,CafeModel.languageData.getTextById("dialogwin_wheeloffortune_title"),1);
         this.reminderDialog.txt_copy.text = CafeModel.languageData.getTextById("dialogwin_wheeloffortune_copy1");
         this.reminderDialog.btn_play.label = CafeModel.languageData.getTextById("dialogwin_wheeloffortune_btn_go");
         this.reminderDialog.btn_cancel.label = CafeModel.languageData.getTextById("generic_btn_noshare");
         super.applyProperties();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.reminderDialog.btn_play:
               layoutManager.showDialog(CafeWheelOfFortuneDialog.NAME,new CafeWheelOfFortuneDialogProperties(!CafeModel.userData.playedWheelOfFortune,0));
            case this.reminderDialog.btn_cancel:
            case this.reminderDialog.btn_close:
               hide();
         }
         super.onClick(param1);
      }
      
      private function get reminderDialog() : CafeWheelOfFortuneReminder
      {
         return disp as CafeWheelOfFortuneReminder;
      }
   }
}
