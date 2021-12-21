package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.cafe.event.CafeBuddyEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.BuddyVO;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   
   public class CafeBuddylistPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeBuddylistPanel";
      
      public static const BUDDY_PANEL_HEIGHT:int = 158;
      
      private static const NOPIC_PATTERN:RegExp = /nopic/i;
      
      private static const BUDDYHOLDER_STD_POSX:int = 262;
      
      private static const AVATAR_SCALE_FACTOR:Number = 1.3;
      
      private static const BUDDY_ITEM_WIDTH:int = 130;
      
      private static const CITEM_WIDTH:int = 88;
      
      private static const CITEM_HEIGHT:int = 77;
       
      
      private var itemsPerPage:int;
      
      private var maxPage:int;
      
      private var currentPage:int;
      
      private var arrow_left:MovieClip;
      
      private var arrow_right:MovieClip;
      
      private var arrow_first:MovieClip;
      
      private var arrow_last:MovieClip;
      
      private var buddyholderPosX:int = 50;
      
      public function CafeBuddylistPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.itemsPerPage = 0;
         this.maxPage = 0;
         this.currentPage = 0;
         this.arrow_left = this.buddylistPanel.btn_arrow_left;
         this.arrow_right = this.buddylistPanel.btn_arrow_right;
         this.arrow_first = this.buddylistPanel.btn_arrow_first;
         this.arrow_last = this.buddylistPanel.btn_arrow_last;
         this.buddylistPanel.btn_addbuddy.txt_title.text = CafeModel.languageData.getTextById("panelwin_buddy_btn_morefriends");
         this.buddylistPanel.btn_addbuddy.visible = env.invitefriends;
         controller.addEventListener(CafeBuddyEvent.CHANGE_BUDDYDATA,this.onChangeBuddyData);
         super.init();
      }
      
      override public function destroy() : void
      {
         var _loc3_:int = 0;
         var _loc4_:BuddylistItem = null;
         super.destroy();
         var _loc1_:int = this.currentPage * this.itemsPerPage;
         var _loc2_:int = _loc1_;
         while(_loc2_ < _loc1_ + this.itemsPerPage)
         {
            _loc3_ = _loc2_ - _loc1_;
            if(_loc4_ = this.buddylistPanel.mc_buddyitemholder.getChildByName("i" + _loc3_) as BuddylistItem)
            {
               _loc4_.removeEventListener(MouseEvent.CLICK,this.onClickBuddyItem);
            }
            _loc2_++;
         }
         controller.removeEventListener(CafeBuddyEvent.CHANGE_BUDDYDATA,this.onChangeBuddyData);
      }
      
      private function onChangeBuddyData(param1:CafeBuddyEvent) : void
      {
         this.fillItems();
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
            case this.buddylistPanel.btn_addbuddy:
               CafeModel.socialData.inviteFriends();
               layoutManager.revertFullscreen();
               break;
            case this.arrow_left:
               --this.currentPage;
               this.fillItems();
               break;
            case this.arrow_right:
               ++this.currentPage;
               this.fillItems();
               break;
            case this.arrow_first:
               this.currentPage = 0;
               this.fillItems();
               break;
            case this.arrow_last:
               this.currentPage = this.maxPage;
               this.fillItems();
         }
      }
      
      private function onClickBuddyItem(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         var _loc2_:BuddylistItem = param1.target as BuddylistItem;
         if(_loc2_ && _loc2_.buddyData)
         {
            layoutManager.playerActionChoices.initPlayerActionChoices(_loc2_,_loc2_.buddyData);
         }
      }
      
      private function fillItems() : void
      {
         var _loc3_:int = 0;
         var _loc4_:BuddylistItem = null;
         var _loc5_:BuddyVO = null;
         var _loc6_:Loader = null;
         var _loc7_:URLRequest = null;
         var _loc8_:Sprite = null;
         var _loc9_:Rectangle = null;
         this.initArrows(CafeModel.buddyList.completeBuddyList.length);
         var _loc1_:int = this.currentPage * this.itemsPerPage;
         var _loc2_:int = _loc1_;
         while(_loc2_ < _loc1_ + this.itemsPerPage)
         {
            _loc3_ = _loc2_ - _loc1_;
            (_loc4_ = this.buddylistPanel.mc_buddyitemholder.getChildByName("i" + _loc3_) as BuddylistItem).mouseChildren = false;
            _loc4_.visible = true;
            _loc4_.gotoAndStop(1);
            if(_loc2_ < CafeModel.buddyList.completeBuddyList.length)
            {
               _loc5_ = CafeModel.buddyList.completeBuddyList[_loc2_];
               _loc4_.txt_name.text = _loc5_.playerName;
               _loc4_.txt_level.text = String(CafeModel.userData.getLevelByXp(_loc5_.playerXp));
               _loc4_.buddyData = _loc5_;
               while(_loc4_.mc_holder.numChildren > 0)
               {
                  _loc4_.mc_holder.removeChildAt(0);
               }
               if(_loc5_.thumbUrl && _loc5_.thumbUrl != "" && _loc5_.thumbUrl.search(NOPIC_PATTERN) == -1)
               {
                  _loc6_ = new Loader();
                  _loc7_ = new URLRequest(_loc5_.thumbUrl);
                  _loc6_.load(_loc7_);
                  _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoadComplete);
                  _loc4_.mc_holder.addChild(_loc6_);
               }
               else
               {
                  _loc9_ = (_loc8_ = CreateAvatarHelper.createAvatar(_loc5_.avatarParts)).getBounds(null);
                  _loc8_.x = -(_loc9_.width * AVATAR_SCALE_FACTOR / 2 + _loc9_.left * AVATAR_SCALE_FACTOR) - 10;
                  _loc8_.y = -(_loc9_.top * AVATAR_SCALE_FACTOR) - 80;
                  _loc8_.scaleX = _loc8_.scaleY = AVATAR_SCALE_FACTOR;
                  _loc4_.mc_holder.addChild(_loc8_);
               }
               if(!_loc5_.isSocialFriend)
               {
                  _loc4_.gotoAndStop(2);
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc2_++;
         }
      }
      
      private function onPicLoadComplete(param1:Event) : void
      {
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Rectangle = _loc2_.getBounds(null);
         var _loc4_:Number = CITEM_HEIGHT / _loc3_.height;
         _loc2_.scaleX = _loc2_.scaleY = _loc4_;
         _loc2_.y = -CITEM_HEIGHT / 2;
         _loc2_.x = -_loc3_.width * _loc4_ / 2;
         param1.target.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onPicLoadComplete);
      }
      
      private function initArrows(param1:int) : void
      {
         if(param1 < 1)
         {
            this.arrow_right.visible = this.arrow_left.visible = this.arrow_first.visible = this.arrow_last.visible = false;
         }
         this.maxPage = (param1 - 1) / this.itemsPerPage;
         this.arrow_right.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.arrow_left.visible = this.maxPage > 0 && this.currentPage > 0;
         this.arrow_first.visible = this.currentPage > 0;
         this.arrow_last.visible = this.currentPage < this.maxPage;
      }
      
      override public function show() : void
      {
         super.show();
         this.updatePosition();
      }
      
      private function changeItemsPerPage(param1:int) : void
      {
         var _loc2_:BuddylistItem = null;
         if(!this.buddylistPanel.visible)
         {
            return;
         }
         if(param1 != this.itemsPerPage)
         {
            this.currentPage = 0;
            this.itemsPerPage = param1;
            while(this.buddylistPanel.mc_buddyitemholder.numChildren > this.itemsPerPage)
            {
               if(this.buddylistPanel.mc_buddyitemholder.numChildren > 0)
               {
                  this.buddylistPanel.mc_buddyitemholder.removeChildAt(this.buddylistPanel.mc_buddyitemholder.numChildren - 1);
               }
            }
            while(this.buddylistPanel.mc_buddyitemholder.numChildren < this.itemsPerPage)
            {
               _loc2_ = new BuddylistItem();
               _loc2_.name = "i" + this.buddylistPanel.mc_buddyitemholder.numChildren;
               _loc2_.x = this.buddylistPanel.mc_buddyitemholder.numChildren * BUDDY_ITEM_WIDTH;
               _loc2_.addEventListener(MouseEvent.CLICK,this.onClickBuddyItem);
               this.buddylistPanel.mc_buddyitemholder.addChild(_loc2_);
            }
            this.buddylistPanel.mc_buddyitemholder.x = this.buddyholderPosX;
            this.arrow_left.x = this.arrow_first.x = this.buddylistPanel.mc_buddyitemholder.x - BUDDY_ITEM_WIDTH / 2 - 15;
            this.arrow_right.x = this.arrow_last.x = this.buddylistPanel.mc_buddyitemholder.x - BUDDY_ITEM_WIDTH / 2 + this.itemsPerPage * BUDDY_ITEM_WIDTH + 15;
            this.fillItems();
         }
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            disp.y = disp.stage.stageHeight;
            this.buddylistPanel.background.width = disp.stage.stageWidth;
            this.buddyholderPosX = BUDDYHOLDER_STD_POSX;
            if(!env.invitefriends)
            {
               this.buddyholderPosX = this.buddylistPanel.btn_addbuddy.x + 15 + this.arrow_left.width / 2;
            }
            this.changeItemsPerPage(this.numBuddys);
         }
      }
      
      private function get numBuddys() : int
      {
         var _loc1_:int = (this.buddylistPanel.background.width - this.buddyholderPosX) / BUDDY_ITEM_WIDTH;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      protected function get buddylistPanel() : BuddylistPanel
      {
         return disp as BuddylistPanel;
      }
   }
}
