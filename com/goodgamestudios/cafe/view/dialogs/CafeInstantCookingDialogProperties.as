package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   
   public class CafeInstantCookingDialogProperties extends BasicDialogProperties
   {
       
      
      public var stove:BasicStove;
      
      public function CafeInstantCookingDialogProperties(param1:BasicStove)
      {
         this.stove = param1;
         super();
      }
   }
}
