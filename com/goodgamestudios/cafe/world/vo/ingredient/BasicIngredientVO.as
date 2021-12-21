package com.goodgamestudios.cafe.world.vo.ingredient
{
   import com.goodgamestudios.cafe.CafeConstants;
   import com.goodgamestudios.cafe.world.vo.ShopVO;
   
   public class BasicIngredientVO extends ShopVO
   {
       
      
      private var _amount:int = 0;
      
      private var _category:String = "";
      
      private var _availibility:Boolean = true;
      
      public function BasicIngredientVO()
      {
         super();
      }
      
      override public function fillFromParamXML(param1:XML) : void
      {
         super.fillFromParamXML(param1);
         this.category = param1.attribute("category");
         this.amount = param1.attribute("amount");
      }
      
      override public function calculateSaleValueCash() : int
      {
         return Math.round(itemCash / this.amount * CafeConstants.sellFactorCash + itemGold / this.amount * CafeConstants.sellFactorGold);
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function set amount(param1:int) : void
      {
         this._amount = param1;
      }
      
      public function get category() : String
      {
         return this._category;
      }
      
      public function set category(param1:String) : void
      {
         this._category = param1;
      }
      
      public function get availibility() : Boolean
      {
         return this._availibility;
      }
      
      public function set availibility(param1:Boolean) : void
      {
         this._availibility = param1;
      }
   }
}
