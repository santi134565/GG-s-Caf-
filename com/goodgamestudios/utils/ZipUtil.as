package com.goodgamestudios.utils
{
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   
   public class ZipUtil
   {
       
      
      public function ZipUtil()
      {
         super();
      }
      
      public static function tryUnzip(bytes:ByteArray) : ByteArray
      {
         var _loc2_:* = null;
         try
         {
            _loc2_ = unzip(bytes);
         }
         catch(e:IOError)
         {
            _loc2_ = bytes;
         }
         catch(e:Error)
         {
            _loc2_ = null;
         }
         finally
         {
            return _loc2_;
         }
      }
      
      public static function unzip(bytes:ByteArray) : ByteArray
      {
         var _loc7_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:* = 0;
         var _loc6_:ByteArray = new ByteArray();
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.endian = "littleEndian";
         bytes.position = 0;
         bytes.readBytes(_loc3_,0,30);
         _loc5_ = uint(0);
         _loc3_.position = 26;
         _loc7_ = uint(_loc3_.readUnsignedShort());
         _loc5_ += _loc7_;
         _loc3_.position = 28;
         _loc2_ = uint(_loc3_.readUnsignedShort());
         _loc5_ += _loc2_;
         bytes.readBytes(_loc3_,30,_loc5_);
         _loc3_.position = 18;
         _loc4_ = uint(_loc3_.readUnsignedInt());
         _loc6_ = new ByteArray();
         bytes.readBytes(_loc6_,0,_loc4_);
         _loc6_.inflate();
         return _loc6_;
      }
   }
}
