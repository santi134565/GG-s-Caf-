package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class CafeComebackBonusDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeComebackBonusDialog";
       
      
      private var MAX_WIDTH:int = 100;
      
      private var MAX_HEIGHT:int = 100;
      
      private var MAX_TEXTICONHEIGHT:int = 90;
      
      public function CafeComebackBonusDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
         this.comebackBonusDialog.btn_ok.label = CafeModel.languageData.getTextById("btn_text_okay");
         this.comebackBonusDialog.txt_title.text = this.comebackBonusDialogProperties.title;
         this.comebackBonusDialog.txt_copy.text = this.comebackBonusDialogProperties.copy;
         while(this.comebackBonusDialog.mc_container.numChildren > 0)
         {
            this.comebackBonusDialog.mc_container.removeChildAt(0);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.comebackBonusDialog.btn_ok:
               hide();
         }
      }
      
      private function fillItems() : void
      {
         var _loc2_:VisualVO = null;
         var _loc3_:CafeBonusElement = null;
         var _loc4_:Class = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Rectangle = null;
         var _loc9_:String = null;
         this.comebackBonusDialog.gotoAndStop(1);
         var _loc1_:Number = 0;
         for each(_loc2_ in this.comebackBonusDialogProperties.bonuselements)
         {
            _loc3_ = new CafeBonusElement();
            _loc3_.mouseChildren = false;
            _loc5_ = new (_loc4_ = getDefinitionByName(CafeModel.wodData.voList[_loc2_.wodId].getVisClassName()) as Class)();
            _loc6_ = this.MAX_HEIGHT;
            _loc7_ = 0;
            if(_loc2_.hasOwnProperty("amount") && _loc2_["amount"] > 0)
            {
               _loc7_ = _loc2_["amount"];
            }
            if(_loc2_.hasOwnProperty("inventoryAmount") && _loc2_["inventoryAmount"] > 0)
            {
               _loc7_ = _loc2_["inventoryAmount"];
            }
            if(_loc7_ > 0)
            {
               _loc6_ = this.MAX_TEXTICONHEIGHT;
               if(this.comebackBonusDialogProperties.type == CafeBonusDialogProperties.TYPE_COMEBACK_BONUS)
               {
                  _loc3_.txt_value.text = "+ ";
               }
               else
               {
                  _loc3_.txt_value.text = "";
               }
               _loc3_.txt_value.text += NumberStringHelper.groupString(_loc7_,CafeModel.languageData.getTextById);
               _loc3_.txt_value.width = _loc3_.txt_value.textWidth + 5;
               _loc3_.txt_value.x = -(_loc3_.txt_value.width / 2);
               _loc3_.txt_value.y = this.MAX_HEIGHT / 2 - 20;
               _loc3_.txt_value.visible = true;
            }
            else
            {
               _loc3_.txt_value.visible = false;
            }
            _loc8_ = _loc5_.getBounds(null);
            _loc1_ = this.MAX_WIDTH / _loc8_.width;
            if(_loc8_.height * _loc1_ > _loc6_)
            {
               _loc1_ = _loc6_ / _loc8_.height;
            }
            _loc5_.scaleX = _loc5_.scaleY = _loc1_;
            if(_loc2_.group == CafeConstants.GROUP_INGREDIENT)
            {
               _loc9_ = CafeModel.languageData.getTextById("ingredient_" + _loc2_.type.toLocaleLowerCase());
            }
            if(_loc9_ && _loc9_.length > 0)
            {
               _loc3_.toolTipText = _loc9_;
            }
            _loc5_.x = -(_loc8_.width * _loc1_ / 2 + _loc8_.left * _loc1_);
            if(_loc3_.txt_value.visible)
            {
               _loc5_.y = -(_loc8_.height * _loc1_ / 2 + _loc8_.top * _loc1_ + 10);
            }
            else
            {
               _loc5_.y = -(_loc8_.height * _loc1_ / 2 + _loc8_.top * _loc1_);
            }
            while(_loc3_.mc_holder.numChildren > 0)
            {
               _loc3_.mc_holder.removeChildAt(0);
            }
            _loc3_.mc_holder.addChild(_loc5_);
            this.comebackBonusDialog.mc_container.addChild(_loc3_);
         }
         this.reposItemHolder(this.comebackBonusDialog.mc_container);
      }
      
      private function reposItemHolder(param1:MovieClip) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_) as DisplayObject;
            if(_loc3_)
            {
               _loc3_.x += _loc2_ * (this.MAX_WIDTH + 10) - (param1.numChildren - 1) * (this.MAX_WIDTH + 10) / 2;
            }
            _loc2_++;
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.fillItems();
      }
      
      protected function get comebackBonusDialogProperties() : CafeComebackBonusDialogProperties
      {
         return properties as CafeComebackBonusDialogProperties;
      }
      
      private function get comebackBonusDialog() : CafeComebackBonus
      {
         return disp as CafeComebackBonus;
      }
   }
}
