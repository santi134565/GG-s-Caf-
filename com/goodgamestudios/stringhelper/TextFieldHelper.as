package com.goodgamestudios.stringhelper
{
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TextFieldHelper
   {
       
      
      public function TextFieldHelper()
      {
         super();
      }
      
      public static function changeTextFromatSizeByTextWidth(param1:Object, param2:TextField, param3:String, param4:int = 1) : void
      {
         param2.multiline = true;
         param2.wordWrap = true;
         param2.text = param3;
         var _loc5_:TextFormat;
         (_loc5_ = param2.defaultTextFormat).size = param1;
         param2.defaultTextFormat = _loc5_;
         param2.setTextFormat(_loc5_);
         while(param2.numLines > param4 && _loc5_.size > 0)
         {
            param2.defaultTextFormat = _loc5_;
            param2.setTextFormat(_loc5_);
            _loc5_.size = Object(int(_loc5_.size) - 1);
         }
      }
      
      public static function changeTextFromatSizeByMaxHeight(param1:Object, param2:TextField, param3:String) : void
      {
         var _loc4_:Number = param2.height;
         param2.multiline = true;
         param2.wordWrap = true;
         param2.text = param3;
         var _loc5_:TextFormat;
         (_loc5_ = param2.defaultTextFormat).size = param1;
         param2.defaultTextFormat = _loc5_;
         param2.setTextFormat(_loc5_);
         while(param2.textHeight > _loc4_ && _loc5_.size > 0)
         {
            param2.defaultTextFormat = _loc5_;
            param2.setTextFormat(_loc5_);
            _loc5_.size = Object(int(_loc5_.size) - 1);
         }
      }
      
      public static function changeSingleLineTextVerticalAlignInMultiLineTextfield(param1:TextField, param2:Number = 0) : void
      {
         var _loc3_:String = param1.text;
         var _loc4_:TextFormat;
         (_loc4_ = param1.defaultTextFormat).leading = param2;
         param1.defaultTextFormat = _loc4_;
         param1.setTextFormat(_loc4_);
         if(param1.numLines == 1)
         {
            param1.text = " \n" + _loc3_;
            _loc4_.leading = 0 - Number(_loc4_.size) / 2;
            param1.defaultTextFormat = _loc4_;
            param1.setTextFormat(_loc4_);
         }
      }
      
      public static function changeVerticalAlignInMultiLineTextfield(param1:TextField) : void
      {
         var _loc2_:String = param1.text;
         var _loc3_:TextFormat = param1.defaultTextFormat;
         var _loc4_:Number;
         if((_loc4_ = param1.height - (param1.textHeight + Number(_loc3_.leading))) < 0)
         {
            return;
         }
         var _loc5_:uint = Math.floor(_loc4_ / (Number(_loc3_.size) + Number(_loc3_.leading)) / 2);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            param1.text = " \n" + _loc2_;
            _loc2_ = param1.text;
            _loc6_++;
         }
      }
      
      public static function generateStringByValue(param1:int, param2:String, param3:String) : String
      {
         var _loc4_:String = null;
         if(param1 > 1)
         {
            _loc4_ = param1 + " " + param3;
         }
         else
         {
            _loc4_ = param1 + " " + param2;
         }
         return _loc4_;
      }
      
      public static function changeInputDirection(param1:TextField, param2:String) : void
      {
         if(param1.type != TextFieldType.INPUT)
         {
            return;
         }
         var _loc3_:TextFormat = param1.defaultTextFormat;
         switch(param2)
         {
            case "ar":
               _loc3_.align = TextFormatAlign.RIGHT;
               param1.addEventListener(TextEvent.TEXT_INPUT,onTextInput,false,0,true);
               break;
            default:
               _loc3_.align = TextFormatAlign.LEFT;
               if(param1.hasEventListener(TextEvent.TEXT_INPUT))
               {
                  param1.removeEventListener(TextEvent.TEXT_INPUT,onTextInput);
               }
         }
         param1.defaultTextFormat = _loc3_;
      }
      
      private static function onTextInput(param1:TextEvent) : void
      {
         var _loc2_:Array = calcBiDiDisplay(param1.text,"",1000);
         var _loc3_:TextField = param1.target as TextField;
         var _loc4_:String = "";
         while(_loc2_[0].segments.length > 0)
         {
            _loc4_ += _loc2_[0].segments.pop();
         }
         var _loc5_:String = _loc3_.text.slice(0,_loc3_.caretIndex);
         var _loc6_:String = _loc3_.text.slice(_loc3_.caretIndex,_loc3_.text.length);
         _loc3_.text = _loc5_ + _loc4_ + _loc6_;
         param1.preventDefault();
      }
      
      private static function calcBiDiDisplay(param1:String, param2:String, param3:Number, param4:String = "rtl", param5:int = 1) : Array
      {
         var _loc7_:Number = NaN;
         var _loc21_:String = null;
         var _loc22_:int = 0;
         var _loc23_:Array = null;
         var _loc24_:Object = null;
         var _loc25_:int = 0;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc6_:Array = new Array();
         if(param1 == "")
         {
            return _loc6_;
         }
         var _loc8_:String = "";
         var _loc9_:* = "";
         var _loc10_:int = 0;
         while(_loc10_ < param1.length)
         {
            if((_loc7_ = param1.charCodeAt(_loc10_)) == 32 || _loc7_ == 10 || _loc7_ == 12 || _loc7_ == 13)
            {
               _loc9_ += "N";
            }
            if(param1.charAt(_loc10_).indexOf("°$¢£%€₤₧₣₪") != -1)
            {
               _loc9_ += "T";
            }
            else if(_loc7_ >= 33 && _loc7_ <= 47 || _loc7_ >= 58 && _loc7_ <= 64 || _loc7_ >= 91 && _loc7_ <= 96)
            {
               _loc9_ += "W";
            }
            if(_loc7_ >= 48 && _loc7_ <= 57 || _loc7_ >= 1632 && _loc7_ <= 1641)
            {
               _loc9_ += "D";
            }
            if(_loc7_ >= 65 && _loc7_ <= 122)
            {
               _loc9_ += "L";
            }
            if(_loc7_ >= 1488 && _loc7_ <= 1631 || _loc7_ >= 1642 && _loc7_ <= 1790 || _loc7_ >= 64285 && _loc7_ <= 65276)
            {
               _loc9_ += "R";
            }
            if(_loc9_.length != _loc10_ + 1)
            {
               _loc9_ += "L";
            }
            _loc10_++;
         }
         var _loc11_:Array = new Array();
         var _loc12_:String = _loc9_.charAt(0);
         var _loc13_:Object = "";
         var _loc14_:String = "";
         var _loc15_:int = 0;
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            if((_loc21_ = _loc9_.charAt(_loc10_)) != _loc12_)
            {
               _loc11_.push(new Word(_loc13_ as String,_loc12_,_loc15_,_loc14_));
               _loc12_ = _loc21_;
               _loc13_ = param1.charAt(_loc10_);
               _loc14_ = _loc8_.charAt(_loc10_);
               _loc15_++;
            }
            else
            {
               _loc13_ += param1.charAt(_loc10_);
               _loc14_ += _loc8_.charAt(_loc10_);
            }
            _loc10_++;
         }
         if(_loc13_ != "")
         {
            _loc11_.push(new Word(_loc13_ as String,_loc12_,_loc15_,_loc14_));
         }
         _loc12_ = "";
         var _loc16_:String = param5 == -1 ? "R" : "L";
         _loc7_ = 0;
         while(_loc7_ < _loc11_.length)
         {
            _loc21_ = (_loc13_ = _loc11_[_loc7_]).type;
            switch(_loc21_)
            {
               case "W":
                  if(_loc7_ == _loc11_.length - 1 || _loc7_ == 0)
                  {
                     _loc13_.type = _loc16_;
                     _loc21_ = _loc16_;
                  }
                  else if(_loc11_[_loc7_ - 1].type == "D" && _loc11_[_loc7_ + 1].type == "D")
                  {
                     _loc13_.type = "D";
                     _loc21_ = "D";
                  }
                  else
                  {
                     _loc13_.type = "N";
                     _loc21_ = "N";
                  }
                  break;
               case "T":
                  if(_loc11_[_loc7_ - 1].type == "D")
                  {
                     _loc13_.type = "D";
                     _loc21_ = "D";
                  }
                  else
                  {
                     _loc13_.type = "N";
                     _loc21_ = "N";
                  }
                  break;
            }
            _loc7_++;
         }
         var _loc17_:String = _loc16_;
         _loc7_ = 0;
         while(_loc7_ < _loc11_.length)
         {
            if((_loc21_ = (_loc13_ = _loc11_[_loc7_]).type) == "L")
            {
               _loc17_ = "L";
            }
            if(_loc21_ == "R")
            {
               _loc17_ = "R";
            }
            if(_loc17_ == "L" && _loc21_ == "D")
            {
               _loc13_.type = "L";
            }
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc11_.length)
         {
            if((_loc21_ = (_loc13_ = _loc11_[_loc7_]).type) == "N")
            {
               if(_loc11_[_loc7_ - 1].type == _loc11_[_loc7_ + 1].type)
               {
                  _loc13_.type = _loc11_[_loc7_ - 1].type;
               }
               else
               {
                  _loc13_.type = _loc16_;
               }
            }
            _loc7_++;
         }
         var _loc18_:Array = new Array();
         var _loc19_:TextField = new TextField();
         var _loc20_:Number = (_loc12_ = _loc11_[0].type) == "L" ? Number(0) : Number(1);
         _loc19_.wordWrap = false;
         _loc19_.multiline = false;
         if(param4 == "ltr")
         {
            _loc19_.autoSize = "left";
         }
         else
         {
            _loc19_.autoSize = "right";
         }
         _loc19_.text = "";
         _loc19_.width = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc11_.length)
         {
            if((_loc21_ = (_loc13_ = _loc11_[_loc7_]).type) != _loc12_)
            {
               switch(_loc21_)
               {
                  case "R":
                     _loc20_ += 1;
                     break;
                  case "D":
                     if(_loc12_ == "R")
                     {
                        _loc20_ += 1;
                     }
                     else
                     {
                        _loc20_ += 2;
                     }
                     break;
                  case "L":
                     if(_loc12_ == "R")
                     {
                        _loc20_ += 1;
                     }
               }
               _loc12_ = _loc21_;
            }
            _loc13_.EL = _loc20_;
            _loc19_.appendText(_loc13_.text);
            if(_loc19_.width >= param3)
            {
               _loc22_ = _loc18_.length - 1;
               _loc23_ = new Array();
               _loc19_.text = "";
               _loc19_.width = 0;
               while(_loc22_ > 0 && _loc18_[_loc22_].text != " ")
               {
                  _loc23_.push(_loc18_.pop());
                  _loc19_.appendText(_loc23_[_loc23_.length - 1].text);
                  _loc22_ = _loc18_.length - 1;
               }
               _loc6_.push(_loc18_);
               (_loc18_ = _loc23_.slice(0)).push(_loc13_);
               _loc19_.text = _loc13_.text;
            }
            else
            {
               _loc18_.push(_loc13_);
            }
            _loc7_++;
         }
         _loc6_.push(_loc18_);
         _loc10_ = 0;
         while(_loc10_ < _loc6_.length)
         {
            (_loc24_ = _loc6_[_loc10_]).segments = new Array();
            _loc24_.formatSegments = new Array();
            _loc25_ = _loc24_[0].EL;
            _loc26_ = "";
            _loc27_ = "";
            _loc7_ = 0;
            while(_loc7_ < _loc24_.length)
            {
               if(_loc24_[_loc7_].EL != _loc25_)
               {
                  if(_loc25_ % 2 == 0)
                  {
                     _loc24_.segments.push(_loc26_);
                     _loc24_.formatSegments.push(_loc27_);
                  }
                  else
                  {
                     _loc24_.segments.push(reverse(_loc26_));
                     _loc24_.formatSegments.push(reverse(_loc27_));
                  }
                  _loc26_ = _loc24_[_loc7_].text;
                  _loc27_ = _loc24_[_loc7_].format;
               }
               else
               {
                  _loc26_ += _loc24_[_loc7_].text;
                  _loc27_ += _loc24_[_loc7_].format;
               }
               _loc25_ = _loc24_[_loc7_].EL;
               _loc7_++;
            }
            if(_loc25_ % 2 == 0)
            {
               _loc24_.segments.push(_loc26_);
               _loc24_.formatSegments.push(_loc27_);
            }
            else
            {
               _loc24_.segments.push(reverse(manageBrackets(_loc26_)));
               _loc24_.formatSegments.push(reverse(_loc27_));
            }
            if(param5 == -1)
            {
               _loc24_.segments.reverse();
               _loc24_.formatSegments.reverse();
            }
            _loc10_++;
         }
         return _loc6_;
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function manageBrackets(param1:String) : String
      {
         param1 = replace(param1,")","^1^");
         param1 = replace(param1,"(","^2^");
         param1 = replace(param1,"^1^","(");
         param1 = replace(param1,"^2^",")");
         param1 = replace(param1,"]","^1^");
         param1 = replace(param1,"[","^2^");
         param1 = replace(param1,"^1^","[");
         param1 = replace(param1,"^2^","]");
         param1 = replace(param1,"}","^1^");
         param1 = replace(param1,"{","^2^");
         param1 = replace(param1,"^1^","{");
         param1 = replace(param1,"^2^","}");
         param1 = replace(param1,">","^1^");
         param1 = replace(param1,"<","^2^");
         param1 = replace(param1,"^1^",">");
         return replace(param1,"^2^","<");
      }
      
      public static function reverse(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1.charAt(_loc3_) + _loc2_;
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

class Word
{
    
   
   private var _text:String;
   
   private var _type:String;
   
   private var _index:Number;
   
   private var _format:String;
   
   private var _el:Number;
   
   function Word(param1:String, param2:String, param3:Number, param4:String)
   {
      super();
      this._text = param1;
      this._type = param2;
      this._index = param3;
      this._format = param4;
   }
   
   public function get text() : String
   {
      return this._text;
   }
   
   public function set text(param1:String) : void
   {
      this._text = param1;
   }
   
   public function get type() : String
   {
      return this._type;
   }
   
   public function set type(param1:String) : void
   {
      this._type = param1;
   }
   
   public function get index() : Number
   {
      return this._index;
   }
   
   public function set index(param1:Number) : void
   {
      this._index = param1;
   }
   
   public function get format() : String
   {
      return this._format;
   }
   
   public function set format(param1:String) : void
   {
      this._format = param1;
   }
   
   public function get EL() : Number
   {
      return this._el;
   }
   
   public function set EL(param1:Number) : void
   {
      this._el = param1;
   }
}
