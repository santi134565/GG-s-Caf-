package com.goodgamestudios.cafe.world.info
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.fastfood.BasicFastfoodVO;
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   
   public class ExtrasToolTip extends BasicToolTip
   {
      
      private static const MC_NAME:String = "ExtrasToolTip";
       
      
      public function ExtrasToolTip(param1:VisualElement)
      {
         super(param1);
         init(MC_NAME);
      }
      
      public function showInfoToolTip() : void
      {
         disp.gotoAndStop(1);
         switch(parentVE.group)
         {
            case CafeConstants.GROUP_VENDINGMACHINE:
         }
         disp.txt_fridgeInfoLine1.text = CafeModel.languageData.getTextById("smoothiemaker_line1");
         disp.txt_fridgeInfoLine2.text = CafeModel.languageData.getTextById("smoothiemaker_line2");
         show();
      }
      
      public function showAmountToolTip(param1:int, param2:int) : void
      {
         var _loc3_:BasicFastfoodVO = CafeModel.wodData.voList[param1] as BasicFastfoodVO;
         disp.gotoAndStop(2);
         while(disp.mc_placeholder.numChildren > 0)
         {
            disp.mc_placeholder.removeChildAt(0);
         }
         var _loc4_:Class;
         var _loc5_:Sprite = new (_loc4_ = getDefinitionByName(_loc3_.getVisClassName()) as Class)();
         _loc5_.scaleX = _loc5_.scaleY = 0.35;
         disp.mc_placeholder.addChild(_loc5_);
         switch(parentVE.group)
         {
            case CafeConstants.GROUP_VENDINGMACHINE:
         }
         TextFieldHelper.changeTextFromatSizeByTextWidth(13,disp.txt_fridgeInfoLine1,CafeModel.languageData.getTextById("recipe_smoothiemaker_" + _loc3_.type.toLocaleLowerCase()));
         disp.txt_fridgeInfoLine2.text = CafeModel.languageData.getTextById("dialogwin_cookbook_servings",[param2]);
         show();
      }
   }
}
