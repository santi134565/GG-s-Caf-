package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicDialogProperties;
   
   public class CafeMarketplaceBoardDialogProperties extends BasicDialogProperties
   {
       
      
      public var title:String;
      
      public var seekingJob:Boolean;
      
      public var functionRefill:Function;
      
      public var functionSign:Function;
      
      public var functionHelp:Function;
      
      public function CafeMarketplaceBoardDialogProperties(param1:String, param2:Boolean, param3:Function, param4:Function, param5:Function)
      {
         this.title = param1;
         this.seekingJob = param2;
         this.functionRefill = param3;
         this.functionSign = param4;
         this.functionHelp = param5;
         super();
      }
   }
}
