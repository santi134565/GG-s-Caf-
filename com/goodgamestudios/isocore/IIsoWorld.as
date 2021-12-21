package com.goodgamestudios.isocore
{
   import com.goodgamestudios.input.Input;
   import com.goodgamestudios.isocore.map.IsoMap;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.vo.LevelVO;
   import com.goodgamestudios.isocore.vo.VisualVO;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public interface IIsoWorld extends IEventDispatcher
   {
       
      
      function get isRunning() : Boolean;
      
      function get lastUpdateTimestamp() : Number;
      
      function set zSortThisFrame(param1:Boolean) : void;
      
      function addLevelElement(param1:VisualVO) : VisualElement;
      
      function updateObjects(param1:String) : void;
      
      function addVisualElement(param1:VisualElement) : void;
      
      function removeVisualElement(param1:VisualElement) : void;
      
      function addDragIsoObject(param1:VisualVO) : void;
      
      function addDragTile(param1:VisualVO) : void;
      
      function addIsoObject(param1:VisualVO) : void;
      
      function removeIsoObject(param1:VisualElement) : void;
      
      function get map() : IsoMap;
      
      function set map(param1:IsoMap) : void;
      
      function get mouse() : IsoMouse;
      
      function get voClassPath() : String;
      
      function get objectClassPath() : String;
      
      function set mouse(param1:IsoMouse) : void;
      
      function get camera() : IsoCamera;
      
      function set camera(param1:IsoCamera) : void;
      
      function get input() : Input;
      
      function get isoObjects() : Array;
      
      function get levelData() : LevelVO;
      
      function set levelData(param1:LevelVO) : void;
      
      function levelDataUpdate() : void;
      
      function buildWorldFromLevelVO(param1:LevelVO) : Boolean;
      
      function getIsoObjectByPoint(param1:Point) : IsoObject;
      
      function getIsoObjectByGroup(param1:String) : Array;
      
      function spawnPlayer(param1:VisualVO) : Boolean;
      
      function spawnOtherPlayer(param1:VisualVO) : Boolean;
      
      function spawnNpc(param1:VisualVO) : Boolean;
      
      function removeNpc(param1:int) : Boolean;
      
      function doAction(param1:int, param2:Array = null) : void;
      
      function get worldStatus() : int;
      
      function destroyWorld() : void;
      
      function get worldLayer() : Sprite;
      
      function get backgroundLayer() : Sprite;
      
      function get floorLayer() : Sprite;
      
      function get floorTileLayer() : Sprite;
      
      function get objectLayer() : Sprite;
      
      function get toolTipLayer() : Sprite;
      
      function get floorBuyTilesLayer() : Sprite;
   }
}
