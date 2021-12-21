package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.BasicComboboxComponent;
   import com.goodgamestudios.basic.vo.ServerVO;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.constants.CommonGameStates;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CafeWorldSelectionDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeWorldSelection";
       
      
      private var selectionBox:BasicComboboxComponent;
      
      public function CafeWorldSelectionDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.worldSelection.okButton.label = CafeModel.languageData.getTextById("generic_connect");
         this.worldSelection.txt_title.text = CafeModel.languageData.getTextById("generic_select_world");
         this.selectionBox = new BasicComboboxComponent(this.worldSelection.worldcombobox);
         super.init();
      }
      
      override protected function applyProperties() : void
      {
         var _loc3_:ServerVO = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc1_:int = CafeModel.localData.readInstanceId();
         var _loc2_:int = 0;
         while(_loc2_ < env.sfsServerList.length)
         {
            _loc3_ = env.sfsServerList[_loc2_];
            _loc4_ = CafeModel.languageData.getTextById("generic_world",[_loc2_ + 1]);
            _loc5_ = {
               "label":_loc4_,
               "data":{
                  "ip":_loc3_.ip,
                  "port":_loc3_.port,
                  "zone":_loc3_.extension,
                  "instance":_loc3_.instanceId
               }
            };
            this.selectionBox.addItem(_loc5_);
            _loc2_++;
         }
         if(env.isTest || env.isLocal)
         {
            this.selectionBox.addItem({
               "label":"Test",
               "data":{
                  "ip":env.testConnectIP,
                  "port":env.testConnectPort,
                  "zone":env.testSmartfoxZone,
                  "instance":-1
               }
            });
            for each(_loc6_ in this.worldSelectionDialogProperties.serverList)
            {
               this.selectionBox.addItem(_loc6_);
            }
         }
         if(_loc1_ != 0)
         {
            this.selectInstance(_loc1_);
         }
         else
         {
            this.selectInstance(env.instanceId);
         }
      }
      
      private function selectInstance(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.selectionBox.itemData.length)
         {
            if(this.selectionBox.itemData[_loc2_].data.instance == param1)
            {
               this.selectionBox.selectItemIndex(_loc2_);
               return;
            }
            _loc2_++;
         }
         this.selectionBox.selectItemIndex(1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         super.onClick(param1);
         switch(param1.target)
         {
            case this.worldSelection.okButton:
               _loc2_ = this.selectionBox.selectedData;
               env.connectIP = String(_loc2_.ip);
               env.connectPort = int(_loc2_.port);
               env.smartfoxZone = String(_loc2_.zone);
               env.instanceId = int(_loc2_.instance);
               controller.connectClient();
               hide();
         }
      }
      
      override public function show() : void
      {
         env.gameState = CommonGameStates.WORLDSELECTION;
         super.show();
      }
      
      private function get worldSelectionDialogProperties() : CafeWorldSelectionDialogProperties
      {
         return properties as CafeWorldSelectionDialogProperties;
      }
      
      private function get worldSelection() : CafeWorldSelection
      {
         return disp as CafeWorldSelection;
      }
   }
}
