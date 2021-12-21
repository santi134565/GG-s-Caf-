package com.goodgamestudios.cafe.view.dialogs
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeJobPaycheckDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeJobPaycheckDialog";
       
      
      public function CafeJobPaycheckDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.jobpaycheckDialog.btn_ok.label = this.jobpaycheckDialogProperties.buttonLabel_okay;
         this.jobpaycheckDialog.txt_title.text = this.jobpaycheckDialogProperties.title;
         this.jobpaycheckDialog.txt_copy.text = this.jobpaycheckDialogProperties.copy;
         this.jobpaycheckDialog.txt_cash.text = String(this.jobpaycheckDialogProperties.cash);
         this.jobpaycheckDialog.txt_xp.text = String(this.jobpaycheckDialogProperties.xp);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.jobpaycheckDialog.btn_ok:
               hide();
         }
      }
      
      protected function get jobpaycheckDialogProperties() : CafeJobPaycheckDialogProperties
      {
         return properties as CafeJobPaycheckDialogProperties;
      }
      
      protected function get jobpaycheckDialog() : CafeJobPaycheck
      {
         return disp as CafeJobPaycheck;
      }
   }
}
