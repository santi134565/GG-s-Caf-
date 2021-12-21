package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   import com.goodgamestudios.cafe.world.objects.CafeInteractiveFloorObject;
   
   public class CafeSmoothiemakerDialogProperties extends BasicDialogProperties
   {
       
      
      public const STD_ITEMS_PER_PAGE:int = 2;
      
      public const PRO_ITEMS_PER_PAGE:int = 2;
      
      public var target:CafeInteractiveFloorObject = null;
      
      public function CafeSmoothiemakerDialogProperties(param1:CafeInteractiveFloorObject)
      {
         this.target = param1;
         super();
      }
   }
}
