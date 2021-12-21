package com.goodgamestudios.cafe.event
{
   import flash.events.Event;
   
   public class CafeIsoEvent extends Event
   {
      
      public static const START_DEKOMODE:String = "startdekomode";
      
      public static const COUNTER_CLICK:String = "counterclick";
      
      public static const FRIDGE_CLICK:String = "fridgeclick";
      
      public static const OTHERPLAYER_CLICK:String = "otherplayerclick";
      
      public static const GUEST_CLICK:String = "guestclick";
      
      public static const TABLE_CLICK:String = "tableclick";
      
      public static const STOVE_EVENT:String = "stoveevent";
      
      public static const STOVE_CLICK:int = 0;
      
      public static const STOVE_COOK:int = 1;
      
      public static const STOVE_CLEAN:int = 2;
      
      public static const STOVE_DELIVER_INFO:int = 3;
      
      public static const STOVE_DELIVER:int = 4;
      
      public static const STOVE_PREPARESTEP:int = 5;
      
      public static const CHAIR_EVENT:String = "chairevent";
      
      public static const CLICK_TABLE:int = 0;
      
      public static const CLICK_GUEST:int = 1;
      
      public static const CLICK_CHAIR:int = 2;
      
      public static const EDITOR_EVENT:String = "editorevent";
      
      public static const EDITOR_DEKOMODE_ON:int = 0;
      
      public static const EDITOR_MOVE:int = 1;
      
      public static const EDITOR_ROTATE:int = 2;
      
      public static const EDITOR_BUY:int = 3;
      
      public static const EDITOR_BUY_FLOOR:int = 4;
      
      public static const DIALOG_EVENT:String = "isodialog";
      
      public static const HERO_EVENT:String = "heroevent";
      
      public static const HERO_CHANGE_MONEY:int = 0;
      
      public static const HERO_CHANGE_JOBSTATE:int = 1;
      
      public static const HERO_PICKUP:int = 2;
      
      public static const HERO_PICKDOWN:int = 3;
      
      public static const HERO_DELIVER:int = 4;
      
      public static const HERO_CLEAN:int = 5;
      
      public static const HERO_CHANGE_XP:int = 6;
      
      public static const WORKLIST_WORKNEXTITEM:String = "worklistworknextitem";
      
      public static const WALK_TO:String = "walkto";
      
      public static const RATING_EVENT:String = "ratingevent";
      
      public static const NPC_LEAVING_CAFE:String = "npcleavingcafe";
      
      public static const MARKETPLACE_CLICK:String = "marketplaceclick";
      
      public static const MARKETPLACE_NOTICEBOARD:int = 0;
      
      public static const MARKETPLACE_SHOP:int = 1;
      
      public static const ISO_OBJECT_MOUSE_OUT:String = "isoobjectmouseout";
      
      public static const ISO_OBJECT_MOUSE_OVER:String = "isoobjectmouseover";
      
      public static const ISO_OBJECT_MOUSE_UP:String = "isoobjectmouseup";
      
      public static const ISO_OBJECT_MOUSE_DOWN:String = "isoobjectmousedown";
       
      
      public var params:Array;
      
      public function CafeIsoEvent(param1:String, param2:Array = null, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.params = param2;
      }
   }
}
