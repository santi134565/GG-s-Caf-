package com.goodgamestudios.basic.view
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class Stats extends Sprite
   {
       
      
      private var _xml:XML;
      
      private var _text:TextField;
      
      private var _style:StyleSheet;
      
      private var _timer:uint;
      
      private var _fps:uint;
      
      private var _ms:uint;
      
      private var _ms_prev:uint;
      
      private var _mem:Number;
      
      private var _mem_max:Number;
      
      private var _graph:BitmapData;
      
      private var _rectangle:Rectangle;
      
      private var _fps_graph:uint;
      
      private var _mem_graph:uint;
      
      private var _mem_max_graph:uint;
      
      private var _theme:Object;
      
      public function Stats(param1:Object = null)
      {
         this._theme = {
            "bg":51,
            "fps":16776960,
            "ms":65280,
            "mem":65535,
            "memmax":16711792
         };
         super();
         if(param1)
         {
            if(param1.bg != null)
            {
               this._theme.bg = param1.bg;
            }
            if(param1.fps != null)
            {
               this._theme.fps = param1.fps;
            }
            if(param1.ms != null)
            {
               this._theme.ms = param1.ms;
            }
            if(param1.mem != null)
            {
               this._theme.mem = param1.mem;
            }
            if(param1.memmax != null)
            {
               this._theme.memmax = param1.memmax;
            }
         }
         addEventListener(Event.ADDED_TO_STAGE,this.init,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,this.kill,false,0,true);
      }
      
      public function kill(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.kill);
         removeEventListener(MouseEvent.CLICK,this.onClick);
         removeEventListener(Event.ENTER_FRAME,this.update);
      }
      
      private function init(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         graphics.beginFill(this._theme.bg);
         graphics.drawRect(0,0,70,50);
         graphics.endFill();
         this._mem_max = 0;
         this._xml = <xml><fps>FPS:</fps><ms>MS:</ms><mem>MEM:</mem><memMax>MAX:</memMax></xml>;
         this._style = new StyleSheet();
         this._style.setStyle("xml",{
            "fontSize":"9px",
            "fontFamily":"_sans",
            "leading":"-2px"
         });
         this._style.setStyle("fps",{"color":this.hex2css(this._theme.fps)});
         this._style.setStyle("ms",{"color":this.hex2css(this._theme.ms)});
         this._style.setStyle("mem",{"color":this.hex2css(this._theme.mem)});
         this._style.setStyle("memMax",{"color":this.hex2css(this._theme.memmax)});
         this._text = new TextField();
         this._text.width = 70;
         this._text.height = 50;
         this._text.styleSheet = this._style;
         this._text.condenseWhite = true;
         this._text.selectable = false;
         this._text.mouseEnabled = false;
         addChild(this._text);
         var _loc2_:Bitmap = new Bitmap(this._graph = new BitmapData(70,50,false,this._theme.bg));
         _loc2_.y = 50;
         addChild(_loc2_);
         this._rectangle = new Rectangle(0,0,1,this._graph.height);
         addEventListener(MouseEvent.CLICK,this.onClick);
         addEventListener(Event.ENTER_FRAME,this.update);
      }
      
      private function update(param1:Event) : void
      {
         this._timer = getTimer();
         if(this._timer - 1000 > this._ms_prev)
         {
            this._ms_prev = this._timer;
            this._mem = Number((System.totalMemory * 9.54e-7).toFixed(3));
            this._mem_max = this._mem_max > this._mem ? Number(this._mem_max) : Number(this._mem);
            this._fps_graph = Math.min(50,this._fps / stage.frameRate * 50);
            this._mem_graph = Math.min(50,Math.sqrt(Math.sqrt(this._mem * 5000))) - 2;
            this._mem_max_graph = Math.min(50,Math.sqrt(Math.sqrt(this._mem_max * 5000))) - 2;
            this._graph.scroll(1,0);
            this._graph.fillRect(this._rectangle,this._theme.bg);
            this._graph.setPixel(0,this._graph.height - this._fps_graph,this._theme.fps);
            this._graph.setPixel(0,this._graph.height - (this._timer - this._ms >> 1),this._theme.ms);
            this._graph.setPixel(0,this._graph.height - this._mem_graph,this._theme.mem);
            this._graph.setPixel(0,this._graph.height - this._mem_max_graph,this._theme.memmax);
            this._xml.fps = "FPS: " + this._fps + " / " + stage.frameRate;
            this._xml.mem = "MEM: " + this._mem;
            this._xml.memMax = "MAX: " + this._mem_max;
            this._fps = 0;
         }
         ++this._fps;
         this._xml.ms = "MS: " + (this._timer - this._ms);
         this._ms = this._timer;
         this._text.htmlText = this._xml;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(mouseY / height > 0.5)
         {
            --stage.frameRate;
         }
         else
         {
            ++stage.frameRate;
         }
         this._xml.fps = "FPS: " + this._fps + " / " + stage.frameRate;
         this._text.htmlText = this._xml;
      }
      
      private function hex2css(param1:int) : String
      {
         return "#" + param1.toString(16);
      }
   }
}
