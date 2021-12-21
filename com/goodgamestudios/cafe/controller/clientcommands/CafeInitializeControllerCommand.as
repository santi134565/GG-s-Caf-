package com.goodgamestudios.cafe.controller.clientcommands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitalizeControllerCommand;
   import com.goodgamestudios.cafe.CafeEnvironmentGlobals;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeWorldSelectionDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeWorldSelectionDialogProperties;
   
   public class CafeInitializeControllerCommand extends BasicInitalizeControllerCommand
   {
       
      
      public function CafeInitializeControllerCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         super.execute(param1);
         if(this.env.isTest || this.env.isLocal)
         {
            this.layoutManager.showDialog(CafeWorldSelectionDialog.NAME,new CafeWorldSelectionDialogProperties());
         }
         else if(!this.env.hasInstances || this.env.forceInstanceConnect)
         {
            BasicController.getInstance().connectClient();
         }
         else
         {
            this.layoutManager.showDialog(CafeWorldSelectionDialog.NAME,new CafeWorldSelectionDialogProperties());
         }
         this.layoutManager.onStartProgressbar();
         CafeSoundController.getInstance().initialize();
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new CafeEnvironmentGlobals();
      }
      
      private function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance();
      }
   }
}
