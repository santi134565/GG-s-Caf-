package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class CafeIShopItem extends MovieClip
   {
       
      
      public var txt_price:TextField;
      
      public var mc_itemholder:MovieClip;
      
      public var txt_notinstock:TextField;
      
      public var mc_eventview:MovieClip;
      
      public var btn_sell:sell;
      
      public var mc_money:MovieClip;
      
      public var btn_buy:buy;
      
      public var btn_wheel:wheeloffortuneBtn;
      
      public var txt_label:TextField;
      
      public var txt_level:TextField;
      
      public var mc_amount:MovieClip;
      
      public var mc_waitingcontainer:MovieClip;
      
      public var txt_amount:TextField;
      
      public var btn_unlock:packet;
      
      public function CafeIShopItem()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
