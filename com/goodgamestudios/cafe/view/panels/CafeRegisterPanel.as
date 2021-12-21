package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeRegisterDialogProperties;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CafeRegisterPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeRegisterPanel";
       
      
      public function CafeRegisterPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.registerPanel.btn_register.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.registerPanel.btn_register.name);
         controller.addEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayoutState);
         super.init();
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         controller.removeEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayoutState);
         super.onRemovedFromStage(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.registerPanel.btn_register:
               layoutManager.showDialog(CafeRegisterDialog.NAME,new CafeRegisterDialogProperties(false,false));
         }
      }
      
      private function onChangeLayoutState(param1:CafeDialogEvent) : void
      {
         this.updatePosition();
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         if(disp && disp.stage)
         {
            _loc1_ = disp.getBounds(null);
            disp.y = disp.stage.stageHeight - 155;
            disp.x = disp.stage.stageWidth;
            if(env.hasNetworkBuddies)
            {
               disp.y -= CafeBuddylistPanel.BUDDY_PANEL_HEIGHT;
            }
            if(CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_DEKO_SHOP)
            {
               disp.y -= 100;
            }
         }
      }
      
      protected function get registerPanel() : RegisterPanel
      {
         return disp as RegisterPanel;
      }
   }
}
