package
{
   import flash.display.MovieClip;
   
   public dynamic class CafePlayerActionChoices extends MovieClip
   {
       
      
      public var btn_friend:AddBuddy;
      
      public var btn_achievements:achievements;
      
      public var btn_visit:playervisit;
      
      public var btn_info2:playerinfo;
      
      public var btn_friend2:AddBuddy;
      
      public var btn_achievements2:achievements;
      
      public var btn_job2:JobGeben;
      
      public var btn_visit2:playervisit;
      
      public var btn_kick2:Kick;
      
      public var btn_info:playerinfo;
      
      public function CafePlayerActionChoices()
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
