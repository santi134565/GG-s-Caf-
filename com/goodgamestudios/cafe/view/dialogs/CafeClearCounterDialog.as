package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeClearCounterDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeClearCounterDialog";
       
      
      public function CafeClearCounterDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.clearCounterDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_clearcounter_title");
         this.clearCounterDialog.btn_cancel.label = CafeModel.languageData.getTextById("dialogwin_clearcounter_cancelButton");
         this.clearCounterDialog.btn_ok.label = CafeModel.languageData.getTextById("dialogwin_clearcounter_okButton");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.clearCounterDialog.btn_close:
            case this.clearCounterDialog.btn_cancel:
               hide();
               break;
            case this.clearCounterDialog.btn_ok:
               if(this.cafeClearCounterDialogProperties.target.currentDish)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_CAFE_CLEAN,[this.cafeClearCounterDialogProperties.target.isoGridPos.x,this.cafeClearCounterDialogProperties.target.isoGridPos.y]);
               }
               hide();
         }
      }
      
      protected function get cafeClearCounterDialogProperties() : CafeClearCounterDialogProperties
      {
         return properties as CafeClearCounterDialogProperties;
      }
      
      protected function get clearCounterDialog() : CafeClearCounter
      {
         return disp as CafeClearCounter;
      }
   }
}
