package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   import com.goodgamestudios.cafe.world.vo.stove.BasicStoveVO;
   
   public class CafeCookBookDialogProperties extends BasicDialogProperties
   {
       
      
      public var itemsPerPage:int = 4;
      
      public var target:BasicStoveVO = null;
      
      public function CafeCookBookDialogProperties()
      {
         super();
      }
   }
}
