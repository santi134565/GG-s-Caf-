package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class CafeGiftBox extends MovieClip
   {
       
      
      public var btn_close:close;
      
      public var i4:GiftItem;
      
      public var i5:GiftItem;
      
      public var btn_send:CafeBasicButtonGreen;
      
      public var btn_arrow_left:left;
      
      public var btn_arrow_right:right;
      
      public var btn_sendgifts:SenGiftsButton;
      
      public var btn_mygifts:MyGiftsButton;
      
      public var txt_title:TextField;
      
      public var i0:GiftItem;
      
      public var i1:GiftItem;
      
      public var mc_empty:MovieClip;
      
      public var i2:GiftItem;
      
      public var i3:GiftItem;
      
      public function CafeGiftBox()
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
