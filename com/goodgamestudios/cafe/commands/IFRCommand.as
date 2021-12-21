package com.goodgamestudios.cafe.commands
{
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.model.CafeModel;
   
   public class IFRCommand extends CafeCommand
   {
       
      
      public function IFRCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return SFConstants.S2C_INVENTORY_FRIDGE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         param2.shift();
         CafeModel.inventoryFridge.parseInventory(param2);
         return true;
      }
   }
}
