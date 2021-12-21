package com.goodgamestudios.cafe.world.info
{
   import com.goodgamestudios.cafe.controller.CafeTutorialController;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.isocore.VisualElement;
   
   public class FridgeToolTip extends BasicToolTip
   {
      
      private static const MC_NAME:String = "FridgeToolTip";
       
      
      public function FridgeToolTip(param1:VisualElement)
      {
         super(param1);
         init(MC_NAME);
      }
      
      public function showInfoToolTip() : void
      {
         if(CafeTutorialController.getInstance().isActive)
         {
            return;
         }
         disp.txt_fridgeInfoLine1.text = CafeModel.languageData.getTextById("fridgetooltip_line1");
         disp.txt_fridgeInfoLine2.text = CafeModel.languageData.getTextById("fridgetooltip_line2");
         show();
      }
   }
}
