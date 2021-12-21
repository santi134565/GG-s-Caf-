package com.goodgamestudios.cafe.view.dialogs
{
   import com.adobe.utils.DictionaryUtil;
   import com.adobe.utils.StringUtil;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeNPCEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CafeStaffDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeStaffDialog";
      
      public static const SCALE_FACTOR:Number = 1.5;
       
      
      private var currentPage:int = 0;
      
      private var maxPage:int = 0;
      
      private var selectedMember:CafeStaffItem;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeStaffDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         controller.addEventListener(CafeNPCEvent.CHANGED_NAME,this.onWaiterlistUpdate);
         controller.addEventListener(CafeNPCEvent.WAITER_TRAINED,this.onWaiterlistUpdate);
         controller.addEventListener(CafeNPCEvent.WAITER_ADDED,this.onWaiterlistChanged);
         controller.addEventListener(CafeNPCEvent.WAITER_REMOVED,this.onWaiterlistChanged);
         controller.addEventListener(CafeUserEvent.LEVELUP,this.onWaiterlistChanged);
         super.init();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeNPCEvent.CHANGED_NAME,this.onWaiterlistUpdate);
         controller.removeEventListener(CafeNPCEvent.WAITER_TRAINED,this.onWaiterlistUpdate);
         controller.removeEventListener(CafeNPCEvent.WAITER_ADDED,this.onWaiterlistChanged);
         controller.removeEventListener(CafeNPCEvent.WAITER_REMOVED,this.onWaiterlistChanged);
         controller.removeEventListener(CafeUserEvent.LEVELUP,this.onWaiterlistChanged);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.staffDialog.mc_arrow_left:
            case this.staffDialog.mc_arrow_right:
               this.onClickArrow(param1);
               break;
            case this.staffDialog.btn_cancel:
               hide();
               break;
            case this.staffDialog.i0.btn_action:
            case this.staffDialog.i1.btn_action:
            case this.staffDialog.i2.btn_action:
            case this.staffDialog.i3.btn_action:
               this.onClickMemberAction(param1);
         }
      }
      
      private function onClickMemberAction(param1:MouseEvent) : void
      {
         if(this.isWaitingForServerMessage || !(param1.target as BasicButton).enabled)
         {
            return;
         }
         this.selectedMember = param1.target.parent as CafeStaffItem;
         var _loc2_:NpcMovingVO = CafeModel.npcStaffData.getNpcById(this.selectedMember.npcId);
         if(this.selectedMember.npcId < 0)
         {
            layoutManager.showDialog(CafeStaffHireDialog.NAME,new CafeStaffHireDialogProperties(CafeModel.languageData.getTextById("alert_staffhire_title"),CafeModel.languageData.getTextById("alert_staffhire_copy"),this.onHireMember,null,"x" + CafeConstants.staffPrice,CafeModel.languageData.getTextById("btn_text_cancle")));
         }
         else
         {
            layoutManager.showDialog(CafeStaffManagementDialog.NAME,new CafeStaffManagementDialogProperties(_loc2_.npc_name,_loc2_.favorite,this.onChangeNPC,this.onFireMember));
         }
      }
      
      private function onChangeNPC(param1:Array) : void
      {
         var _loc2_:String = param1.shift();
         var _loc3_:int = param1.shift();
         if(!this.selectedMember || !TextValide.isSmartFoxValide(_loc2_))
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("createavatar_error"),CafeModel.languageData.getTextById("waiter_name_invalide")));
         }
         else
         {
            this.isWaitingForServerMessage = true;
            this.selectedMember.mc_waitingcontainer.addChild(new ServerWaitingAnim());
            controller.sendServerMessageAndWait(SFConstants.C2S_NPC_CUSTOMIZE,[this.selectedMember.npcId,_loc2_,_loc3_],SFConstants.S2C_NPC_CUSTOMIZE);
         }
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_NPC_FIRE || param1 == SFConstants.S2C_NPC_CUSTOMIZE)
         {
            while(this.selectedMember.mc_waitingcontainer.numChildren > 0)
            {
               this.selectedMember.mc_waitingcontainer.removeChildAt(0);
            }
            this.isWaitingForServerMessage = false;
         }
      }
      
      private function onWaiterlistUpdate(param1:CafeNPCEvent) : void
      {
         this.fillItems();
      }
      
      private function onWaiterlistChanged(param1:Event) : void
      {
         this.fillItems();
      }
      
      private function onFireMember(param1:Array) : void
      {
         this.isWaitingForServerMessage = true;
         this.selectedMember.mc_waitingcontainer.addChild(new ServerWaitingAnim());
         controller.sendServerMessageAndWait(SFConstants.C2S_NPC_FIRE,[this.selectedMember.npcId],SFConstants.S2C_NPC_FIRE);
      }
      
      private function onHireMember(param1:Array) : void
      {
         if(!param1 || param1.length < 2)
         {
            return;
         }
         if(TextValide.isSmartFoxValide(param1[0]) || StringUtil.trim(param1[0]) == "")
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_NPC_HIRE,param1);
         }
         else
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("createavatar_error"),CafeModel.languageData.getTextById("waiter_name_invalide")));
         }
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this.currentPage;
         if(param1.target == this.staffDialog.mc_arrow_left)
         {
            this.currentPage = Math.max(0,this.currentPage - 1);
         }
         else
         {
            this.currentPage = Math.min(this.maxPage,this.currentPage + 1);
         }
         if(_loc2_ != this.currentPage)
         {
            this.fillItems();
         }
      }
      
      private function initArrows(param1:int) : void
      {
         this.maxPage = (param1 - 1) / this.staffDialogProperties.itemsPerPage;
         this.staffDialog.mc_arrow_right.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.staffDialog.mc_arrow_left.visible = this.maxPage > 0 && this.currentPage > 0;
      }
      
      private function fillItems() : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:int = 0;
         var _loc6_:CafeStaffItem = null;
         var _loc7_:int = 0;
         var _loc8_:Rectangle = null;
         var _loc9_:NpcMovingVO = null;
         var _loc1_:int = this.currentPage * this.staffDialogProperties.itemsPerPage;
         var _loc2_:Array = DictionaryUtil.getKeys(CafeModel.npcStaffData.members);
         this.initArrows(_loc2_.length + 1);
         if(this.currentPage > this.maxPage)
         {
            this.currentPage = 0;
         }
         var _loc3_:int = _loc1_;
         while(_loc3_ < _loc1_ + this.staffDialogProperties.itemsPerPage)
         {
            _loc5_ = _loc3_ - _loc1_;
            (_loc6_ = this.staffDialog["i" + _loc5_] as CafeStaffItem).mc_lock.visible = _loc3_ >= CafeModel.userData.levelXpRelation.waiter;
            if((_loc7_ = CafeModel.userData.levelByGroupRelation("waiter",_loc3_ + 1)) >= 0)
            {
               _loc6_.mc_lock.toolTipText = CafeModel.languageData.getTextById("tt_byLevel",[_loc7_]);
            }
            else
            {
               delete _loc6_.mc_lock.toolTipText;
            }
            _loc6_.visible = _loc7_ >= 0;
            if(_loc3_ < _loc2_.length && _loc3_ < CafeModel.userData.levelXpRelation.waiter)
            {
               _loc9_ = CafeModel.npcStaffData.members[_loc2_[_loc3_]] as NpcMovingVO;
               _loc6_.npcId = _loc9_.npcId;
               _loc4_ = CreateAvatarHelper.createAvatar(_loc9_.avatarParts);
               _loc6_.txt_name.text = _loc9_.npc_name;
               _loc6_.btn_action.label = CafeModel.languageData.getTextById("dialogwin_staff_management");
            }
            else
            {
               _loc6_.npcId = -1;
               _loc4_ = new CafeStaffDummy();
               _loc6_.txt_name.text = CafeModel.languageData.getTextById("dialogwin_staff_new");
               _loc6_.btn_action.label = CafeModel.languageData.getTextById("dialogwin_staff_hire");
            }
            _loc6_.btn_action.npcId = _loc6_.npcId;
            _loc6_.btn_action.enableButton = !_loc6_.mc_lock.visible;
            _loc8_ = _loc4_.getBounds(null);
            _loc4_.x = -(_loc8_.width * SCALE_FACTOR / 2 + _loc8_.left * SCALE_FACTOR);
            _loc4_.y = -(_loc8_.top * SCALE_FACTOR);
            _loc4_.scaleX = _loc4_.scaleY = SCALE_FACTOR;
            while(_loc6_.mc_holder.numChildren > 0)
            {
               _loc6_.mc_holder.removeChildAt(0);
            }
            _loc6_.mc_holder.addChild(_loc4_);
            _loc3_++;
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.currentPage = 0;
         this.isWaitingForServerMessage = false;
         this.fillItems();
         this.staffDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_staff_title");
      }
      
      protected function get staffDialogProperties() : CafeStaffDialogProperties
      {
         return properties as CafeStaffDialogProperties;
      }
      
      private function get staffDialog() : CafeStaff
      {
         return disp as CafeStaff;
      }
   }
}
