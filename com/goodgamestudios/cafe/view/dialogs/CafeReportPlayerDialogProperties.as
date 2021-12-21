package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeReportPlayerDialogProperties extends BasicDialogProperties
   {
       
      
      public var reportPlayerUserId:int;
      
      public var reportPlayerName:String;
      
      public function CafeReportPlayerDialogProperties(param1:int, param2:String)
      {
         this.reportPlayerUserId = param1;
         this.reportPlayerName = param2;
         super();
      }
   }
}
