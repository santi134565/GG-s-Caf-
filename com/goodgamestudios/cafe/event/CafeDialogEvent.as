package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeDialogEvent extends Event
   {
      
      public static const SELECT_NAME:String = "selectName";
      
      public static const CHANGE_LAYOUTSTATE:String = "changelayoutstate";
      
      public static const MOUSE_ON_DIALOG:String = "mouseondialog";
      
      public static const CHANGE_CAFE:String = "changecafe";
      
      public static const CLOSE_DIALOGS:String = "closedialog";
       
      
      public var params:Array = null;
      
      public function CafeDialogEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
