package com.goodgamestudios.cafe.world.objects.vendingmachine
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.view.dialogs.CafeStandardOkDialog;
   import com.goodgamestudios.cafe.world.CafeIsoWorld;
   import com.goodgamestudios.cafe.world.info.ExtrasToolTip;
   import com.goodgamestudios.cafe.world.objects.CafeInteractiveFloorObject;
   import com.goodgamestudios.cafe.world.objects.moving.NpcguestMoving;
   import com.goodgamestudios.cafe.world.vo.fastfood.BasicFastfoodVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import com.goodgamestudios.cafe.world.vo.vendingmachine.BasicVendingmachineVO;
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BasicVendingmachine extends CafeInteractiveFloorObject
   {
      
      public static const VENDING_STATUS_EMPTY:int = 0;
      
      public static const VENDING_STATUS_FULL:int = 1;
      
      public static const VENDING_STATUS_INUSE:int = 2;
       
      
      private var infoToolTip:ExtrasToolTip;
      
      public var currentStatus:int;
      
      protected var refillFastFood:BasicFastfoodVO;
      
      protected var refillAmount:int;
      
      protected var tempNum:int = -1;
      
      public function BasicVendingmachine()
      {
         super();
         isClickable = true;
         isMutable = true;
      }
      
      override protected function initVisualRep() : void
      {
         super.initVisualRep();
         this.infoToolTip = new ExtrasToolTip(this);
         world.toolTipLayer.addChild(this.infoToolTip.disp);
         world.addEventListener(IsoWorldEvent.SWITCH_WORLD_STATE,this.onWorldChanged);
      }
      
      protected function updateStatus() : void
      {
         if(this.numFastFood <= 0)
         {
            this.currentStatus = VENDING_STATUS_EMPTY;
         }
         else
         {
            this.currentStatus = VENDING_STATUS_FULL;
         }
      }
      
      override protected function onMouseUpRun(param1:MouseEvent) : void
      {
         if(this.currentStatus > VENDING_STATUS_EMPTY)
         {
            this.onClickError_NotEmpty();
         }
      }
      
      override public function update(param1:Number) : void
      {
         if(this.refillAmount && this.refillFastFood)
         {
            if(this.tempNum < this.refillAmount)
            {
               if(this.tempNum == -1)
               {
                  this.usedFastFoodWodId = this.refillFastFood.wodId;
               }
               ++this.tempNum;
               this.updateGraphics();
            }
            else
            {
               this.tempNum = -1;
               (vo as BasicVendingmachineVO).fastfoodAmount = this.refillAmount;
               this.refillAmount = 0;
               this.refillFastFood = null;
            }
         }
      }
      
      protected function updateGraphics() : void
      {
      }
      
      public function onNpcUsage(param1:NpcguestMoving) : void
      {
         if(!param1.canReachObject(isoGridPos))
         {
            this.layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("alert_smoothiemaker_outofreach_copy")));
            return;
         }
         if(!(world as CafeIsoWorld).map.isOnPlayMap(this.frontTile))
         {
            this.layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("alert_smoothiemaker_outofreach_copy")));
            return;
         }
         if(this.numFastFood <= 0)
         {
            this.layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_stove_outofreach_title"),CafeModel.languageData.getTextById("dialogwin_smoothiemaker_noservings_copy")));
            return;
         }
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_FASTFOOD_NPC,[(param1.getVisualVO() as NpcMovingVO).npcId,isoX,isoY]);
      }
      
      protected function onClickError_NotEmpty() : void
      {
      }
      
      override protected function onRollOverRun(param1:MouseEvent) : void
      {
         if(isClickable)
         {
            addGlow();
            CafeLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
         if(cafeIsoWorld.cafeWorldType == CafeConstants.CAFE_WORLD_TYPE_MYCAFE)
         {
            this.showInfoToolTip();
         }
      }
      
      override protected function onRollOutRun(param1:MouseEvent) : void
      {
         CafeLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         this.infoToolTip.hide();
         removeGlow();
      }
      
      public function removeFastFood() : BasicFastfoodVO
      {
         --(vo as BasicVendingmachineVO).fastfoodAmount;
         this.updateStatus();
         this.updateGraphics();
         return CafeModel.wodData.voList[this.usedFastFoodWodId] as BasicFastfoodVO;
      }
      
      private function showInfoToolTip() : void
      {
         if(this.numFastFood > 0)
         {
            this.infoToolTip.showAmountToolTip(this.usedFastFoodWodId,this.numFastFood);
         }
         else
         {
            this.infoToolTip.showInfoToolTip();
         }
      }
      
      public function refillFastfood(param1:BasicFastfoodVO, param2:int) : void
      {
         this.refillFastFood = param1;
         this.refillAmount = param2;
         this.usedFastFoodWodId = param1.wodId;
      }
      
      protected function onWorldChanged(param1:IsoWorldEvent) : void
      {
      }
      
      public function get frontTile() : Point
      {
         switch(isoRotation)
         {
            case 0:
               return new Point(isoGridPos.x + 1,isoGridPos.y);
            case 1:
               return new Point(isoGridPos.x,isoGridPos.y - 1);
            case 2:
               return new Point(isoGridPos.x - 1,isoGridPos.y);
            case 3:
               return new Point(isoGridPos.x,isoGridPos.y + 1);
            default:
               return null;
         }
      }
      
      public function get numFastFood() : int
      {
         return (vo as BasicVendingmachineVO).fastfoodAmount;
      }
      
      public function get usedFastFoodWodId() : int
      {
         return (vo as BasicVendingmachineVO).fastfoodWodId;
      }
      
      public function get percentFilled() : Number
      {
         if(this.numFastFood < 1)
         {
            return 0;
         }
         return this.numFastFood / (CafeModel.wodData.voList[(vo as BasicVendingmachineVO).fastfoodWodId] as BasicFastfoodVO).baseServings;
      }
      
      override public function remove() : void
      {
         world.removeEventListener(IsoWorldEvent.WORLD_CHANGE,this.onWorldChanged);
         super.remove();
      }
      
      public function get vendingVO() : BasicVendingmachineVO
      {
         return vo as BasicVendingmachineVO;
      }
      
      public function set usedFastFoodWodId(param1:int) : void
      {
         (vo as BasicVendingmachineVO).fastfoodWodId = param1;
      }
      
      protected function get layoutManager() : CafeLayoutManager
      {
         return CafeLayoutManager.getInstance() as CafeLayoutManager;
      }
   }
}
