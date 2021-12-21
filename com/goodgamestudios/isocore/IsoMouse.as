package com.goodgamestudios.isocore
{
   import com.goodgamestudios.isocore.events.IsoWorldEvent;
   import com.goodgamestudios.isocore.objects.FloorObject;
   import com.goodgamestudios.isocore.objects.IDraggable;
   import com.goodgamestudios.isocore.objects.IsoObject;
   import com.goodgamestudios.isocore.objects.IsoStaticObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   
   public class IsoMouse
   {
      
      public static const ISOMOUSE_STATE_SNAP:String = "state_snap";
      
      public static const ISOMOUSE_STATE_FREE:String = "state_free";
       
      
      private var _world:IIsoWorld;
      
      private var _mouseState:String;
      
      protected var _mouseDown:Boolean = false;
      
      private const _dragTolerance:int = 10;
      
      private const _dragToleranceOnObject:int = 25;
      
      private var _dragWorldEnabled:Boolean = true;
      
      private var _dragWorld:Boolean = false;
      
      private var _dragStartPos:Point;
      
      private var _dragToleranceTest:Boolean = false;
      
      private var _zoomEnabled:Boolean;
      
      private var _isOnObject:Boolean = false;
      
      private var _iDragObject:IDraggable;
      
      private var _iDragObjectIsLocked:Boolean;
      
      private var _selectedObject:FloorObject;
      
      private var _curIsoPos:Point;
      
      private var _curShiftIsoPos:Point;
      
      private var _cursorVE:VisualElement;
      
      private var _objectsSelectable:Boolean = true;
      
      private var _mouseIsOnWorld:Boolean;
      
      private var browserMouseEvent:MouseEvent;
      
      private var lastEventTime:uint = 0;
      
      private var eventTimeout:Number = 50;
      
      protected var _isDrawingTiles:Boolean = false;
      
      public function IsoMouse(param1:IIsoWorld)
      {
         super();
         this._world = param1;
         this.activate();
      }
      
      public function get isDrawingTiles() : Boolean
      {
         return this._isDrawingTiles;
      }
      
      public function set isDrawingTiles(param1:Boolean) : void
      {
         this._isDrawingTiles = param1;
      }
      
      public function set mouseDown(param1:Boolean) : void
      {
         this._mouseDown = param1;
      }
      
      public function activate() : void
      {
         var id:String = null;
         this._zoomEnabled = true;
         this._world.worldLayer.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._world.worldLayer.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._world.worldLayer.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this._world.worldLayer.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this._world.worldLayer.stage.addEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         this._world.worldLayer.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onBrowserMouseEvent);
         try
         {
            if(ExternalInterface.available)
            {
               id = "mws_" + Math.floor(Math.random() * 1000000);
               ExternalInterface.addCallback(id,function():void
               {
               });
               ExternalInterface.call(MouseWheelEnabler_JavaScript.CODE);
               ExternalInterface.call("mws.InitMouseWheelSupport",id);
               ExternalInterface.addCallback("externalMouseEvent",this.handleExternalMouseEvent);
            }
         }
         catch(e:Error)
         {
            trace("Adding javascript close callback failed!");
         }
      }
      
      private function onBrowserMouseEvent(param1:MouseEvent) : void
      {
         this.browserMouseEvent = param1;
      }
      
      private function handleExternalMouseEvent(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:uint;
         if((_loc4_ = getTimer()) >= this.eventTimeout + this.lastEventTime)
         {
            _loc3_ = param2;
            if(!this._world)
            {
               return;
            }
            if(this._world.worldLayer.stage && this.browserMouseEvent)
            {
               this._world.worldLayer.stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_WHEEL,true,false,this.browserMouseEvent.localX,this.browserMouseEvent.localY,this.browserMouseEvent.relatedObject,this.browserMouseEvent.ctrlKey,this.browserMouseEvent.altKey,this.browserMouseEvent.shiftKey,this.browserMouseEvent.buttonDown,int(_loc3_)));
            }
            this.lastEventTime = _loc4_;
         }
      }
      
      public function onMouseOut() : void
      {
         if(this._mouseIsOnWorld)
         {
            this._mouseIsOnWorld = false;
            if(this.isWorldDragging)
            {
               this.onMouseUp(null);
            }
            this._mouseDown = false;
         }
      }
      
      protected function onMouseLeave(param1:Event) : void
      {
         if(this.iDragObject)
         {
            this.iDragObject.stopDrag();
         }
      }
      
      public function deactivate() : void
      {
         this._world.worldLayer.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._world.worldLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._world.worldLayer.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this._world.worldLayer.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this._world.worldLayer.stage.removeEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         this._zoomEnabled = false;
         this._world.worldLayer.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onBrowserMouseEvent);
      }
      
      protected function updateIsoCursor(param1:Point) : void
      {
         if(!this._cursorVE)
         {
            return;
         }
         if(this._world.map.isOnMap(param1))
         {
            this._cursorVE.show();
            this._cursorVE.isoGridPos = param1.clone();
            this._cursorVE.drawToIsoPos();
         }
      }
      
      public function switchState(param1:String) : void
      {
         if(param1 == this._mouseState)
         {
            return;
         }
         switch(param1)
         {
            case ISOMOUSE_STATE_FREE:
               this.hideIsoCursor();
               break;
            case ISOMOUSE_STATE_SNAP:
               if(!this._cursorVE)
               {
                  this.addIsoCursor();
               }
               this.showIsoCursor();
               this.updateIsoCursor(this._curIsoPos);
         }
         this._mouseState = param1;
      }
      
      public function onMouseDown(param1:MouseEvent) : void
      {
         this._mouseDown = true;
      }
      
      public function onMouseUp(param1:MouseEvent) : void
      {
         this._world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.ISOWORLD_MOUSEUP));
         this._mouseDown = false;
         if(this._dragWorld)
         {
            this.isWorldDragging = false;
         }
         else
         {
            this.clickAction();
         }
         if(this.iDragObject)
         {
            this.iDragObject.stopDrag();
         }
         this._world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.WORLD_CHANGE,[IsoWorldEvent.NEW_OBJECT_IS_ON_MAP]));
      }
      
      protected function onMouseMove(param1:MouseEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         this._mouseIsOnWorld = true;
         var _loc2_:Point = new Point(this._world.worldLayer.mouseX,this._world.worldLayer.mouseY);
         this._curIsoPos = this._world.map.grid.pixelPosToGridPos(_loc2_);
         switch(this._mouseState)
         {
            case ISOMOUSE_STATE_FREE:
               break;
            case ISOMOUSE_STATE_SNAP:
               this.updateIsoCursor(this._curIsoPos);
         }
         if(this._mouseDown)
         {
            if(this._dragWorldEnabled)
            {
               if(!this._dragToleranceTest && !this._dragWorld)
               {
                  this._dragStartPos = new Point(param1.stageX,param1.stageY);
                  this._dragToleranceTest = true;
               }
               else if(this._dragToleranceTest && !this._dragWorld)
               {
                  _loc3_ = Math.abs(param1.stageX - this._dragStartPos.x);
                  _loc4_ = Math.abs(param1.stageY - this._dragStartPos.y);
                  _loc5_ = this._dragTolerance;
                  if(this.isOnObject)
                  {
                     _loc5_ = this._dragToleranceOnObject;
                  }
                  if(_loc3_ > _loc5_ || _loc4_ > _loc5_)
                  {
                     this._dragToleranceTest = false;
                     this._dragWorld = true;
                     this._world.dispatchEvent(new IsoWorldEvent(IsoWorldEvent.ISOWORLD_MOUSEDOWN));
                     this._world.worldLayer.startDrag(false,this._world.camera.dragBounds);
                     this.zoomEnabled = false;
                  }
               }
            }
         }
         if(this.iDragObject)
         {
            this.dragObjectAction(_loc2_);
         }
      }
      
      protected function dragObjectAction(param1:Point) : void
      {
         if(!this._iDragObjectIsLocked)
         {
            this.iDragObject.dragMove(param1);
         }
      }
      
      public function onMouseWheel(param1:MouseEvent) : void
      {
         if(this._zoomEnabled)
         {
            this._world.camera.zoom += param1.delta * 3 / 100;
         }
      }
      
      public function clickAction() : void
      {
      }
      
      public function addIsoCursor() : void
      {
      }
      
      public function showDefaultCursor() : void
      {
         Mouse.show();
      }
      
      public function hideDefaultCursor() : void
      {
         Mouse.hide();
      }
      
      public function showIsoCursor() : void
      {
         if(this._cursorVE && this._cursorVE.disp.visible == false)
         {
            this._cursorVE.disp.visible = true;
         }
      }
      
      public function hideIsoCursor() : void
      {
         if(this._cursorVE)
         {
            this._cursorVE.disp.visible = false;
         }
      }
      
      public function get cursorVE() : VisualElement
      {
         return this._cursorVE;
      }
      
      public function set cursorVE(param1:VisualElement) : void
      {
         this._cursorVE = param1;
      }
      
      public function get curIsoPos() : Point
      {
         return this._curIsoPos;
      }
      
      public function set curIsoPos(param1:Point) : void
      {
         this._curIsoPos = param1;
      }
      
      public function get world() : IIsoWorld
      {
         return this._world;
      }
      
      public function set world(param1:IIsoWorld) : void
      {
         this._world = param1;
      }
      
      public function get dragWorldEnabled() : Boolean
      {
         return this._dragWorldEnabled;
      }
      
      public function set dragWorldEnabled(param1:Boolean) : void
      {
         this._dragWorldEnabled = param1;
      }
      
      public function get zoomEnabled() : Boolean
      {
         return this._zoomEnabled;
      }
      
      public function set zoomEnabled(param1:Boolean) : void
      {
         this._zoomEnabled = param1;
      }
      
      public function get isOnObject() : Boolean
      {
         return this._isOnObject;
      }
      
      public function set isOnObject(param1:Boolean) : void
      {
         this._isOnObject = param1;
      }
      
      public function get isWorldDragging() : Boolean
      {
         return this._dragWorld;
      }
      
      public function set isWorldDragging(param1:Boolean) : void
      {
         this._dragWorld = param1;
         if(!this._dragWorld)
         {
            this._world.worldLayer.stopDrag();
            this.zoomEnabled = true;
         }
      }
      
      public function get selectedObject() : FloorObject
      {
         return this._selectedObject;
      }
      
      public function set selectedObject(param1:FloorObject) : void
      {
         this._selectedObject = param1;
      }
      
      public function lockDragObject() : void
      {
         this._iDragObjectIsLocked = true;
      }
      
      public function unLockDragObject() : void
      {
         this._iDragObjectIsLocked = false;
      }
      
      public function get iDragObjectIsLocked() : Boolean
      {
         return this._iDragObjectIsLocked;
      }
      
      public function get objectsSelectable() : Boolean
      {
         return this._objectsSelectable;
      }
      
      public function set mouseIsOnWorld(param1:Boolean) : void
      {
         this._mouseIsOnWorld = param1;
      }
      
      public function get mouseIsOnWorld() : Boolean
      {
         return this._mouseIsOnWorld;
      }
      
      public function get iDragObject() : IDraggable
      {
         return this._iDragObject;
      }
      
      public function set iDragObject(param1:IDraggable) : void
      {
         if(this._iDragObjectIsLocked)
         {
            return;
         }
         this._iDragObject = param1;
         if(this._iDragObject)
         {
            this._dragWorldEnabled = false;
            this._objectsSelectable = false;
            this.switchState(ISOMOUSE_STATE_FREE);
         }
         else
         {
            this._dragWorldEnabled = true;
            this._objectsSelectable = true;
            this.switchState(ISOMOUSE_STATE_SNAP);
         }
      }
      
      public function clearSelectedObject() : void
      {
         if(this._selectedObject)
         {
            this._selectedObject.deSelectObject();
         }
      }
      
      public function removeIDragObject() : void
      {
         if(this._iDragObject)
         {
            if(this._iDragObject is IsoObject)
            {
               this._world.removeIsoObject(this._iDragObject as VisualElement);
            }
            else
            {
               this._world.removeVisualElement(this._iDragObject as VisualElement);
            }
            this.iDragObject = null;
            this.isDrawingTiles = false;
         }
      }
      
      public function resetDragObject() : void
      {
         this.clearSelectedObject();
         var _loc1_:IsoStaticObject = this._iDragObject as IsoStaticObject;
         if(_loc1_)
         {
            _loc1_.show();
            _loc1_.changeIsoPos(_loc1_.oldIsoPos);
            _loc1_.stopDrag();
         }
         this._world.map.updateCollisionMap();
         this.iDragObject = null;
      }
   }
}

class MouseWheelEnabler_JavaScript
{
   
   public static const CODE:XML = <script><![CDATA[
			function()
			{
				// create unique namespace
				if(typeof mws == "undefined" || !mws)	
				{
					mws = {};
				}
				
				var userAgent = navigator.userAgent.toLowerCase();
				mws.agent = userAgent;
				mws.platform = 
				{
					win:/win/.test(userAgent),
					mac:/mac/.test(userAgent),
					other:!/win/.test(userAgent) && !/mac/.test(userAgent)
				};
				
				mws.vars = {};
				
				mws.browser = 
				{
					version: (userAgent.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [])[1],
					safari: /webkit/.test(userAgent) && !/chrome/.test(userAgent),
					opera: /opera/.test(userAgent),
					msie: /msie/.test(userAgent) && !/opera/.test(userAgent),
					mozilla: /mozilla/.test(userAgent) && !/(compatible|webkit)/.test(userAgent),
					chrome: /chrome/.test(userAgent)
				};
				
				// find the function we added
				mws.findSwf = function(id) 
				{
					var objects = document.getElementsByTagName("object");
					for(var i = 0; i < objects.length; i++)
					{
						if(typeof objects[i][id] != "undefined")
						{
							return objects[i];
						}
					}
					
					var embeds = document.getElementsByTagName("embed");
					
					for(var j = 0; j < embeds.length; j++)
					{
						if(typeof embeds[j][id] != "undefined")
						{
							return embeds[j];
						}
					}
						
					return null;
				}
				
				mws.usingWmode = function( swf )
				{
					if( typeof swf.getAttribute == "undefined" )
					{
						return false;
					}
					
					var wmode = swf.getAttribute( "wmode" );
					if( typeof wmode == "undefined" )
					{
						return false;
					}
					
					return true;
				}
				
				//Debug logging
				mws.log = function( message ) 
				{
					if( typeof console != "undefined" )
					{
						console.log( message );
					}
					else
					{
						//alert( message );
					}
				}
				
				mws.shouldAddHandler = function( swf )
				{
					if( !swf )
					{
						return false;
					}
					
					return true;
				}
				
				mws.getBrowserInfo = function()
				{//getBrowserObj
					return mws.browser;
				}//getBrowserObj
				
				mws.getAgentInfo = function()
				{//getAgentInfo
					return mws.agent;
				}//getAgentInfo
				
				mws.getPlatformInfo = function()
				{//getPlatformInfo
					return mws.platform;
				}//getPlatformInfo
				
				mws.addScrollListeners = function()
				{//addScrollListeners
					
					// install mouse listeners
					if(typeof window.addEventListener != 'undefined') 
					{
						window.addEventListener('DOMMouseScroll', _mousewheel, false);
					}
					
					window.onmousewheel = document.onmousewheel = _mousewheel;
					
				}//addScrollListeners
				
				mws.removeScrollListeners = function()
				{//removeScrollListeners
					// install mouse listeners
					if(typeof window.removeEventListener != 'undefined') 
					{
						window.removeEventListener('DOMMouseScroll', _mousewheel, false);
					}
					
					window.onmousewheel = document.onmousewheel = null;
				}//removeScrollListeners
				
				mws.InitMouseWheelSupport = function(id) 
				{//InitMouseWheelSupport
					//grab reference to the swf
					var swf = mws.findSwf(id);
					
					//see if we can add the mouse listeners
					var shouldAdd = mws.shouldAddHandler( swf );
					
					if( shouldAdd ) 
					{
						/// Mousewheel support
						_mousewheel = function(event) 
						{//Mouse Wheel
								
							//Cover for IE
							if (!event) event = window.event;
							
							var rawDelta = 0;
							var divisor = 1;
							var scaledDelta = 0;
							
							//Handle scaling the delta.
							//This is becoming less and less useful as more browser/hardware combos emerge.
							if(event.wheelDelta)	
							{//normal event
								rawDelta = event.wheelDelta;
								
								if(mws.browser.opera)
								{
									divisor = 12;
								}
								else if(mws.browser.safari && mws.browser.version.split(".")[0] >= 528)
								{
									divisor = 12;
								}
								else
								{
									divisor = 120;
								}
							}//normal event
							else if(event.detail)		
							{//special event
								rawDelta = -event.detail;
							}//special event
							else
							{//odd event
								//Unhandled event type (future browser graceful fail)
								rawDelta = 0;
								scaledDelta = 0;
								
								//alert('Odd Event');
							}//odd event
							
							if(Math.abs(rawDelta) >= divisor)
							{//divide
								scaledDelta = rawDelta/divisor;
							}//divide
							else
							{//don't scale
								scaledDelta = rawDelta;
							}//don't scale
							
							//Call into the swf to fire a mouse event
							swf.externalMouseEvent(rawDelta, scaledDelta);
							
							if(event.preventDefault)	
							{//Stop default action
								event.preventDefault();
							}//Stop default action
							else
							{//stop default action (IE)
								return false;
							}//stop default action (IE)
								
							return true;
						}//MouseWheel
	
						//set up listeners
						swf.onmouseover = mws.addScrollListeners;
						swf.onmouseout = mws.removeScrollListeners;
					}//Should Add
						
				}//InitMouseWheelSupport
				
			}
		]]></script>;
    
   
   function MouseWheelEnabler_JavaScript()
   {
      super();
   }
}
