package com.goodgamestudios.cafe.event
{
   import com.goodgamestudios.basic.event.BasicUserEvent;
   
   public class CafeUserEvent extends BasicUserEvent
   {
      
      public static const CHANGE_USERDATA:String = "changeUserdata";
      
      public static const CHANGE_AVATAR:String = "changeAvatar";
      
      public static const CHANGE_JOBAMOUNT:String = "changeJobamount";
      
      public static const BONUS:String = "bonus";
      
      public static const LEVELUP:String = "levelup";
      
      public static const INIT_USERDATA:String = "initUserdata";
      
      public static const JOB_PAYCHECK:String = "jobpaycheck";
      
      public static const REGISTERED:String = "register";
      
      public static const REGISTER_ERROR:String = "registererror";
      
      public static const PAYMENTBONUS:String = "paymentbonus";
      
      public static const TRY_LOGIN:String = "trylogin";
      
      public static const MAILVERIFICATION_COMPLETED:String = "mailverificationCompleted";
      
      public static const MAILVERIFICATION_FAILD:String = "mailverificationFaild";
       
      
      public function CafeUserEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
