package com.goodgamestudios.cafe.world.objects
{
   import com.goodgamestudios.cafe.world.objects.moving.VestedMoving;
   import com.goodgamestudios.cafe.world.vo.avatar.BasicAvatarVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   
   public class CreateAvatarHelper
   {
       
      
      public function CreateAvatarHelper()
      {
         super();
      }
      
      public static function createAvatar(param1:Array) : Sprite
      {
         var _loc6_:BasicAvatarVO = null;
         var _loc7_:* = null;
         var _loc8_:Class = null;
         var _loc9_:MovieClip = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:ColorTransform = null;
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc7_ = (_loc6_ = param1[_loc4_] as BasicAvatarVO).group + "_" + _loc6_.name + "_" + _loc6_.type + "_Preview";
            (_loc9_ = new (_loc8_ = getDefinitionByName(_loc7_) as Class)()).gotoAndStop(1);
            if(_loc9_.cc)
            {
               _loc11_ = "0x" + _loc6_.colorArray[_loc6_.currentColor];
               (_loc12_ = new ColorTransform()).color = uint(_loc11_);
               MovieClip(_loc9_.cc).transform.colorTransform = _loc12_;
            }
            _loc10_ = 0;
            while(_loc10_ < _loc9_.numChildren)
            {
               if(_loc9_.getChildAt(_loc10_) is MovieClip)
               {
                  (_loc9_.getChildAt(_loc10_) as MovieClip).stop();
               }
               _loc10_++;
            }
            _loc9_.stop();
            switch(_loc6_.name)
            {
               case VestedMoving.NAME_SKIN:
                  _loc3_[0] = _loc9_;
                  break;
               case VestedMoving.NAME_LEGS:
                  _loc3_[1] = _loc9_;
                  break;
               case VestedMoving.NAME_TOP:
                  _loc3_[2] = _loc9_;
                  break;
               case VestedMoving.NAME_FACE:
                  _loc3_[3] = _loc9_;
                  break;
               case VestedMoving.NAME_HAIR:
                  _loc3_[4] = _loc9_;
                  break;
               case VestedMoving.NAME_HAT:
                  _loc3_[5] = _loc9_;
                  break;
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_.addChild(_loc3_[_loc5_]);
            _loc5_++;
         }
         _loc2_.cacheAsBitmap = true;
         return _loc2_;
      }
   }
}
