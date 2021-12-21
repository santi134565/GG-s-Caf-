package CafeInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class CoopList_241 extends MovieClip
   {
       
      
      public var btn_arrow_left:left;
      
      public var btn_arrow_right:right;
      
      public var btn_activecoops:ActiveCoops;
      
      public var i0:CoopItem;
      
      public var i1:CoopItem;
      
      public var i2:CoopItem;
      
      public var btn_newcoop:InactiveCoops;
      
      public var i3:CoopItem;
      
      public function CoopList_241()
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
