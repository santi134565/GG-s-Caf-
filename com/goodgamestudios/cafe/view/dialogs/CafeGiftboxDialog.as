package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeGiftEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.model.components.CafeSocialData;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.BuddyVO;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.cafe.world.vo.gift.GiftVO;
   import com.goodgamestudios.cafe.world.vo.ingredient.BasicIngredientVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeGiftboxDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeGiftboxDialog";
       
      
      private const AVATAR_SCALE_FACTOR:Number = 1.3;
      
      private const CATEGORY_MYGIFTS:int = 1;
      
      private const CATEGORY_SENDABLEGIFTS:int = 2;
      
      private const CATEGORY_SENDTOFRIEND:int = 3;
      
      private const CATEGORY_GGS:int = 4;
      
      private var MAX_WIDTH:int = 90;
      
      private var MAX_HEIGHT:int = 90;
      
      private var currentPage:int = 0;
      
      private var maxPage:int = 0;
      
      private var currentCategory:int;
      
      private var selectedPlayer:Array;
      
      private var _selectedGift:GiftVO;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeGiftboxDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         controller.addEventListener(CafeGiftEvent.CHANGE_MYGIFTS,this.changeGiftList);
         controller.addEventListener(CafeGiftEvent.CHANGE_ALLREADYSENDPLAYERLIST,this.changeGiftList);
         controller.addEventListener(CafeGiftEvent.CHANGE_SENDABLEGIFTS,this.changeGiftList);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeGiftEvent.CHANGE_MYGIFTS,this.changeGiftList);
         controller.removeEventListener(CafeGiftEvent.CHANGE_ALLREADYSENDPLAYERLIST,this.changeGiftList);
         controller.removeEventListener(CafeGiftEvent.CHANGE_SENDABLEGIFTS,this.changeGiftList);
      }
      
      override protected function applyProperties() : void
      {
         this.isWaitingForServerMessage = false;
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_GIFT_PLAYERGIFTS,[]);
         if(env.hasNetworkBuddies)
         {
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_GIFT_SENDABLEGIFTS,[]);
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_GIFT_ALLREADYSEND_PLAYERS,[]);
         }
         this.giftDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_giftbox_title");
         if(env.hasNetworkBuddies)
         {
            this.changeCategory(this.CATEGORY_MYGIFTS);
         }
         else
         {
            this.changeCategory(this.CATEGORY_GGS);
         }
         this.selectedPlayer = new Array();
      }
      
      private function changeGiftList(param1:CafeGiftEvent) : void
      {
         switch(param1.type)
         {
            case CafeGiftEvent.CHANGE_ALLREADYSENDPLAYERLIST:
               if(this.currentCategory == this.CATEGORY_SENDTOFRIEND)
               {
                  this.changeCategory(this.currentCategory);
               }
               break;
            case CafeGiftEvent.CHANGE_MYGIFTS:
               if(this.currentCategory == this.CATEGORY_GGS)
               {
                  if(CafeModel.giftList.numGifts % 6 == 0)
                  {
                     this.currentPage = Math.max(0,this.currentPage - 1);
                  }
                  this.fillItems();
               }
               else if(this.currentCategory == this.CATEGORY_MYGIFTS)
               {
                  this.changeCategory(this.currentCategory);
               }
               break;
            case CafeGiftEvent.CHANGE_SENDABLEGIFTS:
               if(this.currentCategory == this.CATEGORY_SENDABLEGIFTS)
               {
                  this.changeCategory(this.currentCategory);
               }
         }
      }
      
      private function changeCategory(param1:int) : void
      {
         this.currentCategory = param1;
         if(this.currentCategory == this.CATEGORY_GGS)
         {
            this.giftDialog.gotoAndStop(this.CATEGORY_SENDTOFRIEND);
         }
         else
         {
            this.giftDialog.gotoAndStop(this.currentCategory);
         }
         updateAllTextFields();
         this.currentPage = 0;
         this.fillItems();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.giftDialog.btn_arrow_left:
            case this.giftDialog.btn_arrow_right:
               this.onClickArrow(param1);
               break;
            case this.giftDialog.btn_close:
               hide();
               break;
            case this.giftDialog.i0.btn_action:
            case this.giftDialog.i1.btn_action:
            case this.giftDialog.i2.btn_action:
            case this.giftDialog.i3.btn_action:
            case this.giftDialog.i4.btn_action:
            case this.giftDialog.i5.btn_action:
               this.onClickGiftSendTo(param1);
               break;
            case this.giftDialog.i0.btn_select:
            case this.giftDialog.i1.btn_select:
            case this.giftDialog.i2.btn_select:
            case this.giftDialog.i3.btn_select:
            case this.giftDialog.i4.btn_select:
            case this.giftDialog.i5.btn_select:
               this.onClickSelectPlayer(param1);
               break;
            case this.giftDialog.i0.btn_use:
            case this.giftDialog.i1.btn_use:
            case this.giftDialog.i2.btn_use:
            case this.giftDialog.i3.btn_use:
            case this.giftDialog.i4.btn_use:
            case this.giftDialog.i5.btn_use:
               this.onClickUseGift(param1);
               break;
            case this.giftDialog.i0.btn_remove:
            case this.giftDialog.i1.btn_remove:
            case this.giftDialog.i2.btn_remove:
            case this.giftDialog.i3.btn_remove:
            case this.giftDialog.i4.btn_remove:
            case this.giftDialog.i5.btn_remove:
               this.onClickRemoveGift(param1);
               break;
            case this.giftDialog.btn_send:
               hide();
               if(this.selectedPlayer.length > 0)
               {
                  _loc2_ = [this._selectedGift.giftWodId,this._selectedGift.giftAmount,this.arrayToSmartFoxParamString(this.selectedPlayer)];
                  if(env.enableFeedMessages)
                  {
                     _loc3_ = "";
                     for each(_loc4_ in this.selectedPlayer)
                     {
                        _loc3_ += "+" + _loc4_;
                     }
                     _loc3_ = _loc3_.substr(1);
                     CafeModel.socialData.postFeed(CafeSocialData.EXTERNAL_SHARE_GIFTS,[_loc3_]);
                  }
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_GIFT_SEND,_loc2_);
               }
               break;
            case this.giftDialog.btn_mygifts:
               this.changeCategory(this.CATEGORY_MYGIFTS);
               break;
            case this.giftDialog.btn_sendgifts:
               this.changeCategory(this.CATEGORY_SENDABLEGIFTS);
         }
      }
      
      private function arrayToSmartFoxParamString(param1:Array) : String
      {
         var _loc3_:String = null;
         var _loc2_:* = "";
         for each(_loc3_ in param1)
         {
            if(_loc2_.length > 0)
            {
               _loc2_ += "+";
            }
            _loc2_ += _loc3_;
         }
         return _loc2_;
      }
      
      private function onClickRemoveGift(param1:MouseEvent) : void
      {
         var _loc2_:GiftItem = param1.target.parent as GiftItem;
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_GIFT_REMOVE,[_loc2_.Id]);
      }
      
      private function onClickUseGift(param1:MouseEvent) : void
      {
         var _loc2_:GiftItem = param1.target.parent as GiftItem;
         if(CafeModel.wodData.voList[_loc2_.wod].group == CafeConstants.GROUP_DISH && layoutManager.isoScreen.isoWorld.myPlayer.isWorking)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_workinghero_title"),CafeModel.languageData.getTextById("alert_workinghero_copy")));
         }
         else if(CafeModel.wodData.voList[_loc2_.wod].group == CafeConstants.GROUP_INGREDIENT && (CafeModel.wodData.voList[_loc2_.wod] as BasicIngredientVO).category != "fancy" && CafeModel.inventoryFridge.capacity <= 0)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("alert_storefull_title"),CafeModel.languageData.getTextById("alert_storefull_copy")));
         }
         else
         {
            this.isWaitingForServerMessage = true;
            controller.sendServerMessageAndWait(SFConstants.C2S_GIFT_USE,[_loc2_.Id],SFConstants.S2C_GIFT_USE);
         }
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_GIFT_USE)
         {
            this.isWaitingForServerMessage = false;
         }
      }
      
      private function onClickSelectPlayer(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GiftItem = param1.target.parent as GiftItem;
         if(_loc2_.btn_select.isSelected)
         {
            _loc2_.btn_select.deselected();
            _loc3_ = this.selectedPlayer.indexOf(_loc2_.Id);
            if(_loc3_ >= 0)
            {
               this.selectedPlayer.splice(_loc3_,1);
            }
         }
         else
         {
            this.selectedPlayer.push(_loc2_.Id);
            _loc2_.btn_select.selected();
         }
      }
      
      private function onClickGiftSendTo(param1:MouseEvent) : void
      {
         var _loc2_:GiftItem = param1.target.parent as GiftItem;
         this._selectedGift = CafeModel.giftList.getSendableGiftByWodId(_loc2_.Id);
         if(this._selectedGift)
         {
            this.changeCategory(this.CATEGORY_SENDTOFRIEND);
         }
      }
      
      private function onClickArrow(param1:MouseEvent) : void
      {
         var _loc2_:int = this.currentPage;
         if(param1.target == this.giftDialog.btn_arrow_left)
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
         this.maxPage = (param1 - 1) / this.giftDialogProperties.itemsPerPage;
         this.giftDialog.btn_arrow_right.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.giftDialog.btn_arrow_left.visible = this.maxPage > 0 && this.currentPage > 0;
      }
      
      private function fillItems() : void
      {
         var _loc4_:int = 0;
         var _loc5_:GiftItem = null;
         var _loc1_:int = this.currentPage * this.giftDialogProperties.itemsPerPage;
         var _loc2_:Array = new Array();
         switch(this.currentCategory)
         {
            case this.CATEGORY_MYGIFTS:
               this.giftDialog.btn_send.visible = false;
               _loc2_ = CafeModel.giftList.getMyGifts();
               this.giftDialog.mc_empty.txt_title.text = CafeModel.languageData.getTextById("dialogwin_giftbox_mygifts_empty");
               break;
            case this.CATEGORY_SENDABLEGIFTS:
               this.giftDialog.btn_send.visible = false;
               _loc2_ = CafeModel.giftList.getSendableGifts();
               this.giftDialog.mc_empty.txt_title.text = CafeModel.languageData.getTextById("dialogwin_giftbox_sendablegifts_empty");
               break;
            case this.CATEGORY_SENDTOFRIEND:
               if(CafeModel.giftList.canSendGifts)
               {
                  _loc2_ = CafeModel.giftList.getSendablePlayerList(CafeModel.buddyList.socialBuddyList);
                  this.giftDialog.mc_empty.txt_title.text = CafeModel.languageData.getTextById("dialogwin_giftbox_friendlist_empty",[env.networknameString]);
               }
               else
               {
                  this.giftDialog.mc_empty.txt_title.text = CafeModel.languageData.getTextById("dialogwin_giftbox_friendlist_notavailable");
               }
               if(_loc2_.length > 0)
               {
                  this.giftDialog.btn_send.label = CafeModel.languageData.getTextById("dialogwin_giftbox_send");
               }
               else
               {
                  this.giftDialog.btn_send.label = CafeModel.languageData.getTextById("dialogwin_giftbox_close");
               }
               this.giftDialog.btn_send.visible = true;
               break;
            case this.CATEGORY_GGS:
               _loc2_ = CafeModel.giftList.getMyGifts();
               this.giftDialog.mc_empty.txt_title.text = "";
               this.giftDialog.btn_send.label = CafeModel.languageData.getTextById("dialogwin_giftbox_close");
         }
         this.initArrows(_loc2_.length);
         this.giftDialog.mc_empty.visible = _loc2_.length == 0;
         var _loc3_:int = _loc1_;
         while(_loc3_ < _loc1_ + this.giftDialogProperties.itemsPerPage)
         {
            _loc4_ = _loc3_ - _loc1_;
            _loc5_ = this.giftDialog["i" + _loc4_] as GiftItem;
            if(_loc3_ < _loc2_.length)
            {
               switch(this.currentCategory)
               {
                  case this.CATEGORY_MYGIFTS:
                     _loc5_.gotoAndStop(this.currentCategory);
                     this.initMyGiftsItem(_loc5_,_loc2_[_loc3_]);
                     break;
                  case this.CATEGORY_SENDABLEGIFTS:
                     _loc5_.gotoAndStop(this.currentCategory);
                     this.initSendableGiftsItem(_loc5_,_loc2_[_loc3_]);
                     break;
                  case this.CATEGORY_SENDTOFRIEND:
                     _loc5_.gotoAndStop(this.currentCategory);
                     this.initSendToFriendItem(_loc5_,_loc2_[_loc3_]);
                     break;
                  case this.CATEGORY_GGS:
                     _loc5_.gotoAndStop(this.CATEGORY_MYGIFTS);
                     this.initMyGiftsItem(_loc5_,_loc2_[_loc3_]);
               }
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc3_++;
         }
      }
      
      private function initSendableGiftsItem(param1:GiftItem, param2:GiftVO) : void
      {
         var _loc3_:Class = getDefinitionByName(param2.giftWod.getVisClassName()) as Class;
         var _loc4_:Object = new _loc3_();
         var _loc5_:Number = 0;
         var _loc6_:String = "";
         switch(param2.giftWod.group)
         {
            case CafeConstants.GROUP_INGREDIENT:
               _loc6_ = CafeModel.languageData.getTextById("ingredient_" + param2.giftWod.type.toLowerCase());
               break;
            case CafeConstants.GROUP_DISH:
               (_loc4_ as MovieClip).gotoAndStop(BasicDishVO.GFX_FRAME_READY);
               _loc6_ = CafeModel.languageData.getTextById("recipe_" + param2.giftWod.type.toLowerCase());
         }
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,param1.txt_title,_loc6_,2);
         param1.btn_action.label = CafeModel.languageData.getTextById("dialogwin_giftbox_send");
         param1.btn_action.visible = true;
         param1.txt_sender.visible = false;
         param1.txt_amount.text = "x" + param2.giftAmount;
         param1.Id = param2.giftWodId;
         var _loc7_:Rectangle = _loc4_.getBounds(null);
         _loc5_ = this.MAX_WIDTH / _loc7_.width;
         if(_loc7_.height * _loc5_ > this.MAX_HEIGHT)
         {
            _loc5_ = this.MAX_HEIGHT / _loc7_.height;
         }
         _loc4_.x = -(_loc7_.width * _loc5_ / 2 + _loc7_.left * _loc5_);
         _loc4_.y = -(_loc7_.height * _loc5_ / 2 + _loc7_.top * _loc5_);
         _loc4_.scaleX = _loc4_.scaleY = _loc5_;
         while(param1.mc_holder.numChildren > 0)
         {
            param1.mc_holder.removeChildAt(0);
         }
         param1.mc_holder.addChild(_loc4_ as DisplayObject);
         param1.visible = true;
      }
      
      private function initMyGiftsItem(param1:GiftItem, param2:GiftVO) : void
      {
         var _loc3_:Class = getDefinitionByName(param2.giftWod.getVisClassName()) as Class;
         var _loc4_:Object = new _loc3_();
         var _loc5_:Number = 0;
         var _loc6_:String = "";
         switch(param2.giftWod.group)
         {
            case CafeConstants.GROUP_INGREDIENT:
               _loc6_ = CafeModel.languageData.getTextById("ingredient_" + param2.giftWod.type.toLowerCase());
               break;
            case CafeConstants.GROUP_DISH:
               (_loc4_ as MovieClip).gotoAndStop(BasicDishVO.GFX_FRAME_READY);
               _loc6_ = CafeModel.languageData.getTextById("recipe_" + param2.giftWod.type.toLowerCase());
         }
         if(_loc6_.length > 18 || _loc6_.indexOf(" ") > 0)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,param1.txt_title,_loc6_,2);
         }
         else
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,param1.txt_title,_loc6_,1);
         }
         var _loc7_:Rectangle = _loc4_.getBounds(null);
         _loc5_ = this.MAX_WIDTH / _loc7_.width;
         if(_loc7_.height * _loc5_ > this.MAX_HEIGHT)
         {
            _loc5_ = this.MAX_HEIGHT / _loc7_.height;
         }
         _loc5_ *= 0.8;
         var _loc8_:BuddyVO;
         if(_loc8_ = CafeModel.buddyList.getBuddyByPlayerId(param2.senderPlayerId))
         {
            param1.txt_sender.text = _loc8_.playerName;
            param1.txt_sender.visible = true;
         }
         else if(param2.senderPlayerId == -1)
         {
            param1.txt_sender.text = CafeModel.languageData.getTextById("generic_ggs");
            param1.txt_sender.visible = true;
         }
         else
         {
            param1.txt_sender.visible = false;
         }
         param1.btn_action.visible = false;
         param1.txt_amount.text = "x" + param2.giftAmount;
         param1.btn_use.toolTipText = CafeModel.languageData.getTextById("dialogwin_giftbox_use");
         param1.btn_remove.toolTipText = CafeModel.languageData.getTextById("dialogwin_giftbox_remove");
         param1.Id = param2.id;
         param1.wod = param2.giftWodId;
         _loc4_.x = -(_loc7_.width * _loc5_ / 2 + _loc7_.left * _loc5_);
         _loc4_.y = -(_loc7_.height * _loc5_ / 2 + _loc7_.top * _loc5_);
         _loc4_.scaleX = _loc4_.scaleY = _loc5_;
         while(param1.mc_holder.numChildren > 0)
         {
            param1.mc_holder.removeChildAt(0);
         }
         param1.mc_holder.addChild(_loc4_ as DisplayObject);
         param1.visible = true;
      }
      
      private function initSendToFriendItem(param1:GiftItem, param2:BuddyVO) : void
      {
         var _loc3_:Sprite = CreateAvatarHelper.createAvatar(param2.avatarParts);
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,param1.txt_title,param2.playerName,2);
         param1.txt_amount.text = "";
         param1.btn_action.visible = false;
         param1.txt_sender.visible = false;
         if(this.selectedPlayer.indexOf(param2.playerId) >= 0)
         {
            param1.btn_select.selected();
         }
         else
         {
            param1.btn_select.deselected();
         }
         param1.Id = param2.playerId;
         var _loc4_:Number = this.AVATAR_SCALE_FACTOR;
         var _loc5_:Rectangle = _loc3_.getBounds(null);
         _loc3_.x = -(_loc5_.width * _loc4_ / 2 + _loc5_.left * _loc4_);
         _loc3_.y = -(_loc5_.height * _loc4_ / 2 + _loc5_.top * _loc4_);
         _loc3_.scaleX = _loc3_.scaleY = _loc4_;
         while(param1.mc_holder.numChildren > 0)
         {
            param1.mc_holder.removeChildAt(0);
         }
         param1.mc_holder.addChild(_loc3_);
         param1.visible = true;
      }
      
      protected function get giftDialogProperties() : CafeGiftboxDialogProperties
      {
         return properties as CafeGiftboxDialogProperties;
      }
      
      private function get giftDialog() : CafeGiftBox
      {
         return disp as CafeGiftBox;
      }
   }
}
