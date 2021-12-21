package
{
   import com.goodgamestudios.cafe.view.BasicButton;
   
   public dynamic class BuddylistItem extends BasicButton
   {
       
      
      public function BuddylistItem()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         stop();
      }
   }
}
