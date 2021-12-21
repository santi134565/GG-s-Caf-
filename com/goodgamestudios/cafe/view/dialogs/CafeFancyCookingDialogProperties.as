package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   
   public class CafeFancyCookingDialogProperties extends BasicDialogProperties
   {
      
      public static const BUY_FANCY:String = "buyfancy";
      
      public static const USE_FANCY:String = "usefancy";
       
      
      public var dishVO:BasicDishVO;
      
      public var onClose:Function;
      
      public var onCookWithFancy:Function;
      
      public var onCookWithoutFancy:Function;
      
      public var type:String;
      
      public function CafeFancyCookingDialogProperties(param1:BasicDishVO, param2:Function, param3:Function, param4:Function = null, param5:String = "buyfancy")
      {
         this.dishVO = param1;
         this.onClose = param4;
         this.onCookWithFancy = param3;
         this.onCookWithoutFancy = param2;
         this.type = param5;
         super();
      }
   }
}
