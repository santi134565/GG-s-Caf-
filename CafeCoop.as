package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class CafeCoop extends MovieClip
   {
       
      
      public var btn_close:close;
      
      public var coopInfoNew:MovieClip;
      
      public var cooplist:MovieClip;
      
      public var txt_title:TextField;
      
      public var coopInfoActive:MovieClip;
      
      public var btn_info:playerinfo;
      
      public function CafeCoop()
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
