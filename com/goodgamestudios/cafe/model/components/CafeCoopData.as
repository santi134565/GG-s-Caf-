package com.goodgamestudios.cafe.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.cafe.SFConstants;
   import com.goodgamestudios.cafe.controller.clientcommands.CafeOnCoopFinishedCommand;
   import com.goodgamestudios.cafe.event.CafeCoopEvent;
   import com.goodgamestudios.cafe.model.CafeModel;
   import com.goodgamestudios.cafe.world.vo.coop.BasicCoopVO;
   import com.goodgamestudios.cafe.world.vo.coop.CoopRequirementVO;
   import com.goodgamestudios.cafe.world.vo.dish.BasicDishVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import com.goodgamestudios.math.MathBase;
   import flash.utils.Dictionary;
   
   public class CafeCoopData
   {
       
      
      private var _staticCoopList:Vector.<BasicCoopVO>;
      
      private var _activeCoopList:Vector.<BasicCoopVO>;
      
      private var _activeCoop:BasicCoopVO;
      
      public function CafeCoopData()
      {
         this._activeCoopList = new Vector.<BasicCoopVO>();
         super();
      }
      
      public function buildCoop(param1:Dictionary) : void
      {
         var _loc2_:VisualVO = null;
         var _loc3_:BasicCoopVO = null;
         this._staticCoopList = new Vector.<BasicCoopVO>();
         for each(_loc2_ in param1)
         {
            if(_loc2_.group == "Coop")
            {
               _loc3_ = CafeModel.wodData.createVObyWOD(_loc2_.wodId) as BasicCoopVO;
               this._staticCoopList.push(_loc3_);
            }
         }
         this._staticCoopList.sort(this.sortByWod);
      }
      
      public function parseActiveCoops(param1:String) : void
      {
         var _loc3_:Vector.<BasicCoopVO> = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         this._activeCoopList = new Vector.<BasicCoopVO>();
         var _loc2_:Array = param1.split("#");
         if(_loc2_[0] != "")
         {
            _loc3_ = new Vector.<BasicCoopVO>();
            for each(_loc4_ in _loc2_)
            {
               _loc5_ = _loc4_.split("+");
               this.addCoopToList(_loc5_);
            }
         }
         this._activeCoopList.sort(this.sortByWod);
         this._activeCoopList.sort(this.sortByActive);
         this.controller.dispatchEvent(new CafeCoopEvent(CafeCoopEvent.CHANGE_ACTIVE_COOPLIST));
      }
      
      public function parseCoopDetail(param1:Array) : void
      {
         var _loc8_:String = null;
         var _loc2_:int = parseInt(param1.shift());
         var _loc3_:Array = param1.shift().split("+");
         var _loc4_:int = _loc3_[0];
         var _loc5_:int = param1.shift();
         var _loc6_:Array = param1.shift().split("#");
         var _loc7_:BasicCoopVO;
         if(!(_loc7_ = this.getCoopByInstanceId(_loc4_)))
         {
            _loc7_ = this.addCoopToList(_loc3_);
         }
         else
         {
            _loc7_.runtime = parseFloat(_loc3_[2]);
            _loc7_.extendCount = parseInt(_loc3_[3]);
         }
         _loc7_.finishLevel = _loc5_;
         this.updateRequirements(_loc7_,_loc6_);
         _loc7_.coopPlayer = [];
         for each(_loc8_ in param1)
         {
            _loc7_.coopPlayer.push(CafeModel.otherUserData.buildBuddyVO(_loc8_));
         }
         if(_loc2_)
         {
            this._activeCoop = _loc7_;
         }
         this.checkCoopFinish();
         this.controller.dispatchEvent(new CafeCoopEvent(CafeCoopEvent.CHANGE_ACTIVE_DETAILS,[_loc7_]));
      }
      
      public function setActiveCoopFinishLevel(param1:int = -1) : void
      {
         if(this.activeCoop)
         {
            this.activeCoop.finishLevel = param1;
            this.checkCoopFinish();
         }
      }
      
      public function checkCoopFinish() : void
      {
         if(this.activeCoop && this.activeCoop.finishLevel > -1)
         {
            this.controller.dispatchEvent(new CafeCoopEvent(CafeCoopEvent.COOP_FINISHED,[this.activeCoop.finishLevel,this.activeCoop.rewardCash(this.activeCoop.finishLevel),this.activeCoop.rewardGold(this.activeCoop.finishLevel),this.activeCoop.rewardXP(this.activeCoop.finishLevel),this.activeCoop.type]));
            CommandController.instance.executeCommand(CafeOnCoopFinishedCommand.COMMAND_NAME,[this.activeCoop.finishLevel,this.activeCoop.rewardCash(this.activeCoop.finishLevel),this.activeCoop.rewardGold(this.activeCoop.finishLevel),this.activeCoop.rewardXP(this.activeCoop.finishLevel),this.activeCoop.type]);
            this._activeCoop = null;
         }
      }
      
      private function addCoopToList(param1:Array) : BasicCoopVO
      {
         var _loc2_:int = parseFloat(param1.shift());
         var _loc3_:int = parseInt(param1.shift());
         var _loc4_:BasicCoopVO;
         (_loc4_ = CafeModel.wodData.createVObyWOD(_loc3_) as BasicCoopVO).coopInstanceID = _loc2_;
         _loc4_.runtime = parseFloat(param1.shift());
         _loc4_.extendCount = parseInt(param1.shift());
         this._activeCoopList.push(_loc4_);
         return _loc4_;
      }
      
      public function minLevelByCoop(param1:BasicCoopVO) : int
      {
         var _loc3_:CoopRequirementVO = null;
         var _loc4_:BasicDishVO = null;
         var _loc2_:int = int.MAX_VALUE;
         for each(_loc3_ in param1.requirements)
         {
            _loc4_ = CafeModel.wodData.createVObyWOD(_loc3_.dishWodId) as BasicDishVO;
            _loc2_ = MathBase.min(_loc2_,_loc4_.level);
         }
         return _loc2_;
      }
      
      private function updateRequirements(param1:BasicCoopVO, param2:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:CoopRequirementVO = null;
         for each(_loc3_ in param2)
         {
            _loc5_ = (_loc4_ = _loc3_.split("+")).shift();
            _loc6_ = _loc4_.shift();
            for each(_loc7_ in param1.requirements)
            {
               if(_loc7_.dishWodId == _loc5_)
               {
                  _loc7_.amountDone = _loc6_;
               }
            }
         }
      }
      
      public function getCoopByInstanceId(param1:int) : BasicCoopVO
      {
         var _loc2_:BasicCoopVO = null;
         for each(_loc2_ in this._activeCoopList)
         {
            if(_loc2_.coopInstanceID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getActiveCoopFromServer() : void
      {
         this.clearActiveCoop();
         CafeModel.smartfoxClient.sendMessage(SFConstants.C2S_COOP_DETAIL,[-2]);
      }
      
      public function clearActiveCoop() : void
      {
         this._activeCoop = null;
      }
      
      private function sortByWod(param1:BasicCoopVO, param2:BasicCoopVO) : Number
      {
         if(param1.isSpecialEvent())
         {
            return -1;
         }
         if(param2.isSpecialEvent())
         {
            return 1;
         }
         if(param1.wodId < param2.wodId)
         {
            return -1;
         }
         if(param1.wodId > param2.wodId)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortByActive(param1:BasicCoopVO, param2:BasicCoopVO) : Number
      {
         if(this.activeCoop)
         {
            if(param1.coopInstanceID == this.activeCoop.coopInstanceID)
            {
               return -1;
            }
            return 1;
         }
         return 0;
      }
      
      public function get staticCoopList() : Vector.<BasicCoopVO>
      {
         return this._staticCoopList;
      }
      
      public function get activeCoopList() : Vector.<BasicCoopVO>
      {
         return this._activeCoopList;
      }
      
      public function get activeCoop() : BasicCoopVO
      {
         return this._activeCoop;
      }
      
      private function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
   }
}
