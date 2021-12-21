package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   import com.goodgamestudios.cafe.world.objects.stove.BasicStove;
   
   public class CafeCleanStoveDialogProperties extends BasicDialogProperties
   {
       
      
      public var target:BasicStove = null;
      
      public function CafeCleanStoveDialogProperties(param1:BasicStove)
      {
         this.target = param1;
         super();
      }
   }
}
