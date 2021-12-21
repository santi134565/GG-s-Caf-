package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeEditorEvent;
   import com.goodgamestudios.cafe.event.CafeInventoryEvent;
   import com.goodgamestudios.cafe.event.CafeLevelEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeDekoShop;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.view.dialogs.CafeChoiceAmountDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeChoiceAmountDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeDecoshopHelpDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeOrderCompanyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeOrderCompanyDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardYesNoDialog;
   import com.goodgamestudios.cafe.world.CafeIsoMouse;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.objects.door.BasicDoor;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import com.goodgamestudios.cafe.world.objects.vendingmachine.BasicVendingmachine;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.expansion.BasicExpansionVO;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.objects.IDraggable;
   import com.goodgamestudios.isocore.objects.IsoStaticObject;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeDekoShopPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeDekoShopPanel";
      
      private static const CATEGORY_DECO:int = 1;
      
      private static const CATEGORY_FUNCTIONALS:int = 2;
      
      private static const CATEGORY_EXPANSION:int = 3;
       
      
      private var MAX_WIDTH:int = 100;
      
      private var MAX_HEIGHT:int = 80;
      
      private var itemsPerPage:int = 5;
      
      private var currentPage:int = 0;
      
      private var currentGroup:String;
      
      private var currentCategory:int;
      
      private var maxPage:int = 0;
      
      private var lastSelectedItemWodId:int = -1;
      
      private var selectedItemWodId:int = -1;
      
      private var sellItemWodId:int;
      
      private var selectedItemFromWorld:Boolean = false;
      
      private var selectedItemMc:MovieClip;
      
      private var tempDragObject:IsoStaticObject;
      
      private var selectTile:Boolean = false;
      
      private var newObjectWasOnMap:Boolean = false;
      
      public function CafeDekoShopPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         controller.addEventListener(CafeEditorEvent.BUY_ITEM,this.onChangeAmount);
         controller.addEventListener(CafeEditorEvent.SELL_ITEM,this.onChangeAmount);
         controller.addEventListener(CafeLevelEvent.SIZE_CHANGE,this.onChangeAmount);
         controller.addEventListener(CafeInventoryEvent.UPDATE_INVENTORY,this.onChangeAmount);
         this.dekoShopPanel.btn_close.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_close.name);
         this.dekoShopPanel.btn_deko.mc_new.visible = false;
         this.dekoShopPanel.btn_deko.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_deko.name);
         this.dekoShopPanel.btn_functional.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_functional.name);
         this.dekoShopPanel.btn_sell.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_sell.name);
         if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_EXPANSIONS)
         {
            this.dekoShopPanel.btn_expansion.enableButton = false;
            this.dekoShopPanel.btn_expansion.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_EXPANSIONS]);
         }
         else
         {
            this.dekoShopPanel.btn_expansion.enableButton = true;
            this.dekoShopPanel.btn_expansion.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_expansion.name);
         }
         super.init();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeEditorEvent.BUY_ITEM,this.onChangeAmount);
         controller.removeEventListener(CafeEditorEvent.SELL_ITEM,this.onChangeAmount);
         controller.removeEventListener(CafeLevelEvent.SIZE_CHANGE,this.onChangeAmount);
         controller.removeEventListener(CafeInventoryEvent.UPDATE_INVENTORY,this.onChangeAmount);
      }
      
      private function get isoMouse() : CafeIsoMouse
      {
         return layoutManager.isoScreen.isoWorld.mouse as CafeIsoMouse;
      }
      
      private function onRemovedraggfx(param1:IsoWorldEvent) : void
      {
         this.removeDragItem();
      }
      
      private function initArrows(param1:int) : void
      {
         this.maxPage = (param1 - 1) / this.itemsPerPage;
         this.dekoShopPanel.btn_arrowright.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.dekoShopPanel.btn_arrowleft.visible = this.maxPage > 0 && this.currentPage > 0;
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this.currentPage;
         if(param1.target == this.dekoShopPanel.btn_arrowleft)
         {
            this.currentPage = Math.max(0,this.currentPage - 1);
         }
         else
         {
            this.currentPage = Math.min(this.maxPage,this.currentPage + 1);
         }
         if(_loc2_ != this.currentPage)
         {
            this.fillItemsByGroup();
         }
      }
      
      private function onChangeAmount(param1:Event) : void
      {
         this.fillItemsByGroup();
         this.setBlockLayer();
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:ShopVO = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:IsoStaticObject = null;
         if(this.selectedItemMc || this.tempDragObject)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            if(param1 && param1.target == this.dekoShopPanel.btn_sell)
            {
               this.sellItemWodId = this.selectedItemWodId;
               _loc2_ = CafeModel.wodData.voList[this.sellItemWodId] as ShopVO;
               _loc3_ = String(_loc2_.calculateSaleValueCash()) + " " + CafeModel.languageData.getTextById("cash");
               _loc4_ = this.onCheckRemoveAllowed(_loc2_,this.selectedItemFromWorld);
               switch(_loc4_)
               {
                  case 0:
                     if(this.selectedItemFromWorld)
                     {
                        layoutManager.showDialog(CafeStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("alert_selldeco_title"),CafeModel.languageData.getTextById("alert_selldeco_copy",[_loc3_]),this.onSellMap,this.onNotSellMap,this.onNotSellMap,CafeModel.languageData.getTextById("btn_text_yes"),CafeModel.languageData.getTextById("btn_text_cancle")));
                     }
                     else if(CafeModel.inventoryFurniture.hasItem(this.selectedItemWodId))
                     {
                        layoutManager.showDialog(CafeChoiceAmountDialog.NAME,new CafeChoiceAmountDialogProperties(CafeModel.inventoryFurniture.getInventoryAmountByWodId(this.sellItemWodId),this.sellItemWodId,CafeModel.languageData.getTextById("alert_selldeco_title"),CafeModel.languageData.getTextById("alert_selldeco_copy",[_loc3_]),CafeChoiceAmountDialogProperties.BUTTONTYPE_STANDARD,this.onSellInventory,null,CafeModel.languageData.getTextById("btn_text_yes"),CafeModel.languageData.getTextById("btn_text_cancle")));
                     }
                     break;
                  case 1:
                     layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("editstoreobj_removefailmin_title"),CafeModel.languageData.getTextById("editstoreobj_removefailmin_" + _loc2_.group.toLowerCase())));
                     if(this.selectedItemFromWorld)
                     {
                        this.isoMouse.resetDragObject();
                        this.isoMouse.onMouseUp(null);
                     }
                     break;
                  case 2:
                     layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("editstoreobj_removefail_title"),CafeModel.languageData.getTextById("editstoreobj_removefail_" + _loc2_.group.toLowerCase())));
                     if(this.selectedItemFromWorld)
                     {
                        this.isoMouse.resetDragObject();
                        this.isoMouse.onMouseUp(null);
                     }
               }
            }
            else if(this.selectedItemFromWorld)
            {
               _loc5_ = this.isoMouse.iDragObject as IsoStaticObject;
               if(this.isoMouse.iDragObject)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_STORE_OBJECT,[_loc5_.oldIsoPos.x,_loc5_.oldIsoPos.y]);
               }
               else if(this.tempDragObject)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_STORE_OBJECT,[this.tempDragObject.oldIsoPos.x,this.tempDragObject.oldIsoPos.y]);
                  this.isoMouse.iDragObject = this.tempDragObject as IDraggable;
                  this.isoMouse.removeIDragObject();
                  this.tempDragObject = null;
               }
            }
            if(this.isoMouse.isDrawingTiles)
            {
               layoutManager.isoScreen.isoWorld.clearDrawTiles();
               this.isoMouse.removeIDragObject();
            }
            this.isoMouse.mouseDown = false;
            this.isoMouse.isDrawingTiles = false;
            this.selectedItemFromWorld = false;
            this.selectTile = false;
            this.removeDragItem();
         }
         else if(this.selectTile && this.currentGroup == CafeConstants.GROUP_TILE && param1 && param1.target.wodId)
         {
            this.addDragItem(param1.target.wodId);
            this.newObjectWasOnMap = false;
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         if(this.isoMouse.iDragObjectIsLocked)
         {
            return;
         }
         switch(param1.target)
         {
            case this.dekoShopPanel.j0:
            case this.dekoShopPanel.j1:
            case this.dekoShopPanel.j2:
            case this.dekoShopPanel.j3:
            case this.dekoShopPanel.j4:
               if(this.currentGroup == CafeConstants.GROUP_TILE)
               {
                  this.selectTile = true;
               }
               else
               {
                  this.selectTile = false;
                  this.addDragItem(param1.target.wodId);
                  this.newObjectWasOnMap = false;
                  if(this.currentCategory != CATEGORY_EXPANSION)
                  {
                     layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
                  }
               }
         }
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         this.onCursorOut(param1);
         if(this.sellItemWodId == -1)
         {
            this.isoMouse.showIsoCursor();
         }
         if(this.selectedItemWodId == -1)
         {
            if(this.selectTile)
            {
               this.selectTile = false;
               layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_buytiles_title"),CafeModel.languageData.getTextById("alert_buytiles_copy")));
            }
            return;
         }
         if(!this.selectedItemFromWorld)
         {
            this.newObjectWasOnMap = true;
            layoutManager.isoScreen.isoWorld.addDragIsoObject(CafeModel.wodData.createVObyWOD(this.selectedItemWodId));
         }
      }
      
      private function showDecoToolTip(param1:MovieClip) : void
      {
         if(param1)
         {
            this.dekoShopPanel.mc_decotooltip.x = param1.x + param1.width / 2;
            this.dekoShopPanel.mc_decotooltip.txt_label.text = " + " + param1.toolTipText;
            this.dekoShopPanel.mc_decotooltip.txt_label.width = this.dekoShopPanel.mc_decotooltip.txt_label.textWidth + 5;
            this.dekoShopPanel.mc_decotooltip.background.width = Math.max(60,this.dekoShopPanel.mc_decotooltip.txt_label.width + 50);
            this.dekoShopPanel.mc_decotooltip.mc_luxury.x = -(this.dekoShopPanel.mc_decotooltip.txt_label.width / 2 + 10);
            this.dekoShopPanel.mc_decotooltip.txt_label.x = this.dekoShopPanel.mc_decotooltip.mc_luxury.x + 10;
            this.dekoShopPanel.mc_decotooltip.visible = true;
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         this.onCursorOver(param1);
         if(param1.target.hasOwnProperty(BasicToolTipManager.TOOLTIP_LABEL))
         {
            switch(param1.target)
            {
               case this.dekoShopPanel.j0:
               case this.dekoShopPanel.j1:
               case this.dekoShopPanel.j2:
               case this.dekoShopPanel.j3:
               case this.dekoShopPanel.j4:
                  if(this.currentCategory != CATEGORY_EXPANSION)
                  {
                     this.showDecoToolTip(param1.target as MovieClip);
                  }
                  break;
               default:
                  layoutManager.tooltipManager.show(param1.target.toolTipText,param1.target as DisplayObject);
            }
         }
         this.isoMouse.mouseIsOnWorld = false;
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         switch(param1.target)
         {
            case this.dekoShopPanel.j0:
            case this.dekoShopPanel.j1:
            case this.dekoShopPanel.j2:
            case this.dekoShopPanel.j3:
            case this.dekoShopPanel.j4:
               this.dekoShopPanel.mc_decotooltip.visible = false;
         }
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         var _loc2_:VisualElement = null;
         var _loc3_:int = 0;
         this.isoMouse.hideIsoCursor();
         if(this.isoMouse.iDragObjectIsLocked)
         {
            return;
         }
         if(this.isoMouse.isWorldDragging)
         {
            this.isoMouse.onMouseUp(null);
         }
         if(this.isoMouse.iDragObject)
         {
            _loc2_ = this.isoMouse.iDragObject as VisualElement;
            this.selectedItemWodId = _loc2_.getVisualVO().wodId;
            this.addDragItem(this.selectedItemWodId);
            if(this.isoMouse.iDragObject.wasOnMap)
            {
               _loc3_ = this.onCheckStoreAllowed(_loc2_);
               switch(_loc3_)
               {
                  case 0:
                     if(this.isoMouse.iDragObject.removeAllowed)
                     {
                        this.selectedItemFromWorld = true;
                        _loc2_.hide();
                     }
                     else
                     {
                        this.isoMouse.resetDragObject();
                        this.isoMouse.onMouseUp(null);
                     }
                     break;
                  case 1:
                     layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("editstoreobj_removefailmin_title"),CafeModel.languageData.getTextById("editstoreobj_removefailmin_" + String(_loc2_.group).toLowerCase())));
                     this.isoMouse.resetDragObject();
                     this.isoMouse.onMouseUp(null);
                     break;
                  case 2:
                     layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("editstoreobj_removefail_title"),CafeModel.languageData.getTextById("editstoreobj_removefail_" + String(_loc2_.group).toLowerCase())));
                     this.isoMouse.resetDragObject();
                     this.isoMouse.onMouseUp(null);
                     break;
                  case 3:
                     this.tempDragObject = this.isoMouse.iDragObject as IsoStaticObject;
                     this.isoMouse.resetDragObject();
                     this.isoMouse.onMouseUp(null);
                     this.selectedItemFromWorld = true;
                     layoutManager.showDialog(CafeStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(CafeModel.languageData.getTextById("alert_selldeco_title"),CafeModel.languageData.getTextById("alert_smoothiemaker_storage_copy"),this.onMouseUp,this.onNotSellMap,this.onNotSellMap,CafeModel.languageData.getTextById("btn_text_yes"),CafeModel.languageData.getTextById("btn_text_cancle")));
                     this.isoMouse.isOnObject = false;
               }
            }
            else
            {
               this.selectedItemFromWorld = false;
               layoutManager.isoScreen.isoWorld.removeIsoObject(this.isoMouse.iDragObject as VisualElement);
               this.isoMouse.iDragObject = null;
               if(_loc2_.getVisualVO().group == CafeConstants.GROUP_DOOR)
               {
                  layoutManager.isoScreen.isoWorld.door.show();
               }
            }
         }
      }
      
      override protected function onCursorOver(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton)
         {
            if((param1.target as BasicButton).enabled)
            {
               if(this.selectedItemWodId == -1)
               {
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               }
            }
         }
      }
      
      override protected function onCursorOut(param1:MouseEvent) : void
      {
         if(param1.target is BasicButton)
         {
            if(this.selectedItemWodId == -1)
            {
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            }
         }
      }
      
      private function addDragItem(param1:int) : void
      {
         if(this.selectedItemMc || CafeModel.wodData.voList[param1].group == CafeConstants.GROUP_EXPANSION)
         {
            return;
         }
         if(CafeModel.wodData.voList[param1].itemLevel > CafeModel.userData.userLevel)
         {
            this.selectedItemWodId = -1;
            return;
         }
         this.selectedItemWodId = param1;
         var _loc2_:Class = getDefinitionByName(CafeModel.wodData.voList[this.selectedItemWodId].getVisClassName()) as Class;
         this.selectedItemMc = new _loc2_();
         if(CafeModel.wodData.voList[this.selectedItemWodId].group == CafeConstants.GROUP_DOOR)
         {
            this.selectedItemMc.gotoAndStop(BasicDoor.DOOR_WITH_BORDER);
         }
         else
         {
            this.selectedItemMc.gotoAndStop(1);
         }
         layoutManager.dragLayer.addChild(this.selectedItemMc);
         this.selectedItemMc.x = layoutManager.dragLayer.mouseX;
         this.selectedItemMc.y = layoutManager.dragLayer.mouseY;
         this.selectedItemMc.mouseEnabled = false;
         this.selectedItemMc.mouseChildren = false;
         this.selectedItemMc.startDrag();
      }
      
      private function onCheckBuyAllowed(param1:ShopVO) : Boolean
      {
         switch(param1.group)
         {
            case CafeConstants.GROUP_VENDINGMACHINE:
               if(layoutManager.isoScreen.isoWorld.countIsoObjectByGroup(param1.group,false,param1.name) >= 1)
               {
                  return false;
               }
               break;
         }
         if(param1.itemGold > 0 && CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_PREMIUMDECO)
         {
            return false;
         }
         return true;
      }
      
      private function onCheckRemoveAllowed(param1:ShopVO, param2:Boolean) : int
      {
         var _loc3_:BasicFridgeVO = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         switch(param1.group)
         {
            case CafeConstants.GROUP_FRIDGE:
               _loc3_ = param1 as BasicFridgeVO;
               _loc4_ = layoutManager.isoScreen.isoWorld.getIsoObjectByGroup(param1.group).length;
               _loc5_ = CafeModel.inventoryFurniture.getInventoryAmountByGroup(param1.group);
               if((_loc4_ += _loc5_) <= 1)
               {
                  return 1;
               }
               if(param2 && CafeModel.inventoryFridge.capacity - _loc3_.inventroySize < 0)
               {
                  return 2;
               }
               break;
            case CafeConstants.GROUP_COUNTER:
            case CafeConstants.GROUP_STOVE:
               if(layoutManager.isoScreen.isoWorld.countIsoObjectByGroup(param1.group) <= 1)
               {
                  return 1;
               }
               break;
         }
         return 0;
      }
      
      private function onCheckStoreAllowed(param1:VisualElement) : int
      {
         var _loc2_:BasicFridgeVO = null;
         switch(param1.group)
         {
            case CafeConstants.GROUP_DOOR:
               if(!(param1 as BasicDoor).removeAllowed)
               {
                  return 2;
               }
            case CafeConstants.GROUP_FRIDGE:
               _loc2_ = param1.getVisualVO() as BasicFridgeVO;
               if(CafeModel.inventoryFridge.capacity - _loc2_.inventroySize < 0)
               {
                  return 2;
               }
               break;
            case CafeConstants.GROUP_COUNTER:
            case CafeConstants.GROUP_STOVE:
               if(layoutManager.isoScreen.isoWorld.getIsoObjectByGroup(param1.group).length <= 1)
               {
                  return 1;
               }
               if(param1 is BasicCounter && (param1 as BasicCounter).currentStatus != BasicCounter.COUNTER_STATUS_FREE)
               {
                  return 2;
               }
               if(param1 is BasicStove && (param1 as BasicStove).currentStatus != BasicStove.STOVE_STATUS_FREE)
               {
                  return 2;
               }
               if(!this.isoMouse.iDragObject.removeAllowed)
               {
                  return 2;
               }
               break;
            case CafeConstants.GROUP_VENDINGMACHINE:
               if((param1 as BasicVendingmachine).numFastFood > 0)
               {
                  return 3;
               }
               break;
         }
         return 0;
      }
      
      private function removeDragItem() : void
      {
         if(this.selectedItemMc)
         {
            this.selectedItemFromWorld = false;
            this.selectedItemMc.stopDrag();
            layoutManager.dragLayer.removeChild(this.selectedItemMc);
            this.selectedItemMc = null;
            this.lastSelectedItemWodId = this.selectedItemWodId;
            this.selectedItemWodId = -1;
            this.selectTile = false;
         }
      }
      
      private function changeCategory(param1:int) : void
      {
         this.currentCategory = param1;
         this.dekoShopPanel.gotoAndStop(this.currentCategory);
         switch(this.currentCategory)
         {
            case CATEGORY_DECO:
               this.dekoShopPanel.btn_deko_Chair.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_deko_Chair.name);
               this.dekoShopPanel.btn_deko_Table.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_deko_Table.name);
               this.dekoShopPanel.btn_deko_Deko.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_deko_Deko.name);
               this.dekoShopPanel.btn_deko_Tiles.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_deko_Tiles.name);
               this.dekoShopPanel.btn_deko_Wall.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_deko_Wall.name);
               this.dekoShopPanel.btn_deko_Door.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_deko_Door.name);
               this.dekoShopPanel.btn_deko_Wallobject.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_deko_Wallobject.name);
               this.changeGroup(CafeConstants.GROUP_CHAIR);
               break;
            case CATEGORY_FUNCTIONALS:
               this.dekoShopPanel.btn_functional_Stove.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_functional_Stove.name);
               this.dekoShopPanel.btn_functional_Counter.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_functional_Counter.name);
               this.dekoShopPanel.btn_functional_Fridge.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_functional_Fridge.name);
               if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_VENDINGMACHINE)
               {
                  this.dekoShopPanel.btn_functional_Extras.enableButton = false;
                  this.dekoShopPanel.btn_functional_Extras.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[CafeConstants.LEVEL_FOR_VENDINGMACHINE]);
               }
               else
               {
                  this.dekoShopPanel.btn_functional_Extras.enableButton = true;
                  this.dekoShopPanel.btn_functional_Extras.toolTipText = CafeModel.languageData.getTextById("tt_" + NAME + "_" + this.dekoShopPanel.btn_functional_Extras.name);
               }
               this.changeGroup(CafeConstants.GROUP_STOVE);
               break;
            case CATEGORY_EXPANSION:
               this.changeGroup(CafeConstants.GROUP_EXPANSION);
         }
         this.dekoShopPanel.btn_deko.mc_new.visible = false;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.dekoShopPanel.btn_arrowleft:
            case this.dekoShopPanel.btn_arrowright:
               this.onClickArrow(param1);
               break;
            case this.dekoShopPanel.btn_close:
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_MODE,[0]);
               break;
            case this.dekoShopPanel.btn_deko:
               if(this.currentCategory != CATEGORY_DECO)
               {
                  this.changeCategory(CATEGORY_DECO);
               }
               break;
            case this.dekoShopPanel.btn_functional:
               if(this.currentCategory != CATEGORY_FUNCTIONALS)
               {
                  this.changeCategory(CATEGORY_FUNCTIONALS);
               }
               break;
            case this.dekoShopPanel.btn_expansion:
               if((param1.target as BasicButton).enabled)
               {
                  if(this.currentCategory != CATEGORY_EXPANSION)
                  {
                     this.changeCategory(CATEGORY_EXPANSION);
                  }
               }
               break;
            case this.dekoShopPanel.btn_deko_Chair:
               if(this.currentGroup != CafeConstants.GROUP_CHAIR)
               {
                  this.changeGroup(CafeConstants.GROUP_CHAIR);
               }
               break;
            case this.dekoShopPanel.btn_deko_Table:
               if(this.currentGroup != CafeConstants.GROUP_TABLE)
               {
                  this.changeGroup(CafeConstants.GROUP_TABLE);
               }
               break;
            case this.dekoShopPanel.btn_deko_Deko:
               if(this.currentGroup != CafeConstants.GROUP_DECO)
               {
                  this.changeGroup(CafeConstants.GROUP_DECO);
               }
               break;
            case this.dekoShopPanel.btn_deko_Tiles:
               if(this.currentGroup != CafeConstants.GROUP_TILE)
               {
                  this.changeGroup(CafeConstants.GROUP_TILE);
               }
               break;
            case this.dekoShopPanel.btn_deko_Wall:
               if(this.currentGroup != CafeConstants.GROUP_WALL)
               {
                  this.changeGroup(CafeConstants.GROUP_WALL);
               }
               break;
            case this.dekoShopPanel.btn_deko_Door:
               if(this.currentGroup != CafeConstants.GROUP_DOOR)
               {
                  this.changeGroup(CafeConstants.GROUP_DOOR);
               }
               break;
            case this.dekoShopPanel.btn_deko_Wallobject:
               if(this.currentGroup != CafeConstants.GROUP_WALLOBJECT)
               {
                  this.changeGroup(CafeConstants.GROUP_WALLOBJECT);
               }
               break;
            case this.dekoShopPanel.btn_functional_Stove:
               if(this.currentGroup != CafeConstants.GROUP_STOVE)
               {
                  this.changeGroup(CafeConstants.GROUP_STOVE);
               }
               break;
            case this.dekoShopPanel.btn_functional_Counter:
               if(this.currentGroup != CafeConstants.GROUP_COUNTER)
               {
                  this.changeGroup(CafeConstants.GROUP_COUNTER);
               }
               break;
            case this.dekoShopPanel.btn_functional_Fridge:
               if(this.currentGroup != CafeConstants.GROUP_FRIDGE)
               {
                  this.changeGroup(CafeConstants.GROUP_FRIDGE);
               }
               break;
            case this.dekoShopPanel.btn_functional_Extras:
               if((param1.target as BasicButton).enabled)
               {
                  if(this.currentGroup != CafeConstants.GROUP_VENDINGMACHINE)
                  {
                     this.changeGroup(CafeConstants.GROUP_VENDINGMACHINE);
                  }
               }
               break;
            case this.dekoShopPanel.j0:
            case this.dekoShopPanel.j1:
            case this.dekoShopPanel.j2:
            case this.dekoShopPanel.j3:
            case this.dekoShopPanel.j4:
               if(this.currentCategory != CATEGORY_EXPANSION && !this.newObjectWasOnMap && this.currentGroup != CafeConstants.GROUP_TILE)
               {
                  layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("panelwin_deco_dragtip_title"),CafeModel.languageData.getTextById("panelwin_deco_dragtip_copy")));
               }
               break;
            case this.dekoShopPanel.j0.btn_buy:
            case this.dekoShopPanel.j1.btn_buy:
            case this.dekoShopPanel.j2.btn_buy:
            case this.dekoShopPanel.j3.btn_buy:
            case this.dekoShopPanel.j4.btn_buy:
               this.onBuyExtend(param1);
               break;
            case this.dekoShopPanel.j0.btn_unlock:
            case this.dekoShopPanel.j1.btn_unlock:
            case this.dekoShopPanel.j2.btn_unlock:
            case this.dekoShopPanel.j3.btn_unlock:
            case this.dekoShopPanel.j4.btn_unlock:
               this.onUnlockExpand(param1);
               break;
            case this.dekoShopPanel.btn_decoshophelp:
               layoutManager.showDialog(CafeDecoshopHelpDialog.NAME);
               break;
            case this.dekoShopPanel.j0.btn_unlockWithFriends:
            case this.dekoShopPanel.j1.btn_unlockWithFriends:
            case this.dekoShopPanel.j2.btn_unlockWithFriends:
            case this.dekoShopPanel.j3.btn_unlockWithFriends:
            case this.dekoShopPanel.j4.btn_unlockWithFriends:
               CafeModel.socialData.inviteFriends();
         }
      }
      
      private function setBlockLayer() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DekoShopItem = null;
         var _loc1_:Array = [];
         this.dekoShopPanel.blockLayer.visible = false;
         switch(this.currentGroup)
         {
            case CafeConstants.GROUP_STOVE:
               _loc1_ = layoutManager.isoScreen.isoWorld.getIsoObjectByGroup(this.currentGroup);
               if(_loc1_.length >= CafeModel.userData.levelXpRelation.stove)
               {
                  _loc2_ = CafeModel.userData.levelByGroupRelation("stove",CafeModel.userData.levelXpRelation.stove + 1);
                  if(_loc2_ < 0)
                  {
                     this.dekoShopPanel.blockLayer.blockText.text = CafeModel.languageData.getTextById("panelwin_deco_objectcount_nomore_stove");
                  }
                  else
                  {
                     this.dekoShopPanel.blockLayer.blockText.text = CafeModel.languageData.getTextById("panelwin_deco_objectcount_stove",[_loc2_]);
                  }
                  this.dekoShopPanel.blockLayer.visible = true;
               }
               break;
            case CafeConstants.GROUP_COUNTER:
               _loc1_ = layoutManager.isoScreen.isoWorld.getIsoObjectByGroup(this.currentGroup);
               if(_loc1_.length >= CafeModel.userData.levelXpRelation.counter)
               {
                  _loc2_ = CafeModel.userData.levelByGroupRelation("counter",CafeModel.userData.levelXpRelation.counter + 1);
                  if(_loc2_ < 0)
                  {
                     this.dekoShopPanel.blockLayer.blockText.text = CafeModel.languageData.getTextById("panelwin_deco_objectcount_nomore_counter");
                  }
                  else
                  {
                     this.dekoShopPanel.blockLayer.blockText.text = CafeModel.languageData.getTextById("panelwin_deco_objectcount_counter",[_loc2_]);
                  }
                  this.dekoShopPanel.blockLayer.visible = true;
               }
               break;
            case CafeConstants.GROUP_FRIDGE:
               _loc1_ = layoutManager.isoScreen.isoWorld.getIsoObjectByGroup(this.currentGroup);
               if(_loc1_.length >= CafeModel.userData.levelXpRelation.fridge)
               {
                  _loc2_ = CafeModel.userData.levelByGroupRelation("fridge",CafeModel.userData.levelXpRelation.fridge + 1);
                  if(_loc2_ < 0)
                  {
                     this.dekoShopPanel.blockLayer.blockText.text = CafeModel.languageData.getTextById("panelwin_deco_objectcount_nomore_fridge");
                  }
                  else
                  {
                     this.dekoShopPanel.blockLayer.blockText.text = CafeModel.languageData.getTextById("panelwin_deco_objectcount_fridge",[_loc2_]);
                  }
                  this.dekoShopPanel.blockLayer.visible = true;
               }
               break;
            case CafeConstants.GROUP_EXPANSION:
               _loc3_ = this.dekoShopPanel["j0"] as DekoShopItem;
               if(_loc3_ && !_loc3_.visible)
               {
                  this.dekoShopPanel.blockLayer.blockText.text = CafeModel.languageData.getTextById("panelwin_deco_nomore_expansion");
                  this.dekoShopPanel.blockLayer.visible = true;
               }
         }
      }
      
      private function changeGroup(param1:String) : void
      {
         this.currentGroup = param1;
         this.currentPage = 0;
         this.fillItemsByGroup();
         this.setBlockLayer();
      }
      
      private function onSellInventory(param1:Array) : void
      {
         var _loc2_:int = param1[1];
         if(_loc2_ > 0)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_SELL_OBJECT,[-1,-1,this.sellItemWodId,_loc2_]);
         }
         this.removeDragItem();
         this.sellItemWodId = -1;
      }
      
      private function onSellMap(param1:Array) : void
      {
         var _loc2_:IsoStaticObject = this.isoMouse.iDragObject as IsoStaticObject;
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_SELL_OBJECT,[_loc2_.oldIsoPos.x,_loc2_.oldIsoPos.y,this.sellItemWodId,1]);
         this.isoMouse.removeIDragObject();
         this.isoMouse.onMouseUp(null);
         this.removeDragItem();
         this.sellItemWodId = -1;
      }
      
      private function onNotSellMap(param1:Array) : void
      {
         this.isoMouse.resetDragObject();
         this.isoMouse.onMouseUp(null);
         this.sellItemWodId = -1;
         this.tempDragObject = null;
      }
      
      private function fillItemsByGroup() : void
      {
         var _loc7_:DekoShopItem = null;
         var _loc8_:Class = null;
         var _loc9_:MovieClip = null;
         var _loc10_:Rectangle = null;
         var _loc11_:newIcon = null;
         var _loc1_:int = this.currentPage * this.itemsPerPage;
         var _loc2_:int = _loc1_;
         var _loc3_:Array = this.getFilteredArray();
         this.initArrows(_loc3_.length);
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < this.itemsPerPage)
         {
            (_loc7_ = this.dekoShopPanel["j" + _loc6_] as DekoShopItem).mc_content.mouseChildren = false;
            _loc7_.mouseChildren = false;
            _loc7_.useHandCursor = true;
            _loc7_.buttonMode = true;
            if(_loc2_ < _loc3_.length)
            {
               _loc5_++;
               _loc7_.visible = true;
               _loc7_.wodId = _loc3_[_loc2_].wodId;
               _loc7_.toolTipText = String(_loc3_[_loc2_].getLuxury());
               (_loc9_ = new (_loc8_ = getDefinitionByName(_loc3_[_loc2_].getVisClassName()) as Class)()).gotoAndStop(this.currentGroup == CafeConstants.GROUP_DOOR ? 3 : 1);
               _loc10_ = _loc9_.getBounds(null);
               _loc4_ = this.MAX_WIDTH / _loc10_.width;
               if(_loc10_.height * _loc4_ > this.MAX_HEIGHT)
               {
                  _loc4_ = this.MAX_HEIGHT / _loc10_.height;
               }
               _loc9_.x = -(_loc10_.width * _loc4_ / 2 + _loc10_.left * _loc4_);
               _loc9_.y = -(_loc10_.height * _loc4_ / 2 + _loc10_.top * _loc4_);
               _loc9_.scaleX = _loc9_.scaleY = _loc4_;
               while(_loc7_.mc_content.mc_itemholder.numChildren > 0)
               {
                  _loc7_.mc_content.mc_itemholder.removeChildAt(0);
               }
               _loc7_.mc_content.mc_itemholder.addChild(_loc9_);
               if(_loc3_[_loc2_].isNew)
               {
                  _loc11_ = new newIcon();
                  updateTextField(_loc11_.txt_label);
                  _loc11_.txt_label.text = CafeModel.languageData.getTextById("new");
                  _loc11_.x = -50;
                  _loc11_.y = -_loc7_.mc_content.mc_itemholder.height / 2;
                  _loc11_.rotation = -30;
                  _loc7_.mc_content.mc_itemholder.addChild(_loc11_);
               }
               if(_loc3_[_loc2_].itemCash > 0)
               {
                  _loc7_.mc_content.txt_price.text = NumberStringHelper.groupString(_loc3_[_loc2_].itemCash,CafeModel.languageData.getTextById);
                  _loc7_.mc_money.gotoAndStop(1);
               }
               else
               {
                  _loc7_.mc_content.txt_price.text = NumberStringHelper.groupString(_loc3_[_loc2_].itemGold,CafeModel.languageData.getTextById);
                  _loc7_.mc_money.gotoAndStop(2);
               }
               this.checkShopItemState(_loc7_,_loc3_[_loc2_]);
            }
            else
            {
               _loc7_.visible = false;
            }
            _loc2_++;
            _loc6_++;
         }
         if(_loc5_ < 1 && this.maxPage > 1)
         {
            this.currentPage = Math.max(0,this.currentPage - 1);
            this.fillItemsByGroup();
         }
      }
      
      private function getFilteredArray() : Array
      {
         var _loc4_:ShopVO = null;
         var _loc5_:BasicExpansionVO = null;
         var _loc6_:BasicExpansionVO = null;
         var _loc1_:String = this.currentGroup.toLowerCase();
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         for each(_loc4_ in CafeModel.dekoShop[_loc1_])
         {
            if(this.onCheckBuyAllowed(_loc4_))
            {
               _loc4_.isNew = CafeConstants.serverTimeStamp - _loc4_.releaseDate < CafeConstants.NEW_SHOPITEM_LEFTTIME || _loc4_.highestEventId > 0 && _loc4_.isItemAvalibleByEvent();
               if(_loc4_.group == CafeConstants.GROUP_EXPANSION)
               {
                  if((_loc5_ = _loc4_ as BasicExpansionVO).expansionId > CafeModel.levelData.levelVO.expansionId)
                  {
                     _loc2_.push(_loc4_);
                     if(_loc5_.friends > 0 && _loc5_.friends > CafeModel.buddyList.amountSocialFriends)
                     {
                        (_loc6_ = CafeModel.wodData.createVObyWOD(_loc4_.wodId) as BasicExpansionVO).friends = -1;
                        _loc2_.push(_loc6_);
                     }
                  }
               }
               else if((_loc4_.itemCash > 0 || _loc4_.itemGold > 0 || _loc4_.goldNoFriends > 0) && _loc4_.isItemAvalibleByEvent() || CafeModel.inventoryFurniture.getInventoryAmountByWodId(_loc4_.wodId))
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         if(this.currentGroup == CafeConstants.GROUP_EXPANSION)
         {
            _loc2_.sortOn(["expansionId","itemCash","itemGold","wodId"],[Array.NUMERIC,Array.NUMERIC,Array.NUMERIC,Array.NUMERIC]);
         }
         else
         {
            _loc2_.sortOn(["isNew","itemCash","itemGold","wodId"],[Array.DESCENDING,Array.NUMERIC,Array.NUMERIC,Array.NUMERIC]);
         }
         return _loc2_;
      }
      
      private function checkShopItemState(param1:DekoShopItem, param2:ShopVO) : void
      {
         var _loc3_:BasicExpansionVO = null;
         param1.mc_friends.gotoAndStop(3);
         param1.mc_friends.visible = false;
         param1.mc_content.txt_amountFriends.text = "";
         param1.mc_content.txt_level.text = "";
         if(param2.group == CafeConstants.GROUP_EXPANSION)
         {
            _loc3_ = param2 as BasicExpansionVO;
            param1.friends = _loc3_.friends;
            if(param2.itemLevel <= CafeModel.userData.userLevel && _loc3_.expansionId == CafeModel.levelData.levelVO.expansionId + 1)
            {
               param1.mouseChildren = true;
               if(env.hasNetworkBuddies && CafeModel.buddyList.amountSocialFriends < param2.friends)
               {
                  param1.gotoAndStop(4);
                  param1.btn_unlockWithFriends.visible = true;
                  param1.btn_unlockWithFriends.toolTipText = CafeModel.languageData.getTextById("tt_CafeDekoShopPanel_btn_invitefriends",[param2.friends - CafeModel.buddyList.amountSocialFriends]);
                  param1.mc_content.txt_level.text = "";
                  if(param2.itemCash == 0)
                  {
                     param1.mc_money.gotoAndStop(2);
                     param1.mc_content.txt_price.text = param2.itemGold + "";
                  }
                  else
                  {
                     param1.mc_money.gotoAndStop(1);
                     param1.mc_content.txt_price.text = NumberStringHelper.groupString(param2.itemCash,CafeModel.languageData.getTextById);
                  }
                  param1.mc_friends.visible = true;
                  param1.mc_content.txt_amountFriends.text = param2.friends - CafeModel.buddyList.amountSocialFriends + "";
               }
               else
               {
                  param1.gotoAndStop(2);
                  if(env.hasNetworkBuddies && param2.friends > 0)
                  {
                     param1.mc_money.gotoAndStop(2);
                     param1.mc_content.txt_price.text = "0";
                  }
                  else if(param2.friends == -1)
                  {
                     if(param2.itemCash == 0)
                     {
                        param1.mc_money.gotoAndStop(2);
                        param1.mc_content.txt_price.text = param2.goldNoFriends + "";
                     }
                     else
                     {
                        param1.mc_money.gotoAndStop(1);
                        param1.mc_content.txt_price.text = NumberStringHelper.groupString(param2.itemCash,CafeModel.languageData.getTextById);
                     }
                  }
               }
            }
            else
            {
               param1.gotoAndStop(3);
               param1.btn_unlock.visible = false;
               param1.mc_content.txt_level.text = "";
               if(param2.friends > 0 && CafeModel.buddyList.amountSocialFriends < param2.friends)
               {
                  param1.mc_friends.visible = true;
                  param1.mc_content.txt_amountFriends.text = param2.friends - CafeModel.buddyList.amountSocialFriends + "";
                  param1.mc_money.gotoAndStop(2);
                  param1.mc_content.txt_price.text = param2.itemGold + "";
               }
               else if(param2.friends < 1 && param2.goldNoFriends > 0)
               {
                  if(param2.itemCash == 0)
                  {
                     param1.mc_money.gotoAndStop(2);
                     param1.mc_content.txt_price.text = param2.goldNoFriends + "";
                  }
                  else
                  {
                     param1.mc_money.gotoAndStop(1);
                     param1.mc_content.txt_price.text = NumberStringHelper.groupString(param2.itemCash,CafeModel.languageData.getTextById);
                  }
               }
               param1.mouseChildren = true;
               if(param2.itemLevel > CafeModel.userData.userLevel)
               {
                  param1.mc_content.txt_level.text = CafeModel.languageData.getTextById("level") + " " + param2.itemLevel;
                  param1.mc_key.toolTipText = CafeModel.languageData.getTextById("tt_CafeDekoShopPanel_cashexpansion",[param2.itemLevel]);
               }
               else
               {
                  param1.mc_content.txt_level.text = "";
                  param1.mc_key.toolTipText = CafeModel.languageData.getTextById("tt_CafeDekoShopPanel_invalidexpansion");
               }
               param1.mc_key.mouseChildren = false;
            }
         }
         else if(param2.itemLevel <= CafeModel.userData.userLevel)
         {
            param1.gotoAndStop(1);
            param1.mc_storage.txt_amount.text = CafeModel.inventoryFurniture.getInventoryAmountByWodId(param2.wodId) + "x";
         }
         else
         {
            param1.mc_content.txt_level.text = CafeModel.languageData.getTextById("level") + " " + param2.itemLevel;
            param1.gotoAndStop(3);
            param1.btn_unlock.visible = false;
         }
      }
      
      private function onUnlockExpand(param1:MouseEvent) : void
      {
         var _loc3_:ShopVO = null;
         var _loc2_:MovieClip = param1.target.parent as MovieClip;
         if(_loc2_)
         {
            _loc3_ = CafeModel.wodData.voList[_loc2_.wodId] as ShopVO;
            if(_loc3_)
            {
               layoutManager.showDialog(CafeOrderCompanyDialog.NAME,new CafeOrderCompanyDialogProperties(CafeModel.languageData.getTextById("dialogwin_FriendShop_title"),CafeModel.languageData.getTextById("dialogwin_FriendShop_copy",[_loc3_.friends - CafeModel.buddyList.amountSocialFriends,_loc3_.goldNoFriends,env.networknameString]),_loc3_.goldNoFriends,_loc3_.wodId,this.onInfiteFriend,this.onBuyExpensivExtend,CafeModel.languageData.getTextById("btn_text_goback")));
            }
         }
      }
      
      private function onInfiteFriend(param1:Array) : void
      {
         CafeModel.socialData.inviteFriends();
      }
      
      private function onBuyExpensivExtend(param1:Array) : void
      {
         var _loc2_:int = param1.shift();
         if(_loc2_ > 0)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_EXTEND,[_loc2_,0]);
         }
      }
      
      private function onBuyExtend(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target.parent as MovieClip;
         if(_loc2_)
         {
            if(_loc2_.friends > 0)
            {
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_EXTEND,[_loc2_.wodId,1]);
            }
            else
            {
               CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_EDITOR_EXTEND,[_loc2_.wodId,0]);
            }
         }
      }
      
      override public function show() : void
      {
         super.show();
         if(CafeModel.dekoShop.openFor == CafeDekoShop.OPEN_FOR_VENDINGMACHINES)
         {
            this.changeCategory(CATEGORY_FUNCTIONALS);
            this.changeGroup(CafeConstants.GROUP_VENDINGMACHINE);
            CafeModel.dekoShop.openFor = 0;
         }
         else
         {
            this.changeCategory(CATEGORY_DECO);
         }
         this.dekoShopPanel.mc_decotooltip.visible = false;
         layoutManager.isoScreen.isoWorld.addEventListener(IsoWorldEvent.WORLD_CHANGE,this.onRemovedraggfx);
      }
      
      override public function hide() : void
      {
         layoutManager.isoScreen.isoWorld.removeEventListener(IsoWorldEvent.WORLD_CHANGE,this.onRemovedraggfx);
         this.removeDragItem();
         super.hide();
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            disp.y = disp.stage.stageHeight;
            disp.x = disp.stage.stageWidth / 2;
            if(env.hasNetworkBuddies)
            {
               disp.y -= CafeBuddylistPanel.BUDDY_PANEL_HEIGHT;
            }
         }
      }
      
      protected function get dekoShopPanel() : DekoShopPanel
      {
         return disp as DekoShopPanel;
      }
   }
}
