package com.goodgamestudios.cafe.world.info
{
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.objects.counter.BasicCounter;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   
   public class CounterToolTip extends BasicToolTip
   {
      
      private static const MC_NAME:String = "CounterToolTip";
      
      public static const STATE_FREE:int = 1;
      
      public static const STATE_FULL:int = 2;
       
      
      private var currentState:int;
      
      private var counterVE:BasicCounter;
      
      private var dishIconMC:MovieClip;
      
      public function CounterToolTip(param1:VisualElement)
      {
         super(param1);
         this.counterVE = param1 as BasicCounter;
         init(MC_NAME);
      }
      
      public function update() : void
      {
         switch(this.currentState)
         {
            case STATE_FULL:
               if(this.counterVE.currentDish)
               {
                  if(this.counterVE.currentDish.amount > 0)
                  {
                     disp.txt_fullInfoLine3.text = NumberStringHelper.groupString(this.counterVE.currentDish.amount,CafeModel.languageData.getTextById) + " " + CafeModel.languageData.getTextById("stovetooltip_full2");
                  }
                  else
                  {
                     this.showInfoToolTip(STATE_FREE);
                  }
               }
               else
               {
                  this.showInfoToolTip(STATE_FREE);
               }
         }
      }
      
      public function showInfoToolTip(param1:int) : void
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         if(CafeTutorialController.getInstance().isActive)
         {
            return;
         }
         disp.gotoAndStop(param1);
         if(this.currentState != param1)
         {
            this.currentState = param1;
            updateAllTextFields();
         }
         switch(this.currentState)
         {
            case STATE_FREE:
               disp.txt_emptyInfoLine1.text = CafeModel.languageData.getTextById("stovetooltip_empty1");
               disp.txt_emptyInfoLine2.text = CafeModel.languageData.getTextById("stovetooltip_empty2");
               break;
            case STATE_FULL:
               while(disp.readyPic.numChildren > 0)
               {
                  disp.readyPic.removeChildAt(0);
               }
               _loc2_ = getDefinitionByName(this.counterVE.dishMcName) as Class;
               this.dishIconMC = new _loc2_();
               this.dishIconMC.gotoAndStop(BasicDishVO.GFX_FRAME_READY);
               _loc3_ = this.dishIconMC.getBounds(null);
               this.dishIconMC.x = -(_loc3_.width / 2 + _loc3_.left);
               this.dishIconMC.y = -(_loc3_.height / 2 + _loc3_.top);
               disp.readyPic.addChild(this.dishIconMC);
               disp.txt_fullInfoLine1.text = CafeModel.languageData.getTextById("stovetooltip_full1");
               disp.txt_fullInfoLine2.text = CafeModel.languageData.getTextById("recipe_" + String(this.counterVE.currentDish.type).toLowerCase());
               disp.txt_fullInfoLine3.text = NumberStringHelper.groupString(this.counterVE.currentDish.amount,CafeModel.languageData.getTextById) + " " + CafeModel.languageData.getTextById("stovetooltip_full2");
         }
         show();
      }
   }
}
