package com.goodgamestudios.basic.vo
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class BasicDialogVO
   {
       
      
      public var name:String;
      
      public var priority:int;
      
      public var delay:int;
      
      public var properties:BasicDialogProperties;
      
      public var blockDialogs:Boolean;
      
      public function BasicDialogVO()
      {
         super();
      }
   }
}
