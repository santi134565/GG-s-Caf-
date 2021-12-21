package
{
   import flash.display.MovieClip;
   
   public dynamic class ActionPanel extends MovieClip
   {
       
      
      public var btn_achievements:achievements;
      
      public var btn_gifts:gifts;
      
      public var btn_staff:staff;
      
      public var btn_ingredientshop:ingredientshop_old;
      
      public var btn_cookbook:cookbook;
      
      public var btn_owncafe:owncafe;
      
      public var btn_coop:coop;
      
      public var btn_decoshop:decoshop;
      
      public var btn_market:market;
      
      public function ActionPanel()
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
