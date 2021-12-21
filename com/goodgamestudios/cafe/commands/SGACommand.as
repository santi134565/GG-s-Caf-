package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class SGACommand extends CafeCommand
   {
       
      
      public function SGACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_SHOP_AVAILIBILITY;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         param2.shift();
         CafeModel.ingredientShop.setAvailibility(param2);
         return true;
      }
   }
}
