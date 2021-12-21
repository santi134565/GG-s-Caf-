package com.goodgamestudios.cafe.view.dialogs
{
   import flash.display.Sprite;
   
   public class CafeMultipleDialog extends CafeStandardOkDialog
   {
      
      public static const NAME:String = "CafeJobDialog";
       
      
      public function CafeMultipleDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function get isUnique() : Boolean
      {
         return false;
      }
   }
}
