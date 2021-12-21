package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class GiftItem extends MovieClip
   {
       
      
      public var btn_remove:RemoveButton;
      
      public var btn_action:CafeBasicButtonGreen;
      
      public var btn_use:UseButton;
      
      public var mc_new:MovieClip;
      
      public var mc_holder:MovieClip;
      
      public var btn_select:CheckBox;
      
      public var txt_title:TextField;
      
      public var txt_sender:TextField;
      
      public var txt_amount:TextField;
      
      public function GiftItem()
      {
         super();
      }
   }
}
