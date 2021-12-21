package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.model.BasicModel;
   import flash.external.ExternalInterface;
   
   public class BasicUserData
   {
       
      
      protected var _userName:String = "user1";
      
      protected var _loginName:String = "user2";
      
      protected var _loginPwd:String = "pass";
      
      protected var _email:String = "";
      
      protected var _userID:int = -1;
      
      protected var _playerID:int = -1;
      
      public function BasicUserData()
      {
         super();
      }
      
      public function isGuest() : Boolean
      {
         return this.playerID == -1;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function set userName(param1:String) : void
      {
         var value:String = param1;
         this._userName = value;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("setName",this._userName);
            }
            catch(e:Error)
            {
               trace("Calling javascript function \'setName\' failed!");
            }
         }
      }
      
      public function get loginName() : String
      {
         return this._loginName;
      }
      
      public function set loginName(param1:String) : void
      {
         this._loginName = param1;
      }
      
      public function get loginPwd() : String
      {
         return this._loginPwd;
      }
      
      public function set loginPwd(param1:String) : void
      {
         this._loginPwd = param1;
      }
      
      public function get email() : String
      {
         return this._email;
      }
      
      public function set email(param1:String) : void
      {
         this._email = param1;
      }
      
      public function get userID() : int
      {
         return this._userID;
      }
      
      public function set userID(param1:int) : void
      {
         this._userID = param1;
         BasicModel.localData.saveUserID(this._userID);
      }
      
      public function get playerID() : int
      {
         return this._playerID;
      }
      
      public function set playerID(param1:int) : void
      {
         var value:int = param1;
         this._playerID = value;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("setPlayerId",this._playerID);
            }
            catch(e:Error)
            {
               trace("Calling javascript function \'setPlayerId\' failed!");
            }
         }
      }
   }
}
