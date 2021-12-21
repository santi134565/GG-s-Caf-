package com.goodgamestudios.net
{
   import flash.utils.ByteArray;
   
   public class Base64
   {
      
      private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
      
      public static const version:String = "1.1.0";
       
      
      public function Base64()
      {
         super();
         throw new Error("Base64 class is static container only");
      }
      
      public static function encode(data:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(data);
         return encodeByteArray(_loc2_);
      }
      
      public static function encodeByteArray(data:ByteArray) : String
      {
         var _loc2_:* = null;
         var _loc7_:* = 0;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:String = "";
         var _loc6_:Array = new Array(4);
         data.position = 0;
         while(data.bytesAvailable > 0)
         {
            _loc2_ = [];
            _loc7_ = uint(0);
            while(_loc7_ < 3 && data.bytesAvailable > 0)
            {
               _loc2_[_loc7_] = data.readUnsignedByte();
               _loc7_++;
            }
            _loc6_[0] = (_loc2_[0] & 252) >> 2;
            _loc6_[1] = (_loc2_[0] & 3) << 4 | _loc2_[1] >> 4;
            _loc6_[2] = (_loc2_[1] & 15) << 2 | _loc2_[2] >> 6;
            _loc6_[3] = _loc2_[2] & 63;
            _loc3_ = uint(_loc2_.length);
            while(_loc3_ < 3)
            {
               _loc6_[_loc3_ + 1] = 64;
               _loc3_++;
            }
            _loc5_ = uint(0);
            while(_loc5_ < _loc6_.length)
            {
               _loc4_ += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(_loc6_[_loc5_]);
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public static function decode(data:String) : String
      {
         var _loc2_:ByteArray = decodeToByteArray(data);
         return _loc2_.readUTFBytes(_loc2_.length);
      }
      
      public static function decodeToByteArray(data:String) : ByteArray
      {
         var _loc7_:* = 0;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:ByteArray = new ByteArray();
         var _loc2_:Array = new Array(4);
         var _loc6_:Array = new Array(3);
         _loc7_ = uint(0);
         while(_loc7_ < data.length)
         {
            _loc3_ = uint(0);
            while(_loc3_ < 4 && _loc7_ + _loc3_ < data.length)
            {
               _loc2_[_loc3_] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".indexOf(data.charAt(_loc7_ + _loc3_));
               _loc3_++;
            }
            _loc6_[0] = (_loc2_[0] << 2) + ((_loc2_[1] & 48) >> 4);
            _loc6_[1] = ((_loc2_[1] & 15) << 4) + ((_loc2_[2] & 60) >> 2);
            _loc6_[2] = ((_loc2_[2] & 3) << 6) + _loc2_[3];
            _loc5_ = uint(0);
            while(_loc5_ < _loc6_.length)
            {
               if(_loc2_[_loc5_ + 1] == 64)
               {
                  break;
               }
               _loc4_.writeByte(_loc6_[_loc5_]);
               _loc5_++;
            }
            _loc7_ += 4;
         }
         _loc4_.position = 0;
         return _loc4_;
      }
   }
}
