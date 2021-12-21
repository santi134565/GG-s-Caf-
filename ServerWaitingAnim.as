package
{
   import flash.display.MovieClip;
   
   public dynamic class ServerWaitingAnim extends MovieClip
   {
       
      
      public function ServerWaitingAnim()
      {
         super();
         addFrameScript(34,this.frame35);
      }
      
      function frame35() : *
      {
         gotoAndPlay(5);
      }
   }
}
