package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.constants.CommonGameStates;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class CafeAvatarNameSelectionDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeAvatarNameSelction";
       
      
      public var names:Array;
      
      public function CafeAvatarNameSelectionDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         dispBounds = this.avatarNameSelction.getBounds(null);
         super.init();
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:String = null;
         var _loc2_:NameSelctionText = null;
         if(this.avatarNameSelectionProperties.badword)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.avatarNameSelction.txt_title,CafeModel.languageData.getTextById("generic_register_badword",[this.avatarNameSelectionProperties.badword]),2);
         }
         else
         {
            this.avatarNameSelction.txt_title.text = CafeModel.languageData.getTextById("dialogwin_avatarnameselect_copy");
         }
         if(properties)
         {
            while(this.avatarNameSelction.mc_namesholder.numChildren > 0)
            {
               this.avatarNameSelction.mc_namesholder.removeChildAt(0);
            }
            this.names = [];
            for each(_loc1_ in this.avatarNameSelectionProperties.names)
            {
               _loc2_ = new NameSelctionText();
               _loc2_.txt_msg.text = _loc1_;
               _loc2_.name = _loc1_;
               _loc2_.useHandCursor = true;
               _loc2_.buttonMode = true;
               _loc2_.addEventListener(MouseEvent.CLICK,this.onSelectName);
               _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onRollOverName);
               _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onRollOutName);
               _loc2_.txt_msg.width = _loc2_.txt_msg.textWidth + 5;
               _loc2_.y = this.avatarNameSelction.mc_namesholder.numChildren * _loc2_.height;
               this.names.push(_loc2_);
               this.avatarNameSelction.mc_namesholder.addChild(_loc2_);
            }
         }
      }
      
      private function onRollOverName(param1:MouseEvent) : void
      {
         if(param1.target.name != "txt_msg")
         {
            return;
         }
         var _loc2_:TextFormat = (param1.target as TextField).getTextFormat();
         _loc2_.underline = true;
         (param1.target as TextField).setTextFormat(_loc2_);
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onRollOutName(param1:MouseEvent) : void
      {
         if(param1.target.name != "txt_msg")
         {
            return;
         }
         var _loc2_:TextFormat = (param1.target as TextField).getTextFormat();
         _loc2_.underline = false;
         (param1.target as TextField).setTextFormat(_loc2_);
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         this.hide();
      }
      
      override public function hide() : void
      {
         env.gameState = CommonGameStates.REGISTER_DIAL_INGAME;
         if(disp)
         {
            while(this.names.length > 0)
            {
               (this.names[0] as NameSelctionText).removeEventListener(MouseEvent.CLICK,this.onSelectName);
               (this.names[0] as NameSelctionText).removeEventListener(MouseEvent.MOUSE_OVER,this.onRollOverName);
               (this.names[0] as NameSelctionText).removeEventListener(MouseEvent.MOUSE_OUT,this.onRollOutName);
               this.names.shift();
            }
         }
         super.hide();
      }
      
      override public function show() : void
      {
         env.gameState = CommonGameStates.AVATAR_CREATION_NAME_LIST;
         super.show();
      }
      
      public function showNames(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc3_:NameSelctionText = null;
         this.names = [];
         this.avatarNameSelction.txt_title.text = CafeModel.languageData.getTextById("error_avatar_12");
         this.avatarNameSelction.txt_title.height = this.avatarNameSelction.txt_title.textHeight + 10;
         this.avatarNameSelction.mc_holder.y = this.avatarNameSelction.txt_title.height + this.avatarNameSelction.txt_title.y;
         while(this.avatarNameSelction.mc_holder.numChildren > 0)
         {
            this.avatarNameSelction.mc_holder.removeChildAt(0);
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = new NameSelctionText();
            _loc3_.txt_msg.text = _loc2_;
            _loc3_.name = _loc2_;
            _loc3_.addEventListener(MouseEvent.CLICK,this.onSelectName);
            _loc3_.y = _loc3_.height / 2 + this.avatarNameSelction.mc_holder.numChildren * _loc3_.height;
            _loc3_.x = _loc3_.width / 2;
            this.names.push(_loc3_);
            this.avatarNameSelction.mc_holder.addChild(_loc3_);
         }
         this.avatarNameSelction.mc_bg.height = this.avatarNameSelction.mc_holder.y + this.avatarNameSelction.mc_holder.numChildren * _loc3_.height;
         this.show();
         updateAllTextFields();
      }
      
      private function onSelectName(param1:MouseEvent) : void
      {
         var _loc2_:String = String(param1.currentTarget.name);
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return;
         }
         controller.dispatchEvent(new CafeDialogEvent(CafeDialogEvent.SELECT_NAME,[_loc2_]));
         this.hide();
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            disp.x = -dispBounds.left - dispBounds.width / 1.8 + (disp.stage.stageWidth - 100) / 1.8;
            disp.y = -dispBounds.top - dispBounds.height / 2.8 + (disp.stage.stageHeight - 100) / 2.8;
         }
      }
      
      protected function get avatarNameSelectionProperties() : CafeAvatarNameSelectionDialogProperties
      {
         return properties as CafeAvatarNameSelectionDialogProperties;
      }
      
      private function get avatarNameSelction() : CafeAvatarNameSelection
      {
         return disp as CafeAvatarNameSelection;
      }
   }
}
