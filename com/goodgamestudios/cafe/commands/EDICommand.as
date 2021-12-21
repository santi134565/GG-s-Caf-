package com.goodgamestudios.cafe.commands
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   
   public class EDICommand extends CafeCommand
   {
       
      
      public function EDICommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_EDITOR_MODE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:NpcMovingVO = null;
         if(param1 == 0)
         {
            CafeModel.inventoryFurniture.numNew = 0;
            cafeIsoWorld.updateObjects(param2[4]);
            if(param2[1] == CafeIsoWorld.CAFE_STATUS_RUN)
            {
               CafeModel.userData.heroVO.isoX = param2[2];
               CafeModel.userData.heroVO.isoY = param2[3];
               cafeIsoWorld.spawnPlayer(VisualVO(CafeModel.userData.heroVO));
               for each(_loc3_ in DictionaryUtil.getValues(CafeModel.npcStaffData.members))
               {
                  cafeIsoWorld.spawnNpc(VisualVO(_loc3_));
               }
               layoutManager.state = CafeLayoutManager.STATE_MY_CAFE;
               cafeIsoWorld.changeWorldStatus(CafeIsoWorld.CAFE_STATUS_RUN);
            }
            else if(param2[1] == CafeIsoWorld.CAFE_STATUS_DEKO)
            {
               layoutManager.state = CafeLayoutManager.STATE_DEKO_SHOP;
               cafeIsoWorld.changeWorldStatus(CafeIsoWorld.CAFE_STATUS_DEKO);
            }
            return true;
         }
         layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("edit_error"),CafeModel.languageData.getTextById("editmode_errorcode_" + param1)));
         return false;
      }
   }
}
