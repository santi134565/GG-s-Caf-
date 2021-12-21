package com.goodgamestudios.cafe.world.objects.background
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeMuffinGameDialog;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class CafeBackground extends StaticBackground
   {
       
      
      private var btn_muffinBaker:MovieClip;
      
      private var muffinManPlaced:Boolean = false;
      
      public function CafeBackground()
      {
         super();
         isMutable = true;
         isClickable = true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         BasicController.getInstance().addEventListener(CafeUserEvent.LEVELUP,this.checkOrDrawMuffinMan);
         this.checkOrDrawMuffinMan();
      }
      
      override public function updateToolTipTextFields() : void
      {
         super.updateToolTipTextFields();
         this.checkOrDrawMuffinMan();
      }
      
      private function checkOrDrawMuffinMan(param1:Event = null) : void
      {
         if(disp.hasOwnProperty("btn_muffinBaker"))
         {
            if(CafeModel.userData.userLevel < CafeConstants.LEVEL_FOR_MUFFINMAN)
            {
               disp["btn_muffinBaker"].visible = false;
               disp["muffinbaker_Tooltip"].visible = false;
               return;
            }
            this.btn_muffinBaker = disp["btn_muffinBaker"];
            initInteractiveItem(this.btn_muffinBaker);
            disp["btn_muffinBaker"].visible = true;
            disp["muffinbaker_Tooltip"].visible = false;
            disp["muffinbaker_Tooltip"].mouseEnabled = false;
            disp["muffinbaker_Tooltip"].mouseChildren = false;
            disp["muffinbaker_Tooltip"].txt_emptyInfoLine1.text = CafeModel.languageData.getTextById("muffinmantooltip_line1");
            disp["muffinbaker_Tooltip"].txt_emptyInfoLine2.text = CafeModel.languageData.getTextById("muffinmantooltip_line2");
            updateTextField(disp["muffinbaker_Tooltip"].txt_emptyInfoLine1);
            updateTextField(disp["muffinbaker_Tooltip"].txt_emptyInfoLine2);
            BasicController.getInstance().addEventListener(CafeUserEvent.BONUS,this.placeMuffinMan);
         }
      }
      
      override protected function updateVisualRep(param1:Number) : void
      {
         if(this.btn_muffinBaker && !this.muffinManPlaced && world.map.grid)
         {
            this.placeMuffinMan();
         }
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         if(CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_DEKO_SHOP)
         {
            return;
         }
         if(param1.target == this.btn_muffinBaker)
         {
            disp["muffinbaker_Tooltip"].visible = true;
            this.btn_muffinBaker.filters = [glowfilter];
            CafeLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         if(param1.target == this.btn_muffinBaker)
         {
            disp["muffinbaker_Tooltip"].visible = false;
            this.btn_muffinBaker.filters = [];
            CafeLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         if(CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_DEKO_SHOP)
         {
            return;
         }
         switch(param1.target)
         {
            case this.btn_muffinBaker:
               if(CafeTutorialController.getInstance().isActive)
               {
                  return;
               }
               if(CafeLayoutManager.getInstance().isoScreen.isoWorld.myPlayer.isWorking)
               {
                  CafeLayoutManager.getInstance().showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")));
               }
               else
               {
                  CafeLayoutManager.getInstance().showDialog(CafeMuffinGameDialog.NAME);
               }
               break;
         }
      }
      
      override public function removeDispFromWorld() : void
      {
         if(BasicController.getInstance().hasEventListener(CafeUserEvent.BONUS))
         {
            BasicController.getInstance().removeEventListener(CafeUserEvent.BONUS,this.placeMuffinMan);
         }
         if(BasicController.getInstance().hasEventListener(CafeUserEvent.LEVELUP))
         {
            BasicController.getInstance().removeEventListener(CafeUserEvent.LEVELUP,this.checkOrDrawMuffinMan);
         }
         super.removeDispFromWorld();
      }
      
      private function placeMuffinMan(param1:Event = null) : void
      {
         var _loc2_:Point = world.map.grid.gridPosToPixelPos(new Point(world.map.mapSize.x + 0.5,-1.8));
         this.btn_muffinBaker.x = _loc2_.x;
         this.btn_muffinBaker.y = _loc2_.y;
         this.muffinManPlaced = true;
         disp["muffinbaker_Tooltip"].x = this.btn_muffinBaker.x - this.btn_muffinBaker.width / 5;
         disp["muffinbaker_Tooltip"].y = this.btn_muffinBaker.y;
      }
   }
}
