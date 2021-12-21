package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeStandardOkDialog extends CafeDialog
   {
      
      public static const NAME:String = CommonDialogNames.StandardOkDialog_NAME;
       
      
      public function CafeStandardOkDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.btn_ok.label = this.standardDialogProperties.buttonLabel_ok;
         TextFieldHelper.changeTextFromatSizeByTextWidth(26,this.standardDialog.txt_title,this.standardDialogProperties.title);
         this.standardDialog.txt_copy.text = this.standardDialogProperties.copy;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_close:
               hide();
               break;
            case this.standardDialog.btn_ok:
               hide();
               if(this.standardDialogProperties.functionOk != null)
               {
                  this.standardDialogProperties.functionOk(null);
               }
         }
      }
      
      protected function get standardDialogProperties() : BasicStandardOkDialogProperties
      {
         return properties as BasicStandardOkDialogProperties;
      }
      
      protected function get standardDialog() : CafeStandardOk
      {
         return disp as CafeStandardOk;
      }
   }
}
