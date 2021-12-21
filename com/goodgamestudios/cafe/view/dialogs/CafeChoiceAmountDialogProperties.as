package com.goodgamestudios.cafe.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   
   public class CafeChoiceAmountDialogProperties extends BasicStandardYesNoDialogProperties
   {
      
      public static const BUTTONTYPE_STANDARD:String = "standard";
      
      public static const BUTTONTYPE_COURIER:String = "courier";
       
      
      public var maxAmount:int = 1;
      
      public var wodId:int = 1;
      
      public var buttonType_yes:String;
      
      public function CafeChoiceAmountDialogProperties(param1:int, param2:int, param3:String, param4:String, param5:String, param6:Function = null, param7:Function = null, param8:String = "Yes", param9:String = "No")
      {
         this.buttonType_yes = param5;
         this.maxAmount = param1;
         this.wodId = param2;
         super(param3,param4,param6,param7,param7,param8,param9);
      }
   }
}
