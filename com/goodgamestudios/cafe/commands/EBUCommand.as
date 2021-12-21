package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.CafeSoundController;
   import com.goodgamestudios.cafe.event.CafeEditorEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoMap;
   import com.goodgamestudios.cafe.world.objects.door.BasicDoor;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   import com.goodgamestudios.isocore.objects.WallObject;
   import flash.geom.Point;
   
   public class EBUCommand extends CafeCommand
   {
       
      
      public function EBUCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EDITOR_BUY_OBJECT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc6_:ShopVO = null;
         var _loc7_:WallObject = null;
         var _loc8_:BasicDoor = null;
         var _loc9_:BasicDoor = null;
         var _loc3_:int = param2[3];
         var _loc4_:Point = new Point(param2[1],param2[2]);
         var _loc5_:int = param2[4];
         cafeIsoWorld.mouse.unLockDragObject();
         cafeIsoWorld.mouse.removeIDragObject();
         if(param1 == 0)
         {
            _loc6_ = CafeModel.wodData.createVObyWOD(_loc3_) as ShopVO;
            if(!CafeModel.inventoryFurniture.hasItem(_loc3_))
            {
               CafeModel.userData.checkMoneyChanges(-_loc6_.itemCash,-_loc6_.itemGold);
               CafeSoundController.getInstance().playSoundEffect(CafeSoundController.SND_BUYSELL);
            }
            else
            {
               CafeModel.inventoryFurniture.removeItem(_loc3_);
            }
            _loc6_.rotationDir = _loc5_;
            switch(_loc6_.group)
            {
               case CafeConstants.GROUP_FRIDGE:
                  CafeModel.inventoryFridge.addCapacity((_loc6_ as BasicFridgeVO).inventroySize);
                  _loc6_.isoPos = _loc4_;
                  cafeIsoWorld.addIsoObject(_loc6_);
                  break;
               case CafeConstants.GROUP_WALLOBJECT:
                  _loc6_.isoPos = _loc4_;
                  (_loc7_ = cafeIsoWorld.addLevelElement(_loc6_) as WallObject).setBlockedTiles();
                  break;
               case CafeConstants.GROUP_WALL:
                  CafeModel.inventoryFurniture.addItem((cafeIsoWorld.map as CafeIsoMap).getWallWodId(_loc4_));
                  (cafeIsoWorld.map as CafeIsoMap).changeWall(_loc4_,_loc6_);
                  break;
               case CafeConstants.GROUP_DOOR:
                  _loc8_ = cafeIsoWorld.door;
                  CafeModel.inventoryFurniture.addItem(_loc8_.getVisualVO().wodId);
                  cafeIsoWorld.removeIsoObject(_loc8_);
                  _loc6_.isoPos = _loc4_;
                  cafeIsoWorld.addIsoObject(_loc6_);
                  break;
               default:
                  _loc6_.isoPos = _loc4_;
                  cafeIsoWorld.addIsoObject(_loc6_);
            }
            controller.dispatchEvent(new CafeEditorEvent(CafeEditorEvent.BUY_ITEM));
            CafeModel.levelData.checkLevelLuxury(cafeIsoWorld.getIsoObjectLuxury());
            return true;
         }
         if(CafeModel.wodData.voList[_loc3_].group == CafeConstants.GROUP_DOOR)
         {
            (_loc9_ = cafeIsoWorld.door).show();
            _loc9_.stopDrag();
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_copy")));
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("edit_error"),CafeModel.languageData.getTextById("editbuy_errorcode_" + param1)));
         }
         return false;
      }
   }
}
