package com.goodgamestudios.cafe.model.components
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.event.CafeNPCEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.view.CafeLayoutManager;
   import com.goodgamestudios.cafe.world.vo.avatar.BasicAvatarVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcbackgroundMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcguestMovingVO;
   import com.goodgamestudios.cafe.world.vo.moving.NpcwaiterMovingVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.math.MathBase;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class CafeNpcData
   {
      
      public static const MAX_NAMELENGTH:int = 12;
      
      public static const BACKGROUNDNPC_SPAWNTIME:int = 6000;
      
      private static const BACKGROUNDGUEST_WODID:int = 1608;
      
      private static const GUEST_WODID:int = 1606;
      
      private static const WAITER_WODID:int = 1602;
       
      
      private var backgroundNpcSpawnTimeEnd:Number;
      
      public var npcs:Dictionary;
      
      public function CafeNpcData()
      {
         super();
         this.resetNpcArray();
         this.backgroundNpcSpawnTimeEnd = getTimer() + BACKGROUNDNPC_SPAWNTIME;
      }
      
      public function addNpc(param1:String, param2:Boolean = false) : VisualVO
      {
         var _loc5_:int = 0;
         var _loc10_:Array = null;
         var _loc11_:BasicAvatarVO = null;
         var _loc3_:Array = param1.split("+");
         var _loc4_:int = int(_loc3_[1]);
         switch(_loc4_)
         {
            case NpcwaiterMovingVO.NPC_TYPE:
               _loc5_ = WAITER_WODID;
               break;
            case NpcguestMovingVO.NPC_TYPE:
               _loc5_ = GUEST_WODID;
               break;
            case NpcbackgroundMovingVO.NPC_TYPE:
               _loc5_ = BACKGROUNDGUEST_WODID;
         }
         var _loc6_:NpcMovingVO;
         (_loc6_ = CafeModel.wodData.createVObyWOD(_loc5_) as NpcMovingVO).npcId = int(_loc3_.shift());
         _loc6_.npc_type = int(_loc3_.shift());
         _loc6_.favorite = int(_loc3_.shift());
         _loc6_.dishId = int(_loc3_.shift());
         if(_loc5_ == GUEST_WODID)
         {
            (_loc6_ as NpcguestMovingVO).thirsty = _loc3_.shift() == 1;
         }
         _loc6_.npc_name = String(_loc3_.shift());
         _loc6_.gender = String(_loc3_.shift());
         var _loc7_:Array = _loc3_.shift().split("#");
         var _loc8_:Array = new Array();
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_.length)
         {
            _loc10_ = _loc7_[_loc9_].split("$");
            (_loc11_ = CafeModel.wodData.createVObyWOD(_loc10_.shift()) as BasicAvatarVO).currentColor = _loc10_.shift();
            _loc8_.push(_loc11_);
            _loc9_++;
         }
         _loc6_.avatarParts = _loc8_;
         this.npcs[_loc6_.npcId] = _loc6_;
         if(_loc6_.npc_type == NpcwaiterMovingVO.NPC_TYPE)
         {
            CafeModel.npcStaffData.addMember(_loc6_);
         }
         return _loc6_ as VisualVO;
      }
      
      public function resetNpcArray() : void
      {
         this.npcs = new Dictionary();
      }
      
      public function removeNpc(param1:Array) : int
      {
         var _loc2_:int = int(param1.shift());
         if(DictionaryUtil.containsKey(this.npcs,_loc2_))
         {
            if(this.npcs[_loc2_].npc_type == NpcwaiterMovingVO.NPC_TYPE)
            {
               CafeModel.npcStaffData.removeMember(_loc2_);
            }
            delete this.npcs[_loc2_];
         }
         return _loc2_;
      }
      
      public function changeNpc(param1:Array) : Array
      {
         var _loc2_:int = int(param1.shift());
         var _loc3_:String = String(param1.shift());
         var _loc4_:int = int(param1.shift());
         if(DictionaryUtil.containsKey(this.npcs,_loc2_))
         {
            this.npcs[_loc2_].npc_name = _loc3_;
            BasicController.getInstance().dispatchEvent(new CafeNPCEvent(CafeNPCEvent.CHANGED_NAME,this.npcs[_loc2_]));
            if(this.npcs[_loc2_].npc_type == NpcwaiterMovingVO.NPC_TYPE)
            {
               CafeModel.npcStaffData.trainNpc(_loc2_,_loc4_);
            }
         }
         return [_loc2_,_loc3_];
      }
      
      private function getRandomNpcParams() : String
      {
         var _loc1_:String = "-1+2+0+-1+mallguest+";
         var _loc2_:int = MathBase.random(1,2);
         _loc1_ += _loc2_ + "+";
         var _loc3_:String = _loc2_ == 1 ? "1051$" : "1052$";
         _loc3_ += MathBase.random(0,16) + "#";
         var _loc4_:String = (_loc4_ = _loc2_ == 1 ? "1001$" : "1002$") + (MathBase.random(0,16) + "#");
         var _loc5_:String = (_loc5_ = _loc2_ == 1 ? "1021$" : "1022$") + (MathBase.random(0,7) + "#");
         var _loc6_:String = (_loc6_ = _loc2_ == 1 ? "1041$" : "1042$") + (MathBase.random(0,14) + "#");
         var _loc7_:* = (_loc7_ = _loc2_ == 1 ? "1081$" : "1082$") + "0";
         return _loc1_ + (_loc3_ + _loc4_ + _loc5_ + _loc6_ + _loc7_);
      }
      
      public function update() : void
      {
         if(CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_MY_CAFE || CafeLayoutManager.getInstance().currentState == CafeLayoutManager.STATE_OTHER_CAFE)
         {
            if(this.backgroundNpcSpawnTimeEnd - getTimer() <= 0)
            {
               CafeLayoutManager.getInstance().isoScreen.isoWorld.spawnBackgroundNpc(this.addNpc(this.getRandomNpcParams()));
               this.backgroundNpcSpawnTimeEnd = getTimer() + BACKGROUNDNPC_SPAWNTIME;
            }
         }
      }
   }
}
