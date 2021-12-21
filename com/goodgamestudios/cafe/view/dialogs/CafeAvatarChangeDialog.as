package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.BasicButton;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.avatar.BasicAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.HairAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.LegsAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.SkinAvatarVO;
   import com.goodgamestudios.cafe.world.vo.avatar.TopAvatarVO;
   import com.goodgamestudios.isocore.vo.VOHelper;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class CafeAvatarChangeDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeAvatarChangeDialog";
      
      private static const SCALE_FACTOR:Number = 2.2;
      
      private static const TYPE_GIRL:String = "Girl";
      
      private static const TYPE_BOY:String = "Boy";
      
      private static const TYPE_COOK:String = "Cook";
       
      
      private const GENDER_GIRL:int = 1;
      
      private const GENDER_BOY:int = 2;
      
      private const GENDER_BOTH:int = 0;
      
      private var colorBtnHeight:int = 35;
      
      private var colorButtonArray:Array;
      
      private const MAX_COLORS_INAROW:int = 10;
      
      private var selectedAvatarPart:BasicButton;
      
      private var currentAvatarParts:Dictionary;
      
      private var maleAvatarParts:Array;
      
      private var femaleAvatarParts:Array;
      
      private var currentGender:int;
      
      private var currentCategory:int;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function CafeAvatarChangeDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function destroy() : void
      {
         this.clearColorArray();
         super.destroy();
      }
      
      override protected function init() : void
      {
         super.init();
         this.maleAvatarParts = new Array();
         this.femaleAvatarParts = new Array();
         this.initAvatarGroups();
         this.randomizeAvatarParts(this.femaleAvatarParts);
         this.randomizeAvatarParts(this.maleAvatarParts);
      }
      
      private function initAvatarGroups() : void
      {
         var _loc1_:VisualVO = null;
         for each(_loc1_ in CafeModel.wodData.voList)
         {
            if(_loc1_.group == CafeConstants.GROUP_AVATAR)
            {
               if(_loc1_.type == TYPE_COOK)
               {
                  this.maleAvatarParts.push(CafeModel.wodData.createVObyWOD(_loc1_.wodId));
                  this.femaleAvatarParts.push(CafeModel.wodData.createVObyWOD(_loc1_.wodId));
               }
               else
               {
                  if(_loc1_.type == TYPE_BOY)
                  {
                     this.maleAvatarParts.push(CafeModel.wodData.createVObyWOD(_loc1_.wodId));
                  }
                  if(_loc1_.type == TYPE_GIRL)
                  {
                     this.femaleAvatarParts.push(CafeModel.wodData.createVObyWOD(_loc1_.wodId));
                  }
               }
            }
         }
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
         this.isWaitingForServerMessage = false;
         this.avatarCreation.txt_title.text = CafeModel.userData.userName;
         this.currentGender = CafeModel.userData.gender;
         this.fillAvatarPartArrays(this.userAvatarParts);
         this.avatarCreation.btn_ok.label = CafeModel.languageData.getTextById("generic_register_btn_save");
         this.avatarCreation.mc_money.visible = CafeModel.userData.changAvatarPrice > 0;
         this.avatarCreation.mc_money.txt_gold.text = "x" + CafeModel.userData.changAvatarPrice;
         this.avatarCreation.btn_female.toolTipText = CafeModel.languageData.getTextById("tt_CafeAvatarCreationDialog_btn_girl");
         this.avatarCreation.btn_male.toolTipText = CafeModel.languageData.getTextById("tt_CafeAvatarCreationDialog_btn_boy");
         this.avatarCreation.btn_skin.toolTipText = CafeModel.languageData.getTextById("tt_CafeAvatarCreationDialog_btn_skin");
         this.avatarCreation.btn_hair.toolTipText = CafeModel.languageData.getTextById("tt_CafeAvatarCreationDialog_btn_hair");
         this.avatarCreation.btn_top.toolTipText = CafeModel.languageData.getTextById("tt_CafeAvatarCreationDialog_btn_tops");
         this.avatarCreation.btn_bottom.toolTipText = CafeModel.languageData.getTextById("tt_CafeAvatarCreationDialog_btn_bottoms");
         this.avatarCreation.btn_random.toolTipText = CafeModel.languageData.getTextById("dialogwin_avatar_btn_random");
      }
      
      private function fillAvatarPartArrays(param1:Array) : void
      {
         var _loc3_:BasicAvatarVO = null;
         this.currentAvatarParts = new Dictionary();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            this.currentAvatarParts[_loc3_.name] = _loc3_;
            if(_loc3_ is SkinAvatarVO)
            {
               this.avatarCreation.btn_skin.avatarVO = _loc3_;
            }
            if(_loc3_ is HairAvatarVO)
            {
               this.avatarCreation.btn_hair.avatarVO = _loc3_;
            }
            if(_loc3_ is TopAvatarVO)
            {
               this.avatarCreation.btn_top.avatarVO = _loc3_;
            }
            if(_loc3_ is LegsAvatarVO)
            {
               this.avatarCreation.btn_bottom.avatarVO = _loc3_;
            }
            _loc2_++;
         }
      }
      
      private function randomizeAvatarParts(param1:Array) : void
      {
         var _loc2_:BasicAvatarVO = null;
         var _loc3_:int = 0;
         for each(_loc2_ in param1)
         {
            _loc3_ = Math.random() * (_loc2_.colorArray.length - 1);
            if(_loc2_.colorable)
            {
               _loc2_.currentColor = _loc3_;
            }
         }
      }
      
      private function switchGender(param1:int) : void
      {
         if(param1 == this.currentGender)
         {
            return;
         }
         this.currentGender = param1;
         if(param1 == CafeModel.userData.gender)
         {
            this.fillAvatarPartArrays(this.userAvatarParts);
         }
         else
         {
            this.fillAvatarPartArrays(param1 == this.GENDER_GIRL ? this.femaleAvatarParts : this.maleAvatarParts);
         }
         this.wearAvatar();
      }
      
      override public function show() : void
      {
         super.show();
         if(this.currentGender == this.GENDER_BOY)
         {
            this.activateButton(this.avatarCreation.btn_male,this.avatarCreation.btn_female);
         }
         else
         {
            this.activateButton(this.avatarCreation.btn_female,this.avatarCreation.btn_male);
         }
         this.activateButton(this.avatarCreation.btn_hair,null);
         this.changePart(this.avatarCreation.btn_hair);
         this.wearAvatar();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.avatarCreation.btn_random:
               this.randomizeColor();
               this.wearAvatar();
               break;
            case this.avatarCreation.btn_hair:
            case this.avatarCreation.btn_skin:
            case this.avatarCreation.btn_top:
            case this.avatarCreation.btn_bottom:
               this.activateButton(param1.target as BasicButton,this.selectedAvatarPart);
               this.changePart(param1.target as BasicButton);
               break;
            case this.avatarCreation.btn_female:
               this.activateButton(this.avatarCreation.btn_female,this.avatarCreation.btn_male);
               this.switchGender(this.GENDER_GIRL);
               break;
            case this.avatarCreation.btn_male:
               this.activateButton(this.avatarCreation.btn_male,this.avatarCreation.btn_female);
               this.switchGender(this.GENDER_BOY);
               break;
            case this.avatarCreation.btn_ok:
               this.onCustomization();
               break;
            case this.avatarCreation.btn_close:
               this.hide();
         }
      }
      
      private function onCustomization() : void
      {
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         this.isWaitingForServerMessage = true;
         controller.sendServerMessageAndWait(SFConstants.C2S_CHANGE_AVATAR,[this.getAvatarParams()],SFConstants.S2C_CHANGE_AVATAR);
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_CHANGE_AVATAR)
         {
            this.hide();
         }
      }
      
      override public function hide() : void
      {
         super.hide();
         this.isWaitingForServerMessage = false;
      }
      
      private function getAvatarParams() : String
      {
         var _loc2_:BasicAvatarVO = null;
         var _loc1_:* = CafeModel.userData.userName + "+" + this.currentGender + "+";
         for each(_loc2_ in this.currentAvatarParts)
         {
            _loc1_ += _loc2_.wodId + "$" + _loc2_.currentColor + "#";
         }
         return _loc1_.slice(0,_loc1_.length - 1);
      }
      
      protected function activateButton(param1:BasicButton, param2:BasicButton) : void
      {
         if(param2 != param1)
         {
            if(param2)
            {
               param2.deselected();
            }
            param2 = param1;
            param2.selected();
         }
      }
      
      private function changePart(param1:BasicButton) : void
      {
         var _loc3_:int = 0;
         var _loc4_:AvatarColorsampleButton = null;
         var _loc5_:ColorTransform = null;
         this.selectedAvatarPart = param1;
         this.clearColorArray();
         while(this.avatarCreation.mc_colorholder.numChildren > 0)
         {
            this.avatarCreation.mc_colorholder.removeChildAt(0);
         }
         var _loc2_:BasicAvatarVO = VOHelper.clone(param1.avatarVO) as BasicAvatarVO;
         if(_loc2_.colorable)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.colorArray.length)
            {
               _loc4_ = new AvatarColorsampleButton();
               (_loc5_ = new ColorTransform()).color = uint("0x" + _loc2_.colorArray[_loc3_]);
               _loc4_.x = int(this.avatarCreation.mc_colorholder.numChildren / this.MAX_COLORS_INAROW) * this.colorBtnHeight;
               _loc4_.y = this.avatarCreation.mc_colorholder.numChildren % this.MAX_COLORS_INAROW * this.colorBtnHeight;
               _loc4_.mouseChildren = false;
               _loc4_.colorIndex = _loc3_;
               _loc4_.mc_color.transform.colorTransform = _loc5_;
               _loc4_.addEventListener(MouseEvent.CLICK,this.onChangeColor);
               this.colorButtonArray.push(_loc4_);
               this.avatarCreation.mc_colorholder.addChild(_loc4_);
               _loc3_++;
            }
         }
      }
      
      private function wearAvatar() : void
      {
         var _loc1_:Sprite = CreateAvatarHelper.createAvatar(this.currentAvatarPartsArray);
         _loc1_.mouseEnabled = false;
         _loc1_.mouseChildren = false;
         var _loc2_:Rectangle = _loc1_.getBounds(null);
         _loc1_.x = -(_loc2_.width * SCALE_FACTOR / 2 + _loc2_.left * SCALE_FACTOR);
         _loc1_.y = -(_loc2_.top * SCALE_FACTOR);
         _loc1_.scaleX = _loc1_.scaleY = SCALE_FACTOR;
         while(this.avatarCreation.mc_avatarholder.numChildren > 0)
         {
            this.avatarCreation.mc_avatarholder.removeChildAt(0);
         }
         this.avatarCreation.mc_avatarholder.addChild(_loc1_);
      }
      
      private function clearColorArray() : void
      {
         var _loc1_:AvatarColorsampleButton = null;
         if(this.colorButtonArray)
         {
            for each(_loc1_ in this.colorButtonArray)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onChangeColor);
            }
         }
         this.colorButtonArray = new Array();
      }
      
      private function onChangeColor(param1:MouseEvent) : void
      {
         this.avatarCreation.btn_ok.enableButton = true;
         var _loc2_:AvatarColorsampleButton = param1.target as AvatarColorsampleButton;
         if(this.selectedAvatarPart == null)
         {
            return;
         }
         this.currentAvatarParts[this.selectedAvatarPart.avatarVO.name].currentColor = _loc2_.colorIndex;
         this.wearAvatar();
      }
      
      private function randomizeColor() : void
      {
         var _loc1_:BasicAvatarVO = null;
         var _loc2_:int = 0;
         for each(_loc1_ in this.currentAvatarParts)
         {
            _loc2_ = Math.random() * (_loc1_.colorArray.length - 1);
            if(_loc1_.colorable)
            {
               _loc1_.currentColor = _loc2_;
            }
         }
      }
      
      private function get currentAvatarPartsArray() : Array
      {
         var _loc2_:BasicAvatarVO = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.currentAvatarParts)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      private function get userAvatarParts() : Array
      {
         var _loc2_:BasicAvatarVO = null;
         var _loc3_:BasicAvatarVO = null;
         var _loc1_:Array = [];
         for each(_loc2_ in CafeModel.userData.avatarParts)
         {
            _loc3_ = CafeModel.wodData.voList[_loc2_.wodId] as BasicAvatarVO;
            _loc3_.colorable = _loc2_.colorable;
            _loc3_.colorArray = _loc2_.colorArray;
            _loc3_.currentColor = _loc2_.currentColor;
            _loc1_[(CafeModel.userData.avatarParts as Array).indexOf(_loc2_)] = _loc3_;
         }
         return _loc1_;
      }
      
      private function get avatarCreation() : CafeAvatarCreation
      {
         return disp as CafeAvatarCreation;
      }
   }
}
