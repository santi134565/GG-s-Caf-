package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class CoopMealContainer extends MovieClip
   {
       
      
      public var mc_dishholder:MovieClip;
      
      public var txt_amount:TextField;
      
      public function CoopMealContainer()
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
