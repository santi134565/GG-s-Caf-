package com.goodgamestudios.cafe.world.vo.gift
{
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.isocore.vo.VisualVO;
   
   public class GiftVO
   {
      
      public static const STANDARDGIFT:String = "standard";
       
      
      public var id:int;
      
      public var giftAmount:int;
      
      public var giftWodId:int;
      
      public var senderPlayerId:int = -1;
      
      public var date:Number = -1;
      
      public var category:String = "standard";
      
      private var _gift:VisualVO;
      
      public function GiftVO(param1:int, param2:int)
      {
         super();
         this.id = param1;
         this.giftWodId = param2;
         this._gift = CafeModel.wodData.createVObyWOD(this.giftWodId);
      }
      
      public function get giftWod() : VisualVO
      {
         return this._gift;
      }
   }
}
