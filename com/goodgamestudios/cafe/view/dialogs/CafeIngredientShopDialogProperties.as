package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   import com.goodgamestudios.cafe.world.vo.fridge.BasicFridgeVO;
   
   public class CafeIngredientShopDialogProperties extends BasicDialogProperties
   {
       
      
      public var itemsPerPage:int = 8;
      
      public var target:BasicFridgeVO = null;
      
      public var filter:String = "";
      
      public function CafeIngredientShopDialogProperties()
      {
         super();
      }
   }
}
