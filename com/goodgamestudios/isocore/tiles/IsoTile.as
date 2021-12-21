package com.goodgamestudios.isocore.tiles
{
   import com.goodgamestudios.isocore.VisualElement;
   import com.goodgamestudios.isocore.map.IsoMap;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class IsoTile
   {
       
      
      private var _tileTextureVO:VisualVO;
      
      private var _tileTexture:VisualElement;
      
      private var _gridPos:Point;
      
      private var _pixelPos:Point;
      
      private var _map:IsoMap;
      
      public function IsoTile(param1:IsoMap, param2:Point, param3:VisualVO = null)
      {
         super();
         this._map = param1;
         this._gridPos = param2;
         this._pixelPos = this._map.grid.gridPosToPixelPos(this._gridPos);
         this._tileTextureVO = param3;
         this.buildTileTexture();
      }
      
      private function buildTileTexture() : void
      {
         var _loc1_:Class = null;
         if(this._tileTextureVO)
         {
            this._tileTextureVO.x = this._pixelPos.x;
            this._tileTextureVO.y = this._pixelPos.y;
            _loc1_ = getDefinitionByName(this._map.world.objectClassPath + this._tileTextureVO.group.toLowerCase() + "::" + this._tileTextureVO.name + this._tileTextureVO.group) as Class;
            this._tileTexture = new _loc1_();
            this._tileTexture.initialize(this._tileTextureVO,this._map.world);
         }
      }
      
      public function set tileTextureVO(param1:VisualVO) : void
      {
         this._map.world.removeVisualElement(this._tileTexture);
         this._tileTextureVO = param1;
         this.buildTileTexture();
         this._map.world.addVisualElement(this._tileTexture);
      }
      
      public function get tileTexture() : VisualElement
      {
         return this._tileTexture;
      }
      
      public function remove() : void
      {
         this._map.world.removeVisualElement(this._tileTexture);
      }
   }
}
