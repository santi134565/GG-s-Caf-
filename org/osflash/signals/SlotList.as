package org.osflash.signals
{
   public final class SlotList
   {
      
      public static const NIL:SlotList = new SlotList(null,null);
       
      
      public var head:ISlot;
      
      public var tail:SlotList;
      
      public var nonEmpty:Boolean = false;
      
      public function SlotList(head:ISlot, tail:SlotList = null)
      {
         super();
         if(!head && !tail)
         {
            if(NIL)
            {
               throw new ArgumentError("Parameters head and tail are null. Use the NIL element instead.");
            }
            this.nonEmpty = false;
         }
         else
         {
            if(!head)
            {
               throw new ArgumentError("Parameter head cannot be null.");
            }
            this.head = head;
            this.tail = tail || NIL;
            this.nonEmpty = true;
         }
      }
      
      public function get length() : uint
      {
         if(!this.nonEmpty)
         {
            return 0;
         }
         if(this.tail == NIL)
         {
            return 1;
         }
         var _loc1_:uint = 0;
         var _loc2_:SlotList = this;
         while(_loc2_.nonEmpty)
         {
            _loc1_++;
            _loc2_ = _loc2_.tail;
         }
         return _loc1_;
      }
      
      public function prepend(slot:ISlot) : SlotList
      {
         return new SlotList(slot,this);
      }
      
      public function append(slot:ISlot) : SlotList
      {
         if(!slot)
         {
            return this;
         }
         if(!this.nonEmpty)
         {
            return new SlotList(slot);
         }
         if(this.tail == NIL)
         {
            return new SlotList(slot).prepend(this.head);
         }
         var _loc2_:SlotList = new SlotList(this.head);
         var _loc3_:SlotList = _loc2_;
         var _loc4_:SlotList = this.tail;
         while(_loc4_.nonEmpty)
         {
            _loc3_ = _loc3_.tail = new SlotList(_loc4_.head);
            _loc4_ = _loc4_.tail;
         }
         _loc3_.tail = new SlotList(slot);
         return _loc2_;
      }
      
      public function insertWithPriority(slot:ISlot) : SlotList
      {
         var _loc6_:SlotList = null;
         if(!this.nonEmpty)
         {
            return new SlotList(slot);
         }
         var _loc2_:int = slot.priority;
         if(_loc2_ > this.head.priority)
         {
            return this.prepend(slot);
         }
         var _loc3_:SlotList = new SlotList(this.head);
         var _loc4_:SlotList = _loc3_;
         var _loc5_:SlotList = this.tail;
         while(_loc5_.nonEmpty)
         {
            if(_loc2_ > _loc5_.head.priority)
            {
               _loc6_ = _loc5_.prepend(slot);
               return new SlotList(this.head,_loc6_);
            }
            _loc4_ = _loc4_.tail = new SlotList(_loc5_.head);
            _loc5_ = _loc5_.tail;
         }
         _loc4_.tail = new SlotList(slot);
         return _loc3_;
      }
      
      public function filterNot(listener:Function) : SlotList
      {
         if(!this.nonEmpty || listener == null)
         {
            return this;
         }
         if(listener == this.head.listener)
         {
            return this.tail;
         }
         var _loc2_:SlotList = new SlotList(this.head);
         var _loc3_:SlotList = _loc2_;
         var _loc4_:SlotList = this.tail;
         while(_loc4_.nonEmpty)
         {
            if(_loc4_.head.listener == listener)
            {
               _loc3_.tail = _loc4_.tail;
               return _loc2_;
            }
            _loc3_ = _loc3_.tail = new SlotList(_loc4_.head);
            _loc4_ = _loc4_.tail;
         }
         return this;
      }
      
      public function contains(listener:Function) : Boolean
      {
         if(!this.nonEmpty)
         {
            return false;
         }
         var _loc2_:SlotList = this;
         while(_loc2_.nonEmpty)
         {
            if(_loc2_.head.listener == listener)
            {
               return true;
            }
            _loc2_ = _loc2_.tail;
         }
         return false;
      }
      
      public function find(listener:Function) : ISlot
      {
         if(!this.nonEmpty)
         {
            return null;
         }
         var _loc2_:SlotList = this;
         while(_loc2_.nonEmpty)
         {
            if(_loc2_.head.listener == listener)
            {
               return _loc2_.head;
            }
            _loc2_ = _loc2_.tail;
         }
         return null;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         var _loc2_:SlotList = this;
         while(_loc2_.nonEmpty)
         {
            _loc1_ += _loc2_.head + " -> ";
            _loc2_ = _loc2_.tail;
         }
         _loc1_ += "NIL";
         return "[List " + _loc1_ + "]";
      }
   }
}
