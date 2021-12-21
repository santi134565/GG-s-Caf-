package com.goodgamestudios.basic.model.components
{
   import flash.utils.Dictionary;
   
   public class BasicWodData
   {
       
      
      protected var wodXML:XML;
      
      protected var _wodXMLList:Dictionary;
      
      public function BasicWodData(param1:XML)
      {
         super();
         this.wodXML = param1;
         this.parseWodXML();
      }
      
      protected function parseWodXML() : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc1_:XMLList = this.wodXML.elements();
         this._wodXMLList = new Dictionary();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = parseInt(_loc2_.attribute("wodID"));
            this._wodXMLList[_loc3_] = _loc2_;
         }
      }
   }
}
