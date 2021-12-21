package com.goodgamestudios.utils
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   
   public class MouseWheel
   {
       
      
      private var _stage:Stage;
      
      private const mwJS:String = "" + "var browserScrolling=true;" + "function allowBrowserScroll(value){browserScrolling=value;}" + "function handle(delta){return browserScrolling;}" + "function wheel(evt){" + "\tvar delta=0;" + "\tif(!evt){evt=window.event;}" + "\tif(evt.wheelDelta){" + "\t\tdelta=evt.wheelDelta/120;" + "\t\tif(window.opera){delta=-delta;}" + "\t}else if(evt.detail){" + "\t\tdelta=-evt.detail/3;" + "\t}" + "\tif(delta){handle(delta);}" + "\tif(!browserScrolling){" + "\t\tif(evt.preventDefault){evt.preventDefault();}" + "\t\tevt.returnValue=false;" + "}\t}" + "if(window.addEventListener){window.addEventListener(\'DOMMouseScroll\',wheel,false);}" + "window.onmousewheel=document.onmousewheel=wheel;";
      
      public function MouseWheel(param1:Stage)
      {
         var s:Stage = param1;
         super();
         this._stage = s;
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("eval",this.mwJS);
               this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.eventMouseWheelFlash);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function destructor() : void
      {
         this._stage.removeEventListener(Event.MOUSE_LEAVE,this.eventMouseWheelBrowser);
         this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.eventMouseWheelFlash);
      }
      
      private function eventMouseWheelFlash(param1:MouseEvent) : void
      {
         this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.eventMouseWheelFlash);
         this._stage.addEventListener(Event.MOUSE_LEAVE,this.eventMouseWheelBrowser);
         this.allowBrowserScroll(false);
      }
      
      private function eventMouseWheelBrowser(param1:Event) : void
      {
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.eventMouseWheelFlash);
         this._stage.removeEventListener(Event.MOUSE_LEAVE,this.eventMouseWheelBrowser);
         this.allowBrowserScroll(true);
      }
      
      private function allowBrowserScroll(param1:Boolean) : void
      {
         var allow:Boolean = param1;
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("allowBrowserScroll",allow);
            }
         }
         catch(e:Error)
         {
         }
      }
   }
}
