package com.goodgamestudios.cafe.world.info
{
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class StoveInfoToolTip extends BasicToolTip
   {
      
      private static const MC_NAME:String = "StoveInfoToolTip";
      
      private static const MIN_WIDTH_DEFAULT:int = 120;
      
      private static const MIN_TEXTWIDTH_DEFAULT:int = 100;
      
      private static const MAX_WIDTH_DEFAULT:int = 250;
      
      public static const STATE_SPOILED:int = 1;
      
      public static const STATE_CLEAN:int = 2;
      
      public static const STATE_PREPARE:int = 3;
      
      public static const STATE_COOK:int = 4;
      
      public static const STATE_FREE:int = 5;
      
      public static const STATE_READY:int = 6;
       
      
      private var infoLine1:String;
      
      private var infoLine2:String;
      
      private var infoLine3:String;
      
      private var currentState:int;
      
      private var stoveVE:BasicStove;
      
      private var itemIcon:MovieClip;
      
      private var ingredientIconMC:Sprite;
      
      private var dishIconMC:MovieClip;
      
      private var dishReadyIconMC:MovieClip;
      
      public function StoveInfoToolTip(param1:VisualElement)
      {
         super(param1);
         this.stoveVE = param1 as BasicStove;
         init(MC_NAME);
      }
      
      public function showInfoToolTip(param1:int) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Class = null;
         var _loc6_:TextField = null;
         var _loc7_:int = 0;
         var _loc8_:Class = null;
         var _loc9_:TextField = null;
         var _loc10_:Class = null;
         disp.gotoAndStop(param1);
         show();
         if(this.currentState != param1)
         {
            this.currentState = param1;
            updateAllTextFields();
         }
         switch(this.currentState)
         {
            case STATE_SPOILED:
               disp.txt_spoiledInfoLine1.text = CafeModel.languageData.getTextById("stovetooltip_spoiled1");
               disp.txt_spoiledInfoLine2.text = CafeModel.languageData.getTextById("recipe_" + String(this.stoveVE.currentDish.type).toLowerCase());
               disp.txt_spoiledInfoLine3.text = CafeModel.languageData.getTextById("stovetooltip_spoiled2");
               if((_loc4_ = disp.txt_spoiledInfoLine1.textWidth) < disp.txt_spoiledInfoLine3.textWidth)
               {
                  _loc4_ = disp.txt_spoiledInfoLine3.textWidth;
               }
               disp.txt_spoiledInfoLine1.width = _loc4_ + 5;
               disp.txt_spoiledInfoLine2.width = _loc4_ + 5;
               disp.txt_spoiledInfoLine3.width = _loc4_ + 5;
               _loc3_ = (_loc4_ + 25) / (disp.bg.width / disp.bg.scaleX);
               disp.bg.scaleX = _loc3_;
               disp.x = this.stoveVE.disp.x - disp.bg.width / 2 + this.stoveVE.disp.width / 2;
               disp.txt_spoiledInfoLine2.x = (disp.bg.width - disp.txt_spoiledInfoLine2.width - 5) / 2;
               break;
            case STATE_CLEAN:
               if(CafeTutorialController.getInstance().isActive)
               {
                  hide();
                  return;
               }
               disp.txt_cleanInfoLine1.text = CafeModel.languageData.getTextById("stovetooltip_clean1");
               disp.txt_cleanInfoLine2.text = CafeModel.languageData.getTextById("stovetooltip_clean2");
               if((_loc4_ = disp.txt_cleanInfoLine1.textWidth) < disp.txt_cleanInfoLine2.textWidth)
               {
                  _loc4_ = disp.txt_cleanInfoLine2.textWidth;
               }
               disp.txt_cleanInfoLine1.width = _loc4_ + 5;
               disp.txt_cleanInfoLine2.width = _loc4_ + 5;
               _loc3_ = (_loc4_ + 25) / (disp.bg2.width / disp.bg2.scaleX);
               disp.bg2.scaleX = _loc3_;
               disp.x = this.stoveVE.disp.x - disp.bg2.width / 2 + this.stoveVE.disp.width / 2;
               break;
            case STATE_PREPARE:
               while(disp.preparePic.numChildren > 0)
               {
                  disp.preparePic.removeChildAt(0);
               }
               _loc5_ = getDefinitionByName(this.stoveVE.ingredientMcName) as Class;
               this.ingredientIconMC = new _loc5_();
               _loc2_ = this.ingredientIconMC.getBounds(null);
               this.ingredientIconMC.x = -(_loc2_.width / 2 + _loc2_.left);
               this.ingredientIconMC.y = -(_loc2_.height / 2 + _loc2_.top);
               disp.preparePic.addChild(this.ingredientIconMC);
               (_loc6_ = disp.txt_prepareInfoLine as TextField).width = MIN_WIDTH_DEFAULT;
               _loc6_.text = CafeModel.languageData.getTextById("stovetooltip_prepare1") + "\n" + CafeModel.languageData.getTextById(this.stoveVE.prepareStepString);
               if(_loc6_.numLines > 3)
               {
                  _loc6_.width = MAX_WIDTH_DEFAULT;
                  _loc6_.height = _loc6_.textHeight + 5;
                  _loc6_.width = _loc6_.textWidth + 5;
               }
               if((_loc7_ = _loc6_.textWidth) < MIN_TEXTWIDTH_DEFAULT)
               {
                  _loc7_ = MIN_TEXTWIDTH_DEFAULT;
               }
               _loc3_ = (_loc7_ + 25) / (disp.bg3.width / disp.bg3.scaleX);
               disp.bg3.scaleX = _loc3_;
               _loc6_.x = 10 + (_loc7_ - _loc6_.width) / 2;
               disp.x = this.stoveVE.disp.x - disp.bg3.width / 2 + this.stoveVE.disp.width / 2;
               break;
            case STATE_COOK:
               if(CafeTutorialController.getInstance().isActive)
               {
                  hide();
                  return;
               }
               while(disp.cookPic.numChildren > 0)
               {
                  disp.cookPic.removeChildAt(0);
               }
               _loc8_ = getDefinitionByName(this.stoveVE.dishMcName) as Class;
               this.dishIconMC = new _loc8_();
               this.dishIconMC.gotoAndStop(BasicDishVO.GFX_FRAME_READY);
               _loc2_ = this.dishIconMC.getBounds(null);
               this.dishIconMC.x = -(_loc2_.width / 2 + _loc2_.left);
               this.dishIconMC.y = -(_loc2_.height / 2 + _loc2_.top);
               disp.cookPic.addChild(this.dishIconMC);
               disp.txt_cookInfoLine1.text = CafeModel.languageData.getTextById("recipe_" + String(this.stoveVE.currentDish.type).toLowerCase());
               disp.x = this.stoveVE.disp.x - disp.bg4.width / 2 + 40;
               break;
            case STATE_FREE:
               if(CafeTutorialController.getInstance().isActive && CafeTutorialController.getInstance().activeIsoObject != this.stoveVE)
               {
                  hide();
                  return;
               }
               (_loc9_ = disp.txt_freeInfoLine as TextField).text = CafeModel.languageData.getTextById("stovetooltip_free");
               if(_loc9_.numLines > 2)
               {
                  _loc9_.width = MAX_WIDTH_DEFAULT;
               }
               _loc3_ = _loc9_.textWidth / MIN_WIDTH_DEFAULT;
               if(_loc3_ > 1)
               {
                  disp.bg5.scaleX = _loc3_;
                  _loc9_.width = _loc9_.textWidth + 5;
               }
               else
               {
                  disp.bg5.scaleX = 1;
                  _loc9_.width = MIN_WIDTH_DEFAULT;
               }
               disp.x = this.stoveVE.disp.x - disp.bg5.width / 2 + 40;
               _loc9_.x = 10;
               break;
            case STATE_READY:
               if(CafeTutorialController.getInstance().isActive)
               {
                  hide();
                  return;
               }
               while(disp.readyPic.numChildren > 0)
               {
                  disp.readyPic.removeChildAt(0);
               }
               _loc10_ = getDefinitionByName(this.stoveVE.dishMcName) as Class;
               this.dishReadyIconMC = new _loc10_();
               this.dishReadyIconMC.gotoAndStop(BasicDishVO.GFX_FRAME_READY);
               _loc2_ = this.dishReadyIconMC.getBounds(null);
               this.dishReadyIconMC.x = -(_loc2_.width / 2 + _loc2_.left);
               this.dishReadyIconMC.y = -(_loc2_.height / 2 + _loc2_.top);
               disp.readyPic.addChild(this.dishReadyIconMC);
               disp.txt_readyInfoLine1.text = CafeModel.languageData.getTextById("recipe_" + String(this.stoveVE.currentDish.type).toLowerCase());
               disp.txt_readyInfoLine3.text = CafeModel.languageData.getTextById("stovetooltip_ready2");
               disp.x = this.stoveVE.disp.x - disp.bg6.width / 2 + 40;
               break;
            default:
               hide();
         }
      }
      
      public function update(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = Math.min(Math.max(0,_loc3_ = Number(param1 / param2)),100);
         switch(this.currentState)
         {
            case STATE_COOK:
               disp.infoProgress.txt_infoStepText.text = CafeModel.languageData.getTextById(this.stoveVE.cookStepString);
               disp.infoProgress.barMc.scaleX = 1 - _loc3_;
               disp.infoProgress.txt_infoProgressText.text = Math.floor(100 - _loc3_ * 100) + " %";
               disp.txt_cookInfoLine2.text = TimeStringHelper.getTimeToString(param1,TimeStringHelper.TWO_TIME_FORMAT,CafeModel.languageData.getTextById);
               break;
            case STATE_READY:
               disp.txt_readyInfoLine2.text = TimeStringHelper.getShortTimeString(param1 * 1000) + " " + CafeModel.languageData.getTextById("stovetooltip_ready1");
         }
      }
   }
}
