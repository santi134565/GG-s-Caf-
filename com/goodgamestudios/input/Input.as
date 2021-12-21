package com.goodgamestudios.input
{
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Input
   {
      
      private static const BUFFER_SIZE:int = 5;
      
      private static var _instance:Input;
       
      
      public var lastKeyName:String = "";
      
      public var lastKeyCode:int = 0;
      
      public var isMouseDown:Boolean = false;
      
      public var isMouseReleased:Boolean = false;
      
      public var mousePos:Vector2D;
      
      public var mouseX:Number = 0;
      
      public var mouseY:Number = 0;
      
      public var mouseDelta:int = 0;
      
      public var _keyBuffer:Array;
      
      private var _stage:Stage;
      
      private var _ascii:Array;
      
      private var _keyState:Array;
      
      private var _keyArr:Array;
      
      private var _bufferSize:int;
      
      private var _timeKeyPressed:int;
      
      private var _timeKeyReleased:int;
      
      private var _timeMousePressed:int;
      
      private var _timeMouseReleased:int;
      
      private var _nt:int;
      
      private var _ot:int;
      
      private var _dt:int;
      
      private var _hasMouseScrolled:Boolean;
      
      public function Input(param1:SingletonEnforcer)
      {
         super();
         this._timeKeyPressed = this._nt = this._ot = getTimer();
         this._dt = 0;
         this.mousePos = new Vector2D();
         this._ascii = new Array(222);
         this.fillAscii();
         this._keyState = new Array(222);
         this._keyArr = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 222)
         {
            this._keyState[_loc2_] = new int(0);
            if(this._ascii[_loc2_] != undefined)
            {
               this._keyArr.push(_loc2_);
            }
            _loc2_++;
         }
         this._bufferSize = Input.BUFFER_SIZE;
         this._keyBuffer = new Array(this._bufferSize);
         var _loc3_:int = 0;
         while(_loc3_ < this._bufferSize)
         {
            this._keyBuffer[_loc3_] = new Array(0,0);
            _loc3_++;
         }
      }
      
      public static function get instance() : Input
      {
         if(Input._instance == null)
         {
            Input._instance = new Input(new SingletonEnforcer());
         }
         return Input._instance;
      }
      
      public function get timeSinceLastKeyPress() : int
      {
         return getTimer() - this._timeKeyPressed;
      }
      
      public function get timeSinceLastKeyRelease() : int
      {
         return getTimer() - this._timeKeyReleased;
      }
      
      public function get timeSinceMousePressed() : int
      {
         return getTimer() - this._timeMousePressed;
      }
      
      public function get timeSinceMouseReleased() : int
      {
         return getTimer() - this._timeMouseReleased;
      }
      
      public function get hasMouseScrolled() : Boolean
      {
         if(this._hasMouseScrolled)
         {
            this._hasMouseScrolled = false;
            return true;
         }
         return false;
      }
      
      public function activate(param1:Stage) : void
      {
         this._stage = param1;
         param1.addEventListener(KeyboardEvent.KEY_DOWN,this.keyPress,false,0,true);
         param1.addEventListener(KeyboardEvent.KEY_UP,this.keyRelease,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.mousePress,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_UP,this.mouseRelease,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseScroll,false,0,true);
      }
      
      public function update() : void
      {
         this._nt = getTimer();
         this._dt = this._nt - this._ot;
         this._ot = this._nt;
         var _loc1_:int = 0;
         while(_loc1_ < this._keyArr.length)
         {
            if(this._keyState[this._keyArr[_loc1_]] != 0)
            {
               ++this._keyState[this._keyArr[_loc1_]];
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._bufferSize)
         {
            this._keyBuffer[_loc2_][1] += this._dt;
            _loc2_++;
         }
         this.isMouseReleased = false;
      }
      
      public function isKeyDown(param1:int) : Boolean
      {
         return this._keyState[param1] > 0;
      }
      
      public function isKeyPressed(param1:int) : Boolean
      {
         return this._keyState[param1] == 1;
      }
      
      public function isKeyReleased(param1:int) : Boolean
      {
         return this._keyState[param1] == -1;
      }
      
      public function isKeyInBuffer(param1:int, param2:int, param3:int) : Boolean
      {
         return this._keyBuffer[param2][0] == param1 && this._keyBuffer[param2][1] <= param3;
      }
      
      public function getKeyString(param1:int) : String
      {
         return this._ascii[param1];
      }
      
      private function fillAscii() : void
      {
         this._ascii[65] = "A";
         this._ascii[66] = "B";
         this._ascii[67] = "C";
         this._ascii[68] = "D";
         this._ascii[69] = "E";
         this._ascii[70] = "F";
         this._ascii[71] = "G";
         this._ascii[72] = "H";
         this._ascii[73] = "I";
         this._ascii[74] = "J";
         this._ascii[75] = "K";
         this._ascii[76] = "L";
         this._ascii[77] = "M";
         this._ascii[78] = "N";
         this._ascii[79] = "O";
         this._ascii[80] = "P";
         this._ascii[81] = "Q";
         this._ascii[82] = "R";
         this._ascii[83] = "S";
         this._ascii[84] = "T";
         this._ascii[85] = "U";
         this._ascii[86] = "V";
         this._ascii[87] = "W";
         this._ascii[88] = "X";
         this._ascii[89] = "Y";
         this._ascii[90] = "Z";
         this._ascii[48] = "0";
         this._ascii[49] = "1";
         this._ascii[50] = "2";
         this._ascii[51] = "3";
         this._ascii[52] = "4";
         this._ascii[53] = "5";
         this._ascii[54] = "6";
         this._ascii[55] = "7";
         this._ascii[56] = "8";
         this._ascii[57] = "9";
         this._ascii[32] = "Space";
         this._ascii[13] = "Enter";
         this._ascii[17] = "Ctrl";
         this._ascii[16] = "Shift";
         this._ascii[192] = "~";
         this._ascii[38] = "Up";
         this._ascii[40] = "Down";
         this._ascii[37] = "Left";
         this._ascii[39] = "Right";
         this._ascii[96] = "Numpad 0";
         this._ascii[97] = "Numpad 1";
         this._ascii[98] = "Numpad 2";
         this._ascii[99] = "Numpad 3";
         this._ascii[100] = "Numpad 4";
         this._ascii[101] = "Numpad 5";
         this._ascii[102] = "Numpad 6";
         this._ascii[103] = "Numpad 7";
         this._ascii[104] = "Numpad 8";
         this._ascii[105] = "Numpad 9";
         this._ascii[111] = "Numpad /";
         this._ascii[106] = "Numpad *";
         this._ascii[109] = "Numpad -";
         this._ascii[107] = "Numpad +";
         this._ascii[110] = "Numpad .";
         this._ascii[45] = "Insert";
         this._ascii[46] = "Delete";
         this._ascii[33] = "Page Up";
         this._ascii[34] = "Page Down";
         this._ascii[35] = "End";
         this._ascii[36] = "Home";
         this._ascii[112] = "F1";
         this._ascii[113] = "F2";
         this._ascii[114] = "F3";
         this._ascii[115] = "F4";
         this._ascii[116] = "F5";
         this._ascii[117] = "F6";
         this._ascii[118] = "F7";
         this._ascii[119] = "F8";
         this._ascii[188] = ",";
         this._ascii[190] = ".";
         this._ascii[186] = ";";
         this._ascii[222] = "\'";
         this._ascii[219] = "[";
         this._ascii[221] = "]";
         this._ascii[189] = "-";
         this._ascii[187] = "+";
         this._ascii[220] = "\\";
         this._ascii[191] = "/";
         this._ascii[9] = "TAB";
         this._ascii[8] = "Backspace";
         this._ascii[27] = "ESC";
      }
      
      private function mousePress(param1:MouseEvent) : void
      {
         this.isMouseDown = true;
         this._timeMousePressed = getTimer();
      }
      
      private function mouseRelease(param1:MouseEvent) : void
      {
         this.isMouseDown = false;
         this.isMouseReleased = true;
         this._timeMouseReleased = getTimer();
      }
      
      private function mouseMove(param1:MouseEvent) : void
      {
         this.mouseX = param1.stageX - this._stage.x;
         this.mouseY = param1.stageY - this._stage.y;
         this.mousePos.x = this.mouseX;
         this.mousePos.y = this.mouseY;
      }
      
      private function mouseScroll(param1:MouseEvent) : void
      {
         this._hasMouseScrolled = true;
         this.mouseDelta = param1.delta;
      }
      
      private function keyPress(param1:KeyboardEvent) : void
      {
         this._keyState[param1.keyCode] = Math.max(this._keyState[param1.keyCode],1);
         this.lastKeyName = this._ascii[param1.keyCode];
         this.lastKeyCode = param1.keyCode;
         if(this._keyState[param1.keyCode] == 1)
         {
            this._timeKeyPressed = getTimer();
         }
      }
      
      private function keyRelease(param1:KeyboardEvent) : void
      {
         this._keyState[param1.keyCode] = -1;
         var _loc2_:int = this._bufferSize - 1;
         while(_loc2_ > 0)
         {
            this._keyBuffer[_loc2_] = this._keyBuffer[_loc2_ - 1];
            _loc2_--;
         }
         this._keyBuffer[0] = [param1.keyCode,0];
         this._timeKeyReleased = getTimer();
      }
   }
}

class SingletonEnforcer
{
    
   
   function SingletonEnforcer()
   {
      super();
   }
}
