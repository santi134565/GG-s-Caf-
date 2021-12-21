package com.goodgamestudios.cafe.view.panels
{
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.event.CafeTutorialEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CafeTutorialPanel extends CafePanel
   {
      
      public static const NAME:String = "CafeTutorialPanel";
       
      
      private var spotLight:TutorialSpotLight;
      
      private var spotLightX:Number;
      
      private var spotLightY:Number;
      
      private var spotLightScale:Number;
      
      public function CafeTutorialPanel(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         this.tutorialPanel.btn_next.visible = false;
         this.tutorialPanel.txt_copy.wordWrap = true;
         this.tutorialPanel.txt_copy.text = "";
         super.init();
      }
      
      override protected function onTutorialEvent(param1:CafeTutorialEvent) : void
      {
         switch(tutorialController.tutorialState)
         {
            case BasicTutorialController.TUT_STATE_WELCOME:
               show();
               this.tutorialPanel.txt_copy.text = CafeModel.languageData.getTextById(tutorialController.tutorialState + "_copy",[CafeModel.userData.userName]);
               this.tutorialPanel.btn_next.visible = true;
               break;
            case CafeTutorialController.TUT_STATE_CAFEOPEN:
               show();
               this.tutorialPanel.txt_copy.text = CafeModel.languageData.getTextById(tutorialController.tutorialState + "_copy");
               this.tutorialPanel.btn_next.visible = true;
               break;
            case CafeTutorialController.TUT_STATE_COOK_PREPARESTEP_ONION:
            case CafeTutorialController.TUT_STATE_COOK_PREPARESTEP_SALAD:
            case CafeTutorialController.TUT_STATE_COOK_PREPARESTEP_TOMATO:
               show();
               this.tutorialPanel.txt_copy.text = CafeModel.languageData.getTextById(CafeTutorialController.TUT_STATE_COOK_PREPARESTEPS + "_copy");
               this.tutorialPanel.btn_next.visible = false;
               break;
            default:
               show();
               this.tutorialPanel.txt_copy.text = CafeModel.languageData.getTextById(tutorialController.tutorialState + "_copy");
               this.tutorialPanel.btn_next.visible = false;
         }
         this.setSize();
      }
      
      private function setSize() : void
      {
         this.tutorialPanel.mc_bg.width = 366.1;
         this.tutorialPanel.txt_copy.width = 262;
         var _loc1_:int = this.tutorialPanel.mc_bg.x;
         while(this.tutorialPanel.txt_copy.numLines > 7)
         {
            this.tutorialPanel.mc_bg.width += 50;
            this.tutorialPanel.txt_copy.width += 50;
            this.tutorialPanel.txt_copy.text = this.tutorialPanel.txt_copy.text;
         }
         this.tutorialPanel.mc_bg.x = _loc1_;
         this.tutorialPanel.btn_next.x = this.tutorialPanel.mc_bg.x + this.tutorialPanel.mc_bg.width - 35;
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
            case this.tutorialPanel.btn_next:
               switch(tutorialController.tutorialState)
               {
                  case BasicTutorialController.TUT_STATE_WELCOME:
                  case CafeTutorialController.TUT_STATE_CAFEOPEN:
                     tutorialController.nextStep();
               }
         }
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         if(disp && disp.stage)
         {
            _loc1_ = disp.getBounds(null);
            switch(tutorialController.tutorialState)
            {
               case CafeTutorialController.TUT_STATE_CAFEOPEN:
               case BasicTutorialController.TUT_STATE_WELCOME:
                  disp.x = -_loc1_.left - _loc1_.width / 2 + disp.stage.stageWidth / 2;
                  disp.y = -_loc1_.top - _loc1_.height / 2 + disp.stage.stageHeight / 2;
                  break;
               default:
                  disp.x = 500;
                  disp.y = disp.stage.stageHeight - _loc1_.height / 2;
            }
         }
         if(this.spotLight)
         {
            this.drawBlackWallWithSpotlight(this.spotLight,this.spotLightX,this.spotLightY,this.spotLightScale);
         }
      }
      
      public function drawBlackWallWithSpotlight(param1:TutorialSpotLight, param2:Number, param3:Number, param4:Number = 1.5) : void
      {
         this.spotLight = param1;
         this.spotLightX = param2;
         this.spotLightY = param3;
         this.spotLightScale = param4;
         var _loc5_:Sprite;
         (_loc5_ = layoutManager.tutLayer).addChild(param1);
         if(_loc5_.getChildAt(0) != param1)
         {
            _loc5_.swapChildren(_loc5_.getChildAt(0),param1);
         }
         param1.x = layoutManager.tutLayer.stage.stageWidth * param2;
         param1.y = layoutManager.tutLayer.stage.stageHeight * param3;
         param1.scaleX = param1.scaleY = param4;
      }
      
      public function removeSpotLight() : void
      {
         if(this.spotLight && this.spotLight.parent == layoutManager.tutLayer)
         {
            this.spotLight.parent.removeChild(this.spotLight);
         }
         this.spotLight = null;
         this.spotLightX = 0;
         this.spotLightY = 0;
         this.spotLightScale = 1;
      }
      
      override public function destroy() : void
      {
         this.removeSpotLight();
         super.destroy();
      }
      
      protected function get tutorialPanel() : TutorialPanelNew
      {
         return disp as TutorialPanelNew;
      }
   }
}
