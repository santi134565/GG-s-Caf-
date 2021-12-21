package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicReconnectDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeReconnectDialog extends CafeDialog
   {
      
      public static const NAME:String = CommonDialogNames.ReconnectDialog_NAME;
       
      
      public function CafeReconnectDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.reconnectDialog.btn_reconnect.label = this.reconnectDialogProperties.buttonLabel_reconnect;
         this.reconnectDialog.txt_title.text = this.reconnectDialogProperties.title;
         this.reconnectDialog.txt_copy.text = this.reconnectDialogProperties.copy;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.reconnectDialog.btn_reconnect:
               hide();
               if(this.reconnectDialogProperties.functionReconnect != null)
               {
                  this.reconnectDialogProperties.functionReconnect();
               }
         }
      }
      
      protected function get reconnectDialogProperties() : BasicReconnectDialogProperties
      {
         return properties as BasicReconnectDialogProperties;
      }
      
      protected function get reconnectDialog() : CafeReconnect
      {
         return disp as CafeReconnect;
      }
   }
}
