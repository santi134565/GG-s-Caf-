package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.event.CafeHighscoreEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.BuddyVO;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class CafeHighscoreDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeHighscoreDialog";
       
      
      private var startRank:int;
      
      private var waitForServer:Boolean;
      
      private var searchName:String = "";
      
      private var currentSort:int;
      
      public function CafeHighscoreDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.waitForServer = false;
         this.currentSort = 0;
         controller.addEventListener(CafeHighscoreEvent.GET_HIGHSCORE_DATA,this.onGetHighscoreData);
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_HIGHSCORE_LIST,[-1,this.currentSort]);
         this.highscoreDialog.txt_title.text = CafeModel.languageData.getTextById("dialogwin_highscore_title");
         this.highscoreDialog.searchInput.inputField.text = CafeModel.languageData.getTextById("dialogwin_highscore_searchtext");
         this.highscoreDialog.txt_pos.text = CafeModel.languageData.getTextById("dialogwin_highscore_rank");
         this.highscoreDialog.txt_name.text = CafeModel.languageData.getTextById("dialogwin_highscore_name");
         this.highscoreDialog.txt_level.text = CafeModel.languageData.getTextById("level");
         this.highscoreDialog.mc_xp.toolTipText = CafeModel.languageData.getTextById("tt_highscore_xp");
         this.highscoreDialog.mc_luxury.toolTipText = CafeModel.languageData.getTextById("tt_highscore_luxury");
         this.highscoreDialog.btn_search.label = CafeModel.languageData.getTextById("btn_text_okay");
      }
      
      private function onGetHighscoreData(param1:CafeHighscoreEvent) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:CafeHighscoreItem = null;
         while(this.highscoreDialog.mc_itemholder.numChildren > 0)
         {
            this.highscoreDialog.mc_itemholder.removeChildAt(0);
         }
         this.startRank = param1.params.shift();
         var _loc2_:Array = String(param1.params.shift()).split("#");
         var _loc3_:int = 0;
         while(_loc3_ < this.highscoreDialogProperties.ITEMS_PER_PAGE)
         {
            _loc5_ = (_loc4_ = String(_loc2_[_loc3_]).split("+")).shift();
            _loc6_ = _loc4_.shift();
            _loc7_ = _loc4_.shift();
            _loc8_ = String(_loc4_.shift());
            _loc9_ = new CafeHighscoreItem();
            updateTextField(_loc9_.txt_pos);
            updateTextField(_loc9_.txt_name);
            updateTextField(_loc9_.txt_xp);
            updateTextField(_loc9_.txt_luxury);
            updateTextField(_loc9_.txt_level);
            _loc9_.mouseChildren = false;
            _loc9_.playerId = _loc5_;
            _loc9_.playerName = _loc8_;
            _loc9_.txt_pos.text = String(this.startRank + _loc3_ + 1);
            _loc9_.txt_name.text = _loc8_;
            _loc9_.txt_xp.text = String(_loc6_);
            _loc9_.txt_luxury.text = String(_loc7_);
            _loc9_.txt_level.text = String(CafeModel.userData.getLevelByXp(_loc6_));
            _loc9_.visible = _loc8_ != "undefined";
            if(_loc5_ == CafeModel.userData.playerID || this.searchName != "" && this.searchName.toLowerCase() == _loc8_.toLowerCase() || this.searchName != "" && this.searchName.toLowerCase() == _loc9_.txt_pos.text)
            {
               _loc9_.bg.gotoAndStop(2);
            }
            else
            {
               _loc9_.bg.gotoAndStop(1);
            }
            this.highscoreDialog.mc_itemholder.addChild(_loc9_);
            _loc9_.y = _loc3_ * (this.highscoreDialogProperties.ITEMS_HEIGHT + this.highscoreDialogProperties.ITEMS_SPACE);
            _loc3_++;
         }
         this.waitForServer = false;
         this.highscoreDialog.searchInput.inputField.text = CafeModel.languageData.getTextById("dialogwin_highscore_searchtext");
      }
      
      override protected function onCursorOver(param1:MouseEvent) : void
      {
         super.onCursorOver(param1);
         if(param1.target is CafeHighscoreItem && param1.target.playerId != CafeModel.userData.playerID && param1.target.playerName != "")
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         switch(param1.target)
         {
            case this.highscoreDialog.searchInput.inputField:
               if(param1.keyCode == Keyboard.ENTER)
               {
                  this.onSearch();
               }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc3_:BuddyVO = null;
         var _loc2_:String = this.searchName;
         this.searchName = "";
         super.onClick(param1);
         switch(param1.target)
         {
            case this.highscoreDialog.btn_close:
               this.hide();
               break;
            case this.highscoreDialog.btn_up:
               if(!this.waitForServer && this.startRank != 0)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_HIGHSCORE_LIST,[this.rankPageUp(this.startRank),this.currentSort]);
                  this.waitForServer = true;
               }
               break;
            case this.highscoreDialog.btn_down:
               if(!this.waitForServer)
               {
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_HIGHSCORE_LIST,[this.rankPageDown(this.startRank),this.currentSort]);
                  this.waitForServer = true;
               }
               break;
            case this.highscoreDialog.btn_search:
               this.onSearch();
               break;
            case this.highscoreDialog.searchInput.inputField:
               this.highscoreDialog.searchInput.inputField.text = "";
               break;
            case this.highscoreDialog.mc_xp:
               if(!this.waitForServer)
               {
                  this.currentSort = 0;
                  this.searchName = _loc2_;
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_HIGHSCORE_LIST,[_loc2_ != "" ? _loc2_ : -1,this.currentSort]);
                  this.waitForServer = true;
               }
               break;
            case this.highscoreDialog.mc_luxury:
               if(!this.waitForServer)
               {
                  this.currentSort = 1;
                  this.searchName = _loc2_;
                  CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_HIGHSCORE_LIST,[_loc2_ != "" ? _loc2_ : -1,this.currentSort]);
                  this.waitForServer = true;
               }
               break;
            default:
               if(param1.target is CafeHighscoreItem)
               {
                  _loc3_ = new BuddyVO();
                  _loc3_.playerId = param1.target.playerId;
                  if(_loc3_.playerId != CafeModel.userData.playerID && _loc3_.playerName != "")
                  {
                     layoutManager.playerActionChoices.initPlayerActionChoices(param1.target,_loc3_,(param1.target as DisplayObject).width / 2);
                  }
               }
         }
      }
      
      private function onSearch() : void
      {
         if(this.highscoreDialog.searchInput.inputField.text != "")
         {
            this.searchName = this.highscoreDialog.searchInput.inputField.text;
            CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_HIGHSCORE_LIST,[this.searchName,this.currentSort]);
         }
      }
      
      private function rankPageUp(param1:int) : int
      {
         var _loc2_:int = param1 - this.highscoreDialogProperties.ITEMS_PER_PAGE + 6;
         if(_loc2_ < 0)
         {
            return 0;
         }
         return _loc2_;
      }
      
      private function rankPageDown(param1:int) : int
      {
         return param1 + this.highscoreDialogProperties.ITEMS_PER_PAGE + 6;
      }
      
      override public function show() : void
      {
         controller.addEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeState);
         controller.addEventListener(CafeDialogEvent.CHANGE_CAFE,this.onChangeState);
         super.show();
      }
      
      override public function hide() : void
      {
         this.removeEventListeners();
         layoutManager.playerActionChoices.hide();
         super.hide();
      }
      
      override public function destroy() : void
      {
         this.removeEventListeners();
         super.destroy();
      }
      
      private function removeEventListeners() : void
      {
         controller.removeEventListener(CafeHighscoreEvent.GET_HIGHSCORE_DATA,this.onGetHighscoreData);
         controller.removeEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeState);
         controller.removeEventListener(CafeDialogEvent.CHANGE_CAFE,this.onChangeState);
      }
      
      private function onChangeState(param1:CafeDialogEvent) : void
      {
         this.hide();
      }
      
      protected function get highscoreDialogProperties() : CafeHighscoreDialogProperties
      {
         return properties as CafeHighscoreDialogProperties;
      }
      
      protected function get highscoreDialog() : CafeHighscore
      {
         return disp as CafeHighscore;
      }
   }
}
