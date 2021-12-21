package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class CafeBonus extends MovieClip
   {
       
      
      public var mc_iconholder:MovieClip;
      
      public var btn_ok:CafeBasicButtonGreen;
      
      public var btn_cancle:CafeBasicButtonGrey;
      
      public var mc_achievementholder:MovieClip;
      
      public var mc_wheelOfFortune:MovieClip;
      
      public var btn_playWheelOfFortune:CafeBasicButtonViolett;
      
      public var mc_loginscreen:MovieClip;
      
      public var txt_lvluphead2:TextField;
      
      public var txt_lvluphead1:TextField;
      
      public var txt_title:TextField;
      
      public var txt_copy:TextField;
      
      public var btn_share:Teilen;
      
      public var txt_wheelOfFortune:TextField;
      
      public function CafeBonus()
      {
         super();
         addFrameScript(0,this.frame1,5,this.frame6,6,this.frame7);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame6() : *
      {
         stop();
      }
      
      function frame7() : *
      {
         stop();
      }
   }
}
