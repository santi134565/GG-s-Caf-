package com.goodgamestudios.cafe.model.components
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.event.CafeNPCEvent;
   import com.goodgamestudios.cafe.world.vo.moving.NpcMovingVO;
   import flash.utils.Dictionary;
   
   public class CafeNpcStaffData
   {
       
      
      public var members:Dictionary;
      
      public function CafeNpcStaffData()
      {
         super();
         this.resetStaff();
      }
      
      public function resetStaff() : void
      {
         this.members = new Dictionary();
      }
      
      public function get numStaff() : int
      {
         return DictionaryUtil.getKeys(this.members).length;
      }
      
      public function getNpcById(param1:int) : NpcMovingVO
      {
         if(DictionaryUtil.containsKey(this.members,param1))
         {
            return this.members[param1];
         }
         return null;
      }
      
      public function addMember(param1:NpcMovingVO) : void
      {
         this.members[param1.npcId] = param1;
         BasicController.getInstance().dispatchEvent(new CafeNPCEvent(CafeNPCEvent.WAITER_ADDED,param1));
      }
      
      public function removeMember(param1:int) : void
      {
         var _loc2_:NpcMovingVO = null;
         if(DictionaryUtil.containsKey(this.members,param1))
         {
            _loc2_ = this.members[param1];
            delete this.members[param1];
            BasicController.getInstance().dispatchEvent(new CafeNPCEvent(CafeNPCEvent.WAITER_REMOVED,_loc2_));
         }
      }
      
      public function trainNpc(param1:int, param2:int) : void
      {
         if(DictionaryUtil.containsKey(this.members,param1))
         {
            this.members[param1].favorite = param2;
            BasicController.getInstance().dispatchEvent(new CafeNPCEvent(CafeNPCEvent.WAITER_TRAINED,this.members[param1]));
         }
      }
   }
}
