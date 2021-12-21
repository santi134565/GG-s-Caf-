package com.goodgamestudios.basic.view.dialogs
{
   import com.goodgamestudios.basic.model.BasicModel;
   
   public class BasicStandardYesNoDialogProperties extends BasicDialogProperties
   {
       
      
      public var buttonLabel_yes:String = "Yes";
      
      public var buttonLabel_no:String = "No";
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public var functionClose:Function;
      
      public function BasicStandardYesNoDialogProperties(param1:String, param2:String, param3:Function = null, param4:Function = null, param5:Function = null, param6:String = "", param7:String = "")
      {
         this.functionClose = param5;
         this.functionYes = param3;
         this.functionNo = param4;
         if(param6.length > 0)
         {
            this.buttonLabel_yes = param6;
         }
         else
         {
            this.buttonLabel_yes = BasicModel.languageData.getTextById("generic_btn_yes");
         }
         if(param7.length > 0)
         {
            this.buttonLabel_no = param7;
         }
         else
         {
            this.buttonLabel_no = BasicModel.languageData.getTextById("generic_btn_no");
         }
         this.title = param1;
         this.copy = param2;
         super();
      }
   }
}
