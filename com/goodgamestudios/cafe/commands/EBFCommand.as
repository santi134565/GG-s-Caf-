package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeNoMoneyDialogProperties;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   import flash.geom.Point;
   
   public class EBFCommand extends CafeCommand
   {
       
      
      public function EBFCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EDITOR_BUY_FLOOR;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:ShopVO = null;
         var _loc12_:Array = null;
         cafeIsoWorld.clearDrawTiles();
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = new Point(param2.shift(),param2.shift());
            _loc4_ = new Point(param2.shift(),param2.shift());
            _loc5_ = param2.shift();
            _loc7_ = (_loc6_ = param2.shift()).split("#");
            _loc8_ = param2.shift();
            _loc9_ = param2.shift();
            for each(_loc10_ in _loc7_)
            {
               _loc12_ = _loc10_.split("+");
               CafeModel.inventoryFurniture.addItem(_loc12_.shift(),_loc12_.shift());
            }
            CafeModel.inventoryFurniture.removeItem(_loc5_,_loc8_);
            _loc11_ = CafeModel.wodData.createVObyWOD(_loc5_) as ShopVO;
            CafeModel.userData.checkMoneyChanges(-(_loc11_.itemCash * _loc9_),0);
            cafeIsoWorld.map.changeFloorTextureRange(_loc3_,_loc4_,_loc11_);
            CafeModel.levelData.checkLevelLuxury(cafeIsoWorld.getIsoObjectLuxury());
            return true;
         }
         if(param1 == 4)
         {
            layoutManager.showDialog(CafeNoMoneyDialog.NAME,new CafeNoMoneyDialogProperties(CafeModel.languageData.getTextById("dialogwin_nomoney_title"),CafeModel.languageData.getTextById("dialogwin_nomoney_copy")));
         }
         return false;
      }
   }
}
