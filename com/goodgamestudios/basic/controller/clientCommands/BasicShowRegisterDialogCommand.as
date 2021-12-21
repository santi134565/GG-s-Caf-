package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicRegisterDialogProperties;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicShowRegisterDialogCommand extends SimpleCommand
   {
       
      
      public function BasicShowRegisterDialogCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         this.layoutManager.showDialog(CommonDialogNames.RegisterDialog_NAME,new BasicRegisterDialogProperties());
      }
      
      private function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
   }
}
