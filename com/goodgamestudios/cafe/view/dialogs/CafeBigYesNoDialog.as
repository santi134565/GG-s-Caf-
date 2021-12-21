package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeBigYesNoDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeBigYesNoDialog";
       
      
      public function CafeBigYesNoDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.btn_yes.label = this.standardDialogProperties.buttonLabel_yes;
         this.standardDialog.btn_no.label = this.standardDialogProperties.buttonLabel_no;
         this.standardDialog.txt_title.text = this.standardDialogProperties.title;
         this.standardDialog.txt_copy.text = this.standardDialogProperties.copy;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_yes:
               hide();
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes(null);
               }
               break;
            case this.standardDialog.btn_close:
               hide();
               if(this.standardDialogProperties.functionClose != null)
               {
                  this.standardDialogProperties.functionClose(null);
               }
               break;
            case this.standardDialog.btn_no:
               hide();
               if(this.standardDialogProperties.functionNo != null)
               {
                  this.standardDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get standardDialogProperties() : BasicStandardYesNoDialogProperties
      {
         return properties as BasicStandardYesNoDialogProperties;
      }
      
      protected function get standardDialog() : CafeBigYesNo
      {
         return disp as CafeBigYesNo;
      }
   }
}
