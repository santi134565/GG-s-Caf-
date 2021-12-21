package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeNoMoneyDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeNoMoneyDialog";
       
      
      public function CafeNoMoneyDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.noMoneyDialog.txt_title.text = this.noMoneyDialogProperties.title;
         this.noMoneyDialog.txt_copy.text = this.noMoneyDialogProperties.copy;
         this.noMoneyDialog.btn_ok.label = CafeModel.languageData.getTextById("dialogwin_nomoney_ok");
         this.noMoneyDialog.btn_more.toolTipText = CafeModel.languageData.getTextById("dialogwin_nomoney_moregold");
         this.noMoneyDialog.btn_more.visible = env.usePayment;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.noMoneyDialog.btn_ok:
            case this.noMoneyDialog.btn_close:
               hide();
               break;
            case this.noMoneyDialog.btn_more:
               controller.onClickMoreMoney(null);
               hide();
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.noMoneyDialog.btn_more.selected();
      }
      
      protected function get noMoneyDialogProperties() : CafeNoMoneyDialogProperties
      {
         return properties as CafeNoMoneyDialogProperties;
      }
      
      protected function get noMoneyDialog() : CafeNoMoney
      {
         return disp as CafeNoMoney;
      }
   }
}
