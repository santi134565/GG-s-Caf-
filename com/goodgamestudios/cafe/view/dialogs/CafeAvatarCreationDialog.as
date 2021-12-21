package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.event.CafeDialogEvent;
   import com.goodgamestudios.cafe.event.CafeUserEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.CreateAvatarHelper;
   import com.goodgamestudios.cafe.world.vo.avatar.BasicAvatarVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.constants.CommonGameStates;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CafeAvatarCreationDialog extends CafeDialog
   {
      
      public static const NAME:String = "CafeAvatarSelectionDialog";
      
      private static const SCALE_FACTOR:Number = 1.7;
      
      private static const TYPE_GIRL:String = "Girl";
      
      private static const TYPE_BOY:String = "Boy";
      
      private static const TYPE_COOK:String = "Cook";
      
      private static const FORCE_EMBED_AVATAR_GRAPHICS:Array = [Avatar_Face_Boy_Preview,Avatar_Face_Girl_Preview,Avatar_Hair_Boy_Preview,Avatar_Hair_Girl_Preview,Avatar_Hat_Cook_Preview,Avatar_Hat_Cookxmas_Preview,Avatar_Hat_Normal_Preview,Avatar_Legs_Boy_Preview,Avatar_Legs_Girl_Preview,Avatar_Skin_Boy_Preview,Avatar_Skin_Girl_Preview,Avatar_Top_Boy_Preview,Avatar_Top_Girl_Preview];
       
      
      private const SENDTHISIFWRONG:String = ".";
      
      private var selectedButton:MovieClip;
      
      private var maleAvatarParts:Array;
      
      private var femaleAvatarParts:Array;
      
      private var isWaitingForServerMessage:Boolean;
      
      private var waitingAnim:MovieClip;
      
      private var colorMatrix:ColorMatrix;
      
      private var nameSelectionToolTip:CafeAvatarNameSelectionDialog;
      
      public function CafeAvatarCreationDialog(param1:Sprite)
      {
         this.colorMatrix = new ColorMatrix();
         super(param1);
      }
      
      override protected function init() : void
      {
         this.colorMatrix.adjustBrightness(-45,-45,-45);
         if(this.enableNameInput)
         {
            this.cafeAvatarCreation.gotoAndStop(2);
         }
         else
         {
            this.cafeAvatarCreation.gotoAndStop(1);
         }
         this.cafeAvatarCreation.btn_male.mouseChildren = false;
         this.cafeAvatarCreation.btn_female.mouseChildren = false;
         this.selectedButton = this.cafeAvatarCreation.btn_female;
         this.activateButton(this.cafeAvatarCreation.btn_male);
         this.maleAvatarParts = new Array();
         this.femaleAvatarParts = new Array();
         this.cafeAvatarCreation.btn_female.mc_holder.scaleX = -1;
         this.initAvatarGroups();
         this.randomizeAvatarParts(this.femaleAvatarParts);
         this.randomizeAvatarParts(this.maleAvatarParts);
         this.fillItems();
         super.init();
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target == this.cafeAvatarCreation.btn_female || param1.target == this.cafeAvatarCreation.btn_male)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
         super.onMouseOver(param1);
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         if(param1.target == this.cafeAvatarCreation.btn_female || param1.target == this.cafeAvatarCreation.btn_male)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
         super.onRollOut(param1);
      }
      
      private function onShowNameselection(param1:CafeDialogEvent) : void
      {
         if(this.nameSelectionToolTip == null)
         {
            this.nameSelectionToolTip = new CafeAvatarNameSelectionDialog(new CafeAvatarNameSelection());
            this.cafeAvatarCreation.nameInput.addChild(this.nameSelectionToolTip.disp);
         }
         this.nameSelectionToolTip.showNames(param1.params);
      }
      
      private function resetHelp() : void
      {
         this.cafeAvatarCreation.btn_login.enableButton = true;
         if(this.nameSelectionToolTip)
         {
            this.nameSelectionToolTip.hide();
         }
      }
      
      private function onChangeState(param1:CafeDialogEvent) : void
      {
         if(layoutManager.inGameState)
         {
            this.hide();
         }
      }
      
      override public function show() : void
      {
         CafeModel.userData.changAvatarPrice = 0;
         if(this.avatarCreationProperties.registerWithFacebook)
         {
            env.gameState = CommonGameStates.REGISTER_FACEBOOK;
         }
         else
         {
            env.gameState = CommonGameStates.AVATAR_CREATION;
         }
         super.show();
         this.isWaitingForServerMessage = false;
         controller.addEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeState);
         controller.addEventListener(CafeDialogEvent.SELECT_NAME,this.onSelectName);
         controller.addEventListener(CafeUserEvent.REGISTER_ERROR,this.onRegisterError);
         if(env.loginIsKeyBased)
         {
            if(env.gender == "male")
            {
               this.activateButton(this.cafeAvatarCreation.btn_male);
            }
            if(env.gender == "female")
            {
               this.activateButton(this.cafeAvatarCreation.btn_female);
            }
         }
         else
         {
            this.activateButton(this.cafeAvatarCreation.btn_female);
         }
         this.cafeAvatarCreation.txt_title.text = CafeModel.languageData.getTextById("dialogwin_avatarcreate_txt_avatar_title");
         if(this.cafeAvatarCreation.currentFrame == 1)
         {
            this.cafeAvatarCreation.btn_random.label = CafeModel.languageData.getTextById("dialogwin_avatarcreate_random");
            this.cafeAvatarCreation.mc_changeoutfit.x = this.cafeAvatarCreation.btn_random.x - this.cafeAvatarCreation.btn_random.width / 2 - 10;
            this.cafeAvatarCreation.mc_changeoutfit.mouseEnabled = false;
         }
         else
         {
            this.cafeAvatarCreation.nameInput.inputField.text = env.displayName != "" ? env.displayName : CafeModel.languageData.getTextById("generic_name");
         }
         this.cafeAvatarCreation.btn_ok.label = CafeModel.languageData.getTextById("btn_text_okay");
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
      }
      
      override public function hide() : void
      {
         this.isWaitingForServerMessage = false;
         controller.removeEventListener(CafeDialogEvent.SELECT_NAME,this.onSelectName);
         controller.removeEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeState);
         controller.removeEventListener(CafeUserEvent.REGISTER_ERROR,this.onRegisterError);
         super.hide();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(CafeDialogEvent.SELECT_NAME,this.onSelectName);
         controller.removeEventListener(CafeDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeState);
         controller.removeEventListener(CafeUserEvent.REGISTER_ERROR,this.onRegisterError);
      }
      
      private function onSelectName(param1:CafeDialogEvent) : void
      {
         var _loc2_:String = !!param1.params ? param1.params.shift() : "";
         this.cafeAvatarCreation.nameInput.inputField.text = _loc2_;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.cafeAvatarCreation.btn_female:
            case this.cafeAvatarCreation.btn_male:
               this.activateButton(param1.target as MovieClip);
               break;
            case this.cafeAvatarCreation.btn_ok:
               this.onLogin();
               break;
            case this.cafeAvatarCreation.btn_random:
               this.randomizeAvatarParts(this.femaleAvatarParts);
               this.randomizeAvatarParts(this.maleAvatarParts);
               this.fillItems();
               break;
            case this.cafeAvatarCreation.btn_close:
               this.hide();
               if(this.waitingAnim && this.waitingAnim.parent == this.cafeAvatarCreation.btn_ok)
               {
                  this.cafeAvatarCreation.btn_ok.removeChild(this.waitingAnim);
               }
               if(this.enableNameInput)
               {
                  CommandController.instance.executeCommand(BasicController.COMMAND_LOGOUT);
               }
         }
      }
      
      private function onLogin() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         if(this.cafeAvatarCreation.currentFrame == 2 && !TextValide.isSmartFoxValide(this.cafeAvatarCreation.nameInput.inputField.text))
         {
            _loc3_ = this.cafeAvatarCreation.nameInput.inputField.text;
            if(!TextValide.isSmartFoxValide(_loc3_) || _loc3_ == "")
            {
               _loc3_ = this.SENDTHISIFWRONG;
            }
            else
            {
               CafeModel.userData.userName = _loc3_;
            }
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("createavatar_error"),CafeModel.languageData.getTextById("createavatar_error_invalide")));
            return;
         }
         if(!this.selectedButton)
         {
            layoutManager.showDialog(CafeStandardOkDialog.NAME,new BasicStandardOkDialogProperties(CafeModel.languageData.getTextById("createavatar_error"),CafeModel.languageData.getTextById("createavatar_error_nogender")));
            return;
         }
         this.isWaitingForServerMessage = true;
         this.waitingAnim = new ServerWaitingAnim();
         this.cafeAvatarCreation.btn_ok.addChild(this.waitingAnim);
         if(this.enableNameInput)
         {
            CafeModel.userData.userName = TextValide.getValideSmartFoxText(this.cafeAvatarCreation.nameInput.inputField.text);
         }
         var _loc1_:int = 1;
         if(this.enableNameInput)
         {
            _loc1_ = 2;
         }
         if(this.selectedButton == this.cafeAvatarCreation.btn_male)
         {
            CafeModel.userData.avatarParts = this.maleAvatarParts;
            _loc2_ = this.parsAvatarArray(this.maleAvatarParts);
            controller.sendServerMessageAndWait(SFConstants.C2S_CREATE_AVATAR,[CafeModel.userData.userName + "+2+" + _loc2_,_loc1_,CafeModel.smartfoxClient.connectionTime,CafeModel.smartfoxClient.roundTripTime,env.accountId],SFConstants.S2C_CREATE_AVATAR);
         }
         else
         {
            CafeModel.userData.avatarParts = this.femaleAvatarParts;
            _loc2_ = this.parsAvatarArray(this.femaleAvatarParts);
            controller.sendServerMessageAndWait(SFConstants.C2S_CREATE_AVATAR,[CafeModel.userData.userName + "+1+" + _loc2_,_loc1_,CafeModel.smartfoxClient.connectionTime,CafeModel.smartfoxClient.roundTripTime,env.accountId],SFConstants.S2C_CREATE_AVATAR);
         }
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == SFConstants.S2C_CREATE_AVATAR)
         {
            if(this.waitingAnim && this.waitingAnim.parent == this.cafeAvatarCreation.btn_ok)
            {
               this.cafeAvatarCreation.btn_ok.removeChild(this.waitingAnim);
               this.isWaitingForServerMessage = false;
            }
         }
      }
      
      protected function activateButton(param1:MovieClip) : void
      {
         if(this.selectedButton != param1)
         {
            if(this.selectedButton)
            {
               this.selectedButton.gotoAndStop(1);
               this.selectedButton.scaleX = this.selectedButton.scaleY = 0.9;
               this.selectedButton.filters = [this.colorMatrix.filter];
            }
            this.selectedButton = param1;
            this.selectedButton.gotoAndStop(2);
            this.selectedButton.scaleX = this.selectedButton.scaleY = 1;
            this.selectedButton.filters = [];
         }
      }
      
      private function parsAvatarArray(param1:Array) : String
      {
         var _loc3_:BasicAvatarVO = null;
         var _loc2_:* = "";
         for each(_loc3_ in param1)
         {
            if(_loc2_.length > 0)
            {
               _loc2_ += "#";
            }
            _loc2_ += _loc3_.wodId + "$" + _loc3_.currentColor;
         }
         return _loc2_;
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
      
      private function fillItems() : void
      {
         var _loc1_:NpcMovingVO = CafeModel.wodData.createVObyWOD(1606) as NpcMovingVO;
         _loc1_.gender = "1";
         _loc1_.avatarParts = this.femaleAvatarParts;
         var _loc2_:NpcMovingVO = CafeModel.wodData.createVObyWOD(1606) as NpcMovingVO;
         _loc2_.gender = "2";
         _loc2_.avatarParts = this.maleAvatarParts;
         this.fillItem(this.cafeAvatarCreation.btn_female,_loc1_);
         this.fillItem(this.cafeAvatarCreation.btn_male,_loc2_);
      }
      
      private function fillItem(param1:MovieClip, param2:NpcMovingVO) : void
      {
         var _loc3_:Sprite = CreateAvatarHelper.createAvatar(param2.avatarParts);
         param1.stop();
         _loc3_.mouseEnabled = false;
         _loc3_.mouseChildren = false;
         var _loc4_:Rectangle = _loc3_.getBounds(null);
         _loc3_.scaleX *= -1;
         _loc3_.x = -(_loc4_.width * SCALE_FACTOR / 2 + _loc4_.left * SCALE_FACTOR);
         _loc3_.y = -(_loc4_.top * SCALE_FACTOR) / 1.5;
         _loc3_.scaleX = _loc3_.scaleY = SCALE_FACTOR;
         _loc3_.scaleX *= -1;
         _loc3_.x += _loc3_.width * 1.15;
         while(param1.mc_holder.numChildren > 0)
         {
            param1.mc_holder.removeChildAt(0);
         }
         param1.mc_holder.addChild(_loc3_);
      }
      
      private function onRegisterError(param1:CafeUserEvent) : void
      {
         var _loc2_:int = param1.params.shift();
         var _loc3_:String = "";
         switch(_loc2_)
         {
            case 93:
               param1.params = param1.params[0];
               param1.params.shift();
               _loc3_ = param1.params.shift();
               layoutManager.showDialog(CafeAvatarNameSelectionDialog.NAME,new CafeAvatarNameSelectionDialogProperties(param1.params.shift().split("#"),_loc3_));
               break;
            case 18:
            case 12:
            case 97:
               param1.params[0].shift();
               layoutManager.showDialog(CafeAvatarNameSelectionDialog.NAME,new CafeAvatarNameSelectionDialogProperties(param1.params.shift().shift().split("#")));
         }
      }
      
      private function get enableNameInput() : Boolean
      {
         return env.networkId != GoodgamePartners.NETWORK_DEFAULT;
      }
      
      protected function get avatarCreationProperties() : CafeAvatarCreationDialogProperties
      {
         return properties as CafeAvatarCreationDialogProperties;
      }
      
      private function get cafeAvatarCreation() : CafeAvatarSelection
      {
         return disp as CafeAvatarSelection;
      }
   }
}
