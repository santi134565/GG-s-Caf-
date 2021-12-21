package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class LMICommand extends CafeCommand
   {
       
      
      public function LMICommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_MASTERY_INFO;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(param1 == SFConstants.ERROR_OK)
         {
            param2.shift();
            _loc3_ = param2.shift();
            _loc4_ = _loc3_.split("#");
            CafeModel.masteryData.initMasteryDishes(_loc4_);
            return true;
         }
         return false;
      }
   }
}
